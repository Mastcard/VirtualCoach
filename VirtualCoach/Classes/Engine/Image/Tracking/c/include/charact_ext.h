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

int32_t overlappingreg(regchar_t *ref, labels_t *reflabels, labels_t *labels, uint16_t width);

int32_t largerRegion(charact_t *charact);
int32_t regionAtPoint(pt2d_t p);
int32_t regionAtZone(rect_t rect);

#endif /* charact_ext_h */
