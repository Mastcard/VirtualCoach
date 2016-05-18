//
//  TrackingAnalysisProcess.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 11/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "TrackingAnalysisProcess.h"

#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>

#define ALPHA 0.8
#define BETA -1

@interface TrackingAnalysisProcess ()

@property (nonatomic, strong) NSDictionary *videoInfo;
@property (nonatomic, assign) uint8_t binaryThreshold;
@property (nonatomic, assign) rect_t playerBounds;
@property (nonatomic, assign) gray8i_t *referenceFrame;
@property (nonatomic, strong) NSString *framesDirectoryPath;
@property (nonatomic, assign) BOOL canTrack;

- (void)loadReferenceFrame;
- (void)loadTrackingInformations;

@property (nonatomic, assign) regchar_t *previousReg;
@property (nonatomic, assign) labels_t *previousLabels;
@property (nonatomic, assign) float previousGravityCenterSpeed;

@property (nonatomic, strong) NSMutableArray *imageMotionsArray;
@property (nonatomic, assign) int *relevantImageSequences;

//temp
@property (nonatomic, assign) NSUInteger count;

@end

@implementation TrackingAnalysisProcess

- (instancetype)initWithDictionary:(NSDictionary *)videoInfo
{
    self = [super init];
    
    if (self)
    {
        _videoInfo = videoInfo;
        _canTrack = NO;
        _scale = 1.f;
        _imageMotionsArray = [[NSMutableArray alloc] init];
        //temp
        _count = 0;
    }
    
    return self;
}

- (void)loadReferenceFrame
{
    NSString *referenceFramePath = [_videoInfo objectForKey:@"referenceFramePath"];
    
    NSLog(@"referenceFramePath : %@", referenceFramePath);
    
    gray8i_t *originalReferenceFrame = pgmopen([referenceFramePath cStringUsingEncoding:NSASCIIStringEncoding]);
    
    CGImageRef originalReferenceFrameCg = [ImageTools gray8iToCgImage:originalReferenceFrame];
    CGImageRef scaledReferenceFrame = [ImageTools scaleCgimage:originalReferenceFrameCg scale:_scale];
    
    _referenceFrame = [ImageTools cgImageToGrayImage:scaledReferenceFrame];
    
    CGImageRelease(originalReferenceFrameCg);
    CGImageRelease(scaledReferenceFrame);
    gray8ifree(originalReferenceFrame);
}

- (void)loadTrackingInformations
{
    _binaryThreshold = (uint8_t)((NSNumber *)[_videoInfo objectForKey:@"binaryThreshold"]).unsignedCharValue;
    
    NSDictionary *playerBoundsDict = [_videoInfo objectForKey:@"lastPlayerBounds"];
    
    _playerBounds.start.x = ((NSNumber *)[playerBoundsDict objectForKey:@"start.x"]).unsignedIntValue;
    _playerBounds.start.y = ((NSNumber *)[playerBoundsDict objectForKey:@"start.y"]).unsignedIntValue;
    _playerBounds.end.x = ((NSNumber *)[playerBoundsDict objectForKey:@"end.x"]).unsignedIntValue;
    _playerBounds.end.y = ((NSNumber *)[playerBoundsDict objectForKey:@"end.y"]).unsignedIntValue;
}

- (void)setup
{
    [self loadReferenceFrame];
    [self loadTrackingInformations];
    
    // lazy way to avoid the first two images
    [_imageMotionsArray addObject:[NSNumber numberWithInt:0]];
    [_imageMotionsArray addObject:[NSNumber numberWithInt:0]];
    
    _canTrack = YES;
}

- (void)didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    if (_canTrack)
    {
        //temp
        _count++;
        
        CGImageRef rgbImage = [ImageTools cgImageFromSampleBuffer:sampleBuffer];
        CGImageRef rgbImageScaled = [ImageTools scaleCgimage:rgbImage scale:_scale];
        
//        NSString *tmpDir = NSTemporaryDirectory();
//        
//        NSString *imagePath = [tmpDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%lu.pgm", (unsigned long)_count]];
        
        gray8i_t *src = [ImageTools cgImageToGrayImage:rgbImageScaled];
        
        CGImageRelease(rgbImage);
        CGImageRelease(rgbImageScaled);
        
        if (_count == 1)
        {
            gray8i_t *pre_isubstract = subgray8i(src, _referenceFrame);
            bini_t *pre_binary = binarise(pre_isubstract, _binaryThreshold);
            labels_t *pre_labels = label(pre_binary);
            charact_t *pre_characterization = characterize(NULL, src, pre_labels);
            
            rect_t newPLayerBounds;
            newPLayerBounds.start.x = _playerBounds.start.x * _scale;
            newPLayerBounds.start.y = _playerBounds.start.y * _scale;
            newPLayerBounds.end.x = _playerBounds.end.x * _scale;
            newPLayerBounds.end.y = _playerBounds.end.y * _scale;
            
            int32_t playerRegionId = regionAtZone(newPLayerBounds, pre_labels);
            
            gray8ifree(pre_isubstract);
            binifree(pre_binary);
            
            _previousReg = regcharalloc(playerRegionId);
            _previousReg->bounds = newPLayerBounds;
            _previousReg->gravity = pre_characterization->data[playerRegionId-1]->gravity;
            
            charactfree(pre_characterization);
            
            _previousLabels = pre_labels;
        }
        
        else
        {
            gray8i_t *isubstract = subgray8i(src, _referenceFrame);
            
            bini_t *binary = binarise(isubstract, _binaryThreshold);
            
            labels_t *nextLabels = label(binary);
            
            charact_t *ch = characterize(NULL, src, nextLabels);
            
            NSLog(@"count : %lu", (unsigned long)_count);
            
            int32_t bestRegId = overlappingreg(_previousReg, _previousLabels, nextLabels);
            
            printf("bestRegId : %d\n", bestRegId);
            
            if ((bestRegId > 0) && (bestRegId <= ch->count))
            {
                regchar_t *bestReg = ch->data[bestRegId-1];
                
                gray8i_t *cpy = gray8icpy(src);
                
                uint8_t c = 255;
                
                vect2d_t gravvect;
                gravvect.x = (double)bestReg->gravity.x - (double)_previousReg->gravity.x;
                gravvect.y = (double)bestReg->gravity.y - (double)_previousReg->gravity.y;
                
                //printf("gravvect.x : %f, gravvect.y : %f\n", gravvect.x, gravvect.y);
                
                float gravityCenterSpeed = gravCenterSpeed(gravvect, _previousGravityCenterSpeed, ALPHA, BETA);
                
                //printf("gravityCenterSpeed : %f\n", gravityCenterSpeed);
                
                _previousGravityCenterSpeed = gravityCenterSpeed;
                
                unsigned int reg_bounds_x_diff = bestReg->bounds.end.x - bestReg->bounds.start.x;
                float grav_speed_threshold = 0.025 * reg_bounds_x_diff; //0.024593
                //printf("gravityCenterSpeed %f < grav_speed_threshold %f\n", gravityCenterSpeed, grav_speed_threshold);
                
                [_imageMotionsArray addObject:[NSNumber numberWithInt:gravityCenterSpeed < grav_speed_threshold ? 1: 0]];
                
                if (gravityCenterSpeed < grav_speed_threshold)
                {
                    c = 0;
                }
                
                rect_t bds;
                bds.start.y = bestReg->bounds.start.y;
                bds.start.x = bestReg->bounds.start.x;
                bds.end.y = bestReg->bounds.end.y;
                bds.end.x = bestReg->bounds.end.x;
                
                drawrctgray8i(cpy, bds, c);
                
                //pgmwrite(cpy, [imagePath cStringUsingEncoding:NSASCIIStringEncoding], PGM_BINARY);
                
                gray8ifree(cpy);
                
                free(_previousReg);
                _previousReg = regcharcpy(bestReg);
                labfree(_previousLabels);
                _previousLabels = nextLabels;
            }
            
            else
            {
                //pgmwrite(src, [imagePath cStringUsingEncoding:NSASCIIStringEncoding], PGM_BINARY);
                labfree(nextLabels);
            }
            
            
            gray8ifree(isubstract);
            binifree(binary);
            charactfree(ch);
        }
        
        gray8ifree(src);
    }
}

- (NSUInteger)sampleCount
{
    return _count;
}

- (int *)retreiveRelevantImageSequences
{
    int *dst = (int *)calloc(_imageMotionsArray.count, sizeof(int));
    
//    NSLog(@"_imageMotionsArray count : %lu", (unsigned long)_imageMotionsArray.count);
//    
//    NSString *tmpDir = NSTemporaryDirectory();
//
//    NSString *imagePath = [tmpDir stringByAppendingPathComponent:@"relevant-sequences.plist"];
//    
//    NSArray *arry = [_imageMotionsArray copy];
//    
//    [arry writeToFile:imagePath atomically:YES];
    
    for (NSUInteger i = 0; i < _imageMotionsArray.count; i++)
        dst[i] = ((NSNumber *)[_imageMotionsArray objectAtIndex:i]).intValue;
    
    return dst;
}

@end
