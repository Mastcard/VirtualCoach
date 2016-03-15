//
//  charact_ext.c
//  VirtualCoach
//
//  Created by Romain Dubreucq on 23/02/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#include "charact_ext.h"

int32_t overlappingreg(regchar_t *ref, labels_t *reflabels, labels_t *labels, uint16_t width)
{
    uint32_t *count = (uint32_t *)calloc(labels->count, sizeof(uint32_t));
    
    uint32_t id = ref->id;
    pt2d_t start = ref->bounds.start, end = ref->bounds.end;
    
    uint32_t i = 0, j = 0, k = 0;
    
    for (i = start.y; i <= end.y; i++)
    {
        for (j = start.x; j <= end.x; j++)
        {
            uint32_t idx = (uint32_t)PXL_IDX(width, j, i);
            uint32_t reflabel = reflabels->data[idx];
            uint32_t label = labels->data[idx]; // needs to implement width in labels datatype
            
            if ((reflabel == id) && (label > 0))
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