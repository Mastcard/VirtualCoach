//
//  TrackingService.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 11/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "TrackingService.h"

@implementation TrackingService

+ (int32_t)trackRegion:(regchar_t *)reg byOverlapping:(labels_t *)labels withReferenceLabels:(labels_t *)reflabels
{
    uint32_t *count = (uint32_t *)calloc(labels->count, sizeof(uint32_t));
    
    uint32_t id = reg->id;
    uint16_t width = labels->width;
    pt2d_t start = reg->bounds.start, end = reg->bounds.end;
    
    uint32_t i = 0, j = 0, k = 0;
    
    for (i = start.y; i <= end.y; i++)
    {
        for (j = start.x; j <= end.x; j++)
        {
            uint32_t idx = (uint32_t)PXL_IDX(width, j, i);
            uint32_t label = labels->data[idx];
            
            if ((reflabels->data[idx] == id) && (label > 0))
                count[label-1]++;
        }
    }
    
    uint32_t bestReg = UINT32_MAX, bestRegAcc = 0;
    
    for (k = 0; k < labels->count; k++)
    {
        if (count[k] > bestRegAcc)
        {
            bestRegAcc = count[k];
            bestReg = k;
        }
    }
    
    return bestRegAcc == 0 ? -1 : (bestReg + 1);
}

@end
