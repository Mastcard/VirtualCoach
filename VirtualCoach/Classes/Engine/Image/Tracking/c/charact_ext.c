//
//  charact_ext.c
//  VirtualCoach
//
//  Created by Romain Dubreucq on 23/02/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#include "charact_ext.h"

int32_t overlappingreg(regchar_t *ref, labels_t *reflabels, labels_t *labels)
{
    uint32_t *count = (uint32_t *)calloc(labels->count, sizeof(uint32_t));
    
    uint32_t id = ref->id;
    pt2d_t start = ref->bounds.start, end = ref->bounds.end;
    
    uint16_t width = labels->width;
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
    
    free(count);
    
    return bestRegAcc == 0 ? -1 : (bestReg + 1);
}

int32_t largerRegion(charact_t *charact)
{
    int a = 0;
    
    uint32_t firstRegIndex = 0, firstRegSize = 0;
    
    for (a = 0; a < charact->count; a++)
    {
        if (charact->data[a]->size > firstRegSize)
        {
            firstRegSize = charact->data[a]->size;
            firstRegIndex = a;
        }
    }
    
    return firstRegIndex + 1;
}

int32_t regionAtPoint(labels_t *labels, pt2d_t p)
{
    return labels->data[PXL_IDX(labels->width, p.x, p.y)];
}

int32_t regionAtZone(rect_t rect, labels_t *labels)
{
    uint32_t *count = (uint32_t *)calloc(labels->count, sizeof(uint32_t));
    
    pt2d_t start = rect.start, end = rect.end;
    
    uint32_t i = 0, j = 0, k = 0;
    
    for (i = start.y; i <= end.y; i++)
    {
        for (j = start.x; j <= end.x; j++)
        {
            uint32_t label = labels->data[(uint32_t)PXL_IDX(labels->width, j, i)];
            
            if (label > 0)
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
    
    free(count);
    
    return bestRegAcc == 0 ? -1 : (bestReg + 1);
}

int32_t commonPixels(regchar_t *ref, labels_t *reflabels, regchar_t *reg, labels_t *labels)
{
    uint32_t refid = ref->id, regid = reg->id;
    pt2d_t start = ref->bounds.start, end = ref->bounds.end;
    
    uint16_t width = labels->width;
    uint32_t i = 0, j = 0, pixcount = 0;
    
    for (i = start.y; i <= end.y; i++)
    {
        for (j = start.x; j <= end.x; j++)
        {
            uint32_t idx = (uint32_t)PXL_IDX(width, j, i);
            uint32_t reflabel = reflabels->data[idx];
            uint32_t label = labels->data[idx];
            
            //printf("reflabel : %d, label %d (%d, %d)\n", reflabel, label, j, i);
            
            if ((reflabel == refid) && (label == regid))
                pixcount++;
        }
    }
    
    return pixcount;
}