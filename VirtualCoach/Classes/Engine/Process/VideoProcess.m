//
//  VideoProcess.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 10/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "VideoProcess.h"

@interface VideoProcess ()

@property (nonatomic, strong) NSDictionary *videoInfo;

@property (nonatomic, strong) ExtractorVideoDataOutputProcess *extractorProcess;
@property (nonatomic, strong) TrackingAnalysisProcess *trackingAnalysisProcess;

@end

@implementation VideoProcess

- (instancetype)initWithDictionary:(NSDictionary *)videoInfo
{
    self = [super init];
    
    if (self)
    {
        _videoInfo = videoInfo;
    }
    
    return self;
}

- (void)setup
{
    NSString *videoPath = [_videoInfo objectForKey:@"videoPath"];
    _extractorProcess = [[ExtractorVideoDataOutputProcess alloc] initWithFile:videoPath];
    _trackingAnalysisProcess = [[TrackingAnalysisProcess alloc] initWithDictionary:_videoInfo];
    _trackingAnalysisProcess.scale = 0.5;
    [_extractorProcess setDelegate:_trackingAnalysisProcess];
    
    
    
    [_trackingAnalysisProcess setup];
    [_extractorProcess setup];
    
}

- (void)start
{
    [_extractorProcess start];
    
    int *data = [_trackingAnalysisProcess retreiveRelevantImageSequences];
}

- (void)stop
{
    
}

//- (void)trackPlayer
//{
//    gray8i_t *src;
//    
//    int i = 1;
//    
//    NSString *imagePath = [_framesDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.pgm", i]];
//    
//    NSString *imagePathExport = @"";
//    
//    src = pgmopen([imagePath cStringUsingEncoding:NSASCIIStringEncoding]);
//    gray8i_t *pre_isubstract = subgray8i(src, _referenceFrame);
//    bini_t *pre_binary = binarise(pre_isubstract, _binaryThreshold);
//    labels_t *pre_labels = label(pre_binary);
//    int32_t playerRegionId = regionAtZone(_playerBounds, pre_labels);
//    
//    gray8ifree(pre_isubstract);
//    binifree(pre_binary);
//    gray8ifree(src);
//    
//    i++;
//    
//    regchar_t *previousReg = regcharalloc(playerRegionId);
//    previousReg->bounds = _playerBounds;
//    
//    labels_t *previousLabels = pre_labels;
//    
//    uint16_t width = _referenceFrame->width;
//    
//    while ((src = pgmopen([imagePath cStringUsingEncoding:NSASCIIStringEncoding])) != NULL)
//    {
//        gray8i_t *isubstract = subgray8i(src, _referenceFrame);
//        bini_t *binary = binarise(isubstract, _binaryThreshold);
//        
//        //bini_t *eroded = distension(binary, 1);
//        
//        //        gray8i_t *unbinary = unbinarise(binary);
//        //        pgmwrite(unbinary, imagePathExport, PGM_BINARY);
//        //        gray8ifree(unbinary);
//        
//        labels_t *nextLabels = label(binary);
//        
//        charact_t *ch = characterize(NULL, src, nextLabels);
//        
//        printf("i : %d\n", i);
//        
//        int32_t bestRegId = overlappingreg(previousReg, previousLabels, nextLabels, width);
//        
//        printf("bestRegId : %d\n", bestRegId);
//        
//        if ((bestRegId > 0) && (bestRegId <= ch->count))
//        {
//            regchar_t *bestReg = ch->data[bestRegId-1];
//            
//            gray8i_t *cpy = gray8icpy(src);
//            
//            rgb8 c;
//            
//            c.r = 255;
//            c.g = 0;
//            c.b = 0;
//            
//            rect_t bds;
//            bds.start.y = bestReg->bounds.start.y;
//            bds.start.x = bestReg->bounds.start.x;
//            bds.end.y = bestReg->bounds.end.y;
//            bds.end.x = bestReg->bounds.end.x;
//            
//            drawrctgray8i(cpy, bds, 255);
//            
//            imagePathExport = [_framesDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%d-track.pgm", i]];
//            
//            pgmwrite(cpy, [imagePathExport cStringUsingEncoding:NSASCIIStringEncoding], PGM_BINARY);
//            
//            gray8ifree(cpy);
//            
//            free(previousReg);
//            previousReg = regcharcpy(bestReg);
//            labfree(previousLabels);
//            previousLabels = nextLabels;
//        }
//        
//        else
//        {
//            pgmwrite(src, [imagePathExport cStringUsingEncoding:NSASCIIStringEncoding], PGM_BINARY);
//            labfree(nextLabels);
//        }
//        
//        
//        gray8ifree(isubstract);
//        binifree(binary);
//        //binifree(eroded);
//        
//        gray8ifree(src);
//        charactfree(ch);
//        
//        i++;
//        
//        imagePath = [_framesDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.pgm", i]];
//    }
//    
//    puts("Done!");
//}

@end
