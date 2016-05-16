//
//  ExtractorProcess.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 08/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "ExtractorProcess.h"

@interface ExtractorProcess ()

@property (nonatomic, strong) NSString *filePath;
@property (assign) BOOL canExtract;
@property (nonatomic, strong) AVURLAsset *url;
@property (nonatomic, strong) AVAssetReader *reader;
@property (nonatomic, strong) AVAssetReaderTrackOutput *readerTrackOutput;

@end

@implementation ExtractorProcess

- (id)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"-init is not a valid initializer for the class ExtractorProcess (use -initWithFile:filePath)"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initWithFile:(NSString *)filePath
{
    self = [super init];
    
    if (self)
    {
        _filePath = filePath;
        _canExtract = NO;
        
        NSURL *movieURL = [[NSURL alloc] initFileURLWithPath:filePath];
        
        if ([movieURL isFileURL]) _url = [[AVURLAsset alloc] initWithURL:movieURL options:nil];
        else NSLog(@"The specified path does not provide a file");
    }
    
    return self;
}

- (void)setup
{
    NSArray *videoTracks = [_url tracksWithMediaType:AVMediaTypeVideo];
    
    if ([videoTracks count] > 0)
    {
        AVAssetTrack *videoTrack = [videoTracks objectAtIndex:0];
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        [dict setObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(NSString *)kCVPixelBufferPixelFormatTypeKey];
        
        _readerTrackOutput = [[AVAssetReaderTrackOutput alloc] initWithTrack:videoTrack outputSettings:dict];
        
        NSError *error = nil;
        _reader = [[AVAssetReader alloc] initWithAsset:_url error:&error];
        
        // deal with error ?
        
        if([_reader canAddOutput:_readerTrackOutput])
        {
            [_reader addOutput:_readerTrackOutput];
            
            if ([_reader startReading] == YES)
            {
                _canExtract = YES;
                
                NSLog(@"Extractor : file path : %@", self.filePath);
                
                _framesDirectoryPath = [self.filePath stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@", [self.filePath pathExtension]] withString:@""];
                
                NSLog(@"Extractor : directory path : %@", _framesDirectoryPath);
                
                NSFileManager *fileManager= [NSFileManager defaultManager];
                NSError *error = nil;
                
                if(![fileManager createDirectoryAtPath:_framesDirectoryPath withIntermediateDirectories:YES attributes:nil error:&error])
                {
                    _canExtract = NO;
                    NSLog(@"Extractor : failed to create directory \"%@\". Error: %@", _framesDirectoryPath, error);
                }
            }
            
            else
            {
                NSLog(@"Extractor : reader is not starting the reading");
            }
        }
        
        else
        {
            NSLog(@"Extractor : reader can't add output.");
        }
    }
    
    else
    {
        NSLog(@"Extractor : video media type not found in the specified file");
    }
}

- (void)start
{
    if (_canExtract)
    {
        NSUInteger i = 0;
        
        BOOL done = NO;
        
        while (!done)
        {
            CMSampleBufferRef sampleBuffer = [_readerTrackOutput copyNextSampleBuffer];
            
            if (sampleBuffer)
            {
                CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
                CVPixelBufferLockBaseAddress(imageBuffer, 0);
                
                i++;
                
                uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0);
                size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
                size_t width = CVPixelBufferGetWidth(imageBuffer);
                size_t height = CVPixelBufferGetHeight(imageBuffer);
                CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                
                CGContextRef rgbContext = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
                CGImageRef rgbImageRef = CGBitmapContextCreateImage(rgbContext);
                
                // Converting in grayscale
                
                //CGImageRef grayscaleImageRef = CGImageCreateCopyWithColorSpace(rgbImageRef, CGColorSpaceCreateDeviceGray());
                
                // Create image rectangle with current image width/height
                CGRect imageRect = CGRectMake(0, 0, width, height);
                CGColorSpaceRef grayColorSpace = CGColorSpaceCreateDeviceGray();
                CGContextRef grayContext = CGBitmapContextCreate(nil, width, height, 8, 0, grayColorSpace,(CGBitmapInfo)kCGImageAlphaNone);
                CGContextDrawImage(grayContext, imageRect, rgbImageRef);
                
                // Create bitmap image info from pixel data in current context
                CGImageRef grayImageRef = CGBitmapContextCreateImage(grayContext);
                
                CGContextRelease(rgbContext);
                CGContextRelease(grayContext);
                
                NSString *path = [NSString stringWithFormat:@"%@/%lu.pgm", _framesDirectoryPath, (unsigned long)i];
                
                CGDataProviderRef dataProvider = CGImageGetDataProvider(grayImageRef);
                CFDataRef imageData = CGDataProviderCopyData(dataProvider);
                uint8_t *rawData = (uint8_t *)CFDataGetBytePtr(imageData);
                
                gray8i_t *img = gray8iallocwd((uint16_t)width, (uint16_t)height, rawData);
                pgmwrite(img, [path cStringUsingEncoding:NSASCIIStringEncoding], PGM_BINARY);
                gray8ifree(img);
                
                CFRelease(imageData);
                
                CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
                
                CGColorSpaceRelease(colorSpace);
                
                CGImageRelease(rgbImageRef);
                CGImageRelease(grayImageRef);
                
                CFRelease(sampleBuffer);
                sampleBuffer = NULL;
            }
            
            else
            {
                if (_reader.status == AVAssetReaderStatusFailed)
                {
                    NSError *failureError = _reader.error;
                    
                    NSLog(@"%@", failureError.description);
                }
                else
                {
                    done = YES;
                }
            }
        }
        
        NSLog(@"Extractor : all frames have been decoded. (%lu)", (unsigned long)i);
    }
    
    else
    {
        NSLog(@"Extractor can not extract.");
    }
}

- (void)stop
{
    _canExtract = NO;
}

- (void)pause
{
    
}

- (void)resume
{
    
}

- (BOOL)running
{
    return YES;
}

@end
