//
//  charact_ext.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 23/02/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#ifndef charact_ext_h
#define charact_ext_h

#include <characterization.h>
#include <geometry.h>

int32_t overlappingreg(regchar_t *ref, labels_t *reflabels, labels_t *labels);

int32_t largerRegion(charact_t *charact);
int32_t regionAtPoint(labels_t *labels, pt2d_t p);
int32_t regionAtZone(rect_t rect, labels_t *labels);

int32_t commonPixels(regchar_t *ref, labels_t *reflabels, regchar_t *reg, labels_t *labels);

#endif /* charact_ext_h */
