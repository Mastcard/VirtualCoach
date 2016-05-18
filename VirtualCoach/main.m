//
//  main.m
//  VirtualCoach
//
//  Created by Romain Dubreucq on 20/02/2016.
//  Copyright © 2016 Romain Dubreucq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Histogram.h"
#import "KmeanEntry.h"
#import "KmeanEntryDataSet.h"
#import "MotionDeduction.h"
#import "KmeanCalculation.h"
#import "Cluster.h"
#import "opticalflow.h"
#import "io.h"
#import "arithmetic.h"
#import <AVFoundation/AVFoundation.h>

#include <dirent.h>
#include <stdio.h>

int main(int argc, char * argv[]) {
    
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
    
    
    /*
    KmeanEntryDataSet * datasetEntry;
    datasetEntry = [[KmeanEntryDataSet alloc] init];
    
    rect_t interval;
    uint16_t width= 100;
    interval.start.x = 30;
    interval.start.y = 30;
    interval.end.x = 90;
    interval.end.y = 90;
    vect2darray_t * speedVectors0 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors1 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors2 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors3 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors4 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors5 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors6 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors7 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors8 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors9 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors10 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors11 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors12 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors13 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors14 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors15 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors16 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors17 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors18 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors19 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors20 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors21 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors22 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors23 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors24 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors25 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors26 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors27 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors28 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors29 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors30 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors31 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors32 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors33 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors34 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors35 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors36 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors37 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors38 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors39 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors40 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors41 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors42 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors43 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors44 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors45 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors46 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors47 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors48 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors49 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors50 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors51 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors52 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors53 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors54 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors55 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors56 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors57 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors58 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors59 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    vect2darray_t * speedVectors60 = (vect2darray_t *) calloc(1, sizeof(vect2darray_t));
    
    speedVectors0->length=10000;
    speedVectors0->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors1->length=10000;
    speedVectors1->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors2->length=10000;
    speedVectors2->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors3->length=10000;
    speedVectors3->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors4->length=10000;
    speedVectors4->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors5->length=10000;
    speedVectors5->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors6->length=10000;
    speedVectors6->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors7->length=10000;
    speedVectors7->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors8->length=10000;
    speedVectors8->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors9->length=10000;
    speedVectors9->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors10->length=10000;
    speedVectors10->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors11->length=10000;
    speedVectors11->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors12->length=10000;
    speedVectors12->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors13->length=10000;
    speedVectors13->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors14->length=10000;
    speedVectors14->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors15->length=10000;
    speedVectors15->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors16->length=10000;
    speedVectors16->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors17->length=10000;
    speedVectors17->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors18->length=10000;
    speedVectors18->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors19->length=10000;
    speedVectors19->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors20->length=10000;
    speedVectors20->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors21->length=10000;
    speedVectors21->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors22->length=10000;
    speedVectors22->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors23->length=10000;
    speedVectors23->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors24->length=10000;
    speedVectors24->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors25->length=10000;
    speedVectors25->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors26->length=10000;
    speedVectors26->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors27->length=10000;
    speedVectors27->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors28->length=10000;
    speedVectors28->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors29->length=10000;
    speedVectors29->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors30->length=10000;
    speedVectors30->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors31->length=10000;
    speedVectors31->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors32->length=10000;
    speedVectors32->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors33->length=10000;
    speedVectors33->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors34->length=10000;
    speedVectors34->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors35->length=10000;
    speedVectors35->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors36->length=10000;
    speedVectors36->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors37->length=10000;
    speedVectors37->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors38->length=10000;
    speedVectors38->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors39->length=10000;
    speedVectors39->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors40->length=10000;
    speedVectors40->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors41->length=10000;
    speedVectors41->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors42->length=10000;
    speedVectors42->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors43->length=10000;
    speedVectors43->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors44->length=10000;
    speedVectors44->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors45->length=10000;
    speedVectors45->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors46->length=10000;
    speedVectors46->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors47->length=10000;
    speedVectors47->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors48->length=10000;
    speedVectors48->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors49->length=10000;
    speedVectors49->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors50->length=10000;
    speedVectors50->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors51->length=10000;
    speedVectors51->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors52->length=10000;
    speedVectors52->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors53->length=10000;
    speedVectors53->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors54->length=10000;
    speedVectors54->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors55->length=10000;
    speedVectors55->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors56->length=10000;
    speedVectors56->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors57->length=10000;
    speedVectors57->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors58->length=10000;
    speedVectors58->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors59->length=10000;
    speedVectors59->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    speedVectors60->length=10000;
    speedVectors60->data = (vect2d_t *) calloc(10000, sizeof(vect2d_t));
    
    int i =0;
    for (i=0; i<10000; i++) {
        speedVectors0->data[i].x =0;
        speedVectors0->data[i].y =0;
        speedVectors1->data[i].x =0;
        speedVectors1->data[i].y =0;
        speedVectors2->data[i].x =0;
        speedVectors2->data[i].y =0;
        speedVectors3->data[i].x =0;
        speedVectors3->data[i].y =0;
        speedVectors4->data[i].x =0;
        speedVectors4->data[i].y =0;
        speedVectors5->data[i].x =0;
        speedVectors5->data[i].y =0;
        speedVectors6->data[i].x =0;
        speedVectors6->data[i].y =0;
        speedVectors7->data[i].x =0;
        speedVectors7->data[i].y =0;
        speedVectors8->data[i].x =0;
        speedVectors8->data[i].y =0;
        speedVectors9->data[i].x =0;
        speedVectors9->data[i].y =0;
        speedVectors10->data[i].x =0;
        speedVectors10->data[i].y =0;
        speedVectors11->data[i].x =0;
        speedVectors11->data[i].y =0;
        speedVectors12->data[i].x =0;
        speedVectors12->data[i].y =0;
        speedVectors13->data[i].x =0;
        speedVectors13->data[i].y =0;
        speedVectors14->data[i].x =0;
        speedVectors14->data[i].y =0;
        speedVectors15->data[i].x =0;
        speedVectors15->data[i].y =0;
        speedVectors16->data[i].x =0;
        speedVectors16->data[i].y =0;
        speedVectors17->data[i].x =0;
        speedVectors17->data[i].y =0;
        speedVectors18->data[i].x =0;
        speedVectors18->data[i].y =0;
        speedVectors19->data[i].x =0;
        speedVectors19->data[i].y =0;
        speedVectors20->data[i].x =0;
        speedVectors20->data[i].y =0;
        speedVectors21->data[i].x =0;
        speedVectors21->data[i].y =0;
        speedVectors22->data[i].x =0;
        speedVectors22->data[i].y =0;
        speedVectors23->data[i].x =0;
        speedVectors23->data[i].y =0;
        speedVectors24->data[i].x =0;
        speedVectors24->data[i].y =0;
        speedVectors25->data[i].x =0;
        speedVectors25->data[i].y =0;
        speedVectors26->data[i].x =0;
        speedVectors26->data[i].y =0;
        speedVectors27->data[i].x =0;
        speedVectors27->data[i].y =0;
        speedVectors28->data[i].x =0;
        speedVectors28->data[i].y =0;
        speedVectors29->data[i].x =0;
        speedVectors29->data[i].y =0;
        speedVectors30->data[i].x =0;
        speedVectors30->data[i].y =0;
        speedVectors31->data[i].x =0;
        speedVectors31->data[i].y =0;
        speedVectors32->data[i].x =0;
        speedVectors32->data[i].y =0;
        speedVectors33->data[i].x =0;
        speedVectors33->data[i].y =0;
        speedVectors34->data[i].x =0;
        speedVectors34->data[i].y =0;
        speedVectors35->data[i].x =0;
        speedVectors35->data[i].y =0;
        speedVectors36->data[i].x =0;
        speedVectors36->data[i].y =0;
        speedVectors37->data[i].x =0;
        speedVectors37->data[i].y =0;
        speedVectors38->data[i].x =0;
        speedVectors38->data[i].y =0;
        speedVectors39->data[i].x =0;
        speedVectors39->data[i].y =0;
        speedVectors40->data[i].x =0;
        speedVectors40->data[i].y =0;
        speedVectors41->data[i].x =0;
        speedVectors41->data[i].y =0;
        speedVectors42->data[i].x =0;
        speedVectors42->data[i].y =0;
        speedVectors43->data[i].x =0;
        speedVectors43->data[i].y =0;
        speedVectors44->data[i].x =0;
        speedVectors44->data[i].y =0;
        speedVectors45->data[i].x =0;
        speedVectors45->data[i].y =0;
        speedVectors46->data[i].x =0;
        speedVectors46->data[i].y =0;
        speedVectors47->data[i].x =0;
        speedVectors47->data[i].y =0;
        speedVectors48->data[i].x =0;
        speedVectors48->data[i].y =0;
        speedVectors49->data[i].x =0;
        speedVectors49->data[i].y =0;
        speedVectors50->data[i].x =0;
        speedVectors50->data[i].y =0;
        speedVectors51->data[i].x =0;
        speedVectors51->data[i].y =0;
        speedVectors52->data[i].x =0;
        speedVectors52->data[i].y =0;
        speedVectors53->data[i].x =0;
        speedVectors53->data[i].y =0;
        speedVectors54->data[i].x =0;
        speedVectors54->data[i].y =0;
        speedVectors55->data[i].x =0;
        speedVectors55->data[i].y =0;
        speedVectors56->data[i].x =0;
        speedVectors56->data[i].y =0;
        speedVectors57->data[i].x =0;
        speedVectors57->data[i].y =0;
        speedVectors58->data[i].x =0;
        speedVectors58->data[i].y =0;
        speedVectors59->data[i].x =0;
        speedVectors59->data[i].y =0;
        speedVectors60->data[i].x =0;
        speedVectors60->data[i].y =0;
        
    }
    int j=0;
    for (i=interval.start.y; i<interval.end.y; i++) {
        for (j=interval.start.x; j<interval.end.x; j++) {
            speedVectors0->data[PXL_IDX(width, i, j)].x =0;
            speedVectors0->data[PXL_IDX(width, i, j)].y =0;
            speedVectors1->data[PXL_IDX(width, i, j)].x =-50;
            speedVectors1->data[PXL_IDX(width, i, j)].y =0;
            speedVectors2->data[PXL_IDX(width, i, j)].x =-71;
            speedVectors2->data[PXL_IDX(width, i, j)].y =0;
            speedVectors3->data[PXL_IDX(width, i, j)].x =-92;
            speedVectors3->data[PXL_IDX(width, i, j)].y =0;
            speedVectors4->data[PXL_IDX(width, i, j)].x =-114;
            speedVectors4->data[PXL_IDX(width, i, j)].y =0;
            speedVectors5->data[PXL_IDX(width, i, j)].x =-115;
            speedVectors5->data[PXL_IDX(width, i, j)].y =0;
            speedVectors6->data[PXL_IDX(width, i, j)].x =-120;
            speedVectors6->data[PXL_IDX(width, i, j)].y =0;
            speedVectors7->data[PXL_IDX(width, i, j)].x =-225;
            speedVectors7->data[PXL_IDX(width, i, j)].y =0;
            speedVectors8->data[PXL_IDX(width, i, j)].x =-427;
            speedVectors8->data[PXL_IDX(width, i, j)].y =0;
            speedVectors9->data[PXL_IDX(width, i, j)].x =-535;
            speedVectors9->data[PXL_IDX(width, i, j)].y =0;
            speedVectors10->data[PXL_IDX(width, i, j)].x =-540;
            speedVectors10->data[PXL_IDX(width, i, j)].y =0;
            speedVectors11->data[PXL_IDX(width, i, j)].x =-545;
            speedVectors11->data[PXL_IDX(width, i, j)].y =0;
            speedVectors12->data[PXL_IDX(width, i, j)].x =-550;
            speedVectors12->data[PXL_IDX(width, i, j)].y =0;
            speedVectors13->data[PXL_IDX(width, i, j)].x =-555;
            speedVectors13->data[PXL_IDX(width, i, j)].y =0;
            speedVectors14->data[PXL_IDX(width, i, j)].x =-560;
            speedVectors14->data[PXL_IDX(width, i, j)].y =0;
            speedVectors15->data[PXL_IDX(width, i, j)].x =-562;
            speedVectors15->data[PXL_IDX(width, i, j)].y =0;
            speedVectors16->data[PXL_IDX(width, i, j)].x =-565;
            speedVectors16->data[PXL_IDX(width, i, j)].y =0;
            speedVectors17->data[PXL_IDX(width, i, j)].x =-570;
            speedVectors17->data[PXL_IDX(width, i, j)].y =0;
            speedVectors18->data[PXL_IDX(width, i, j)].x =-561;
            speedVectors18->data[PXL_IDX(width, i, j)].y =0;
            speedVectors19->data[PXL_IDX(width, i, j)].x =-553;
            speedVectors19->data[PXL_IDX(width, i, j)].y =0;
            speedVectors20->data[PXL_IDX(width, i, j)].x =-544;
            speedVectors20->data[PXL_IDX(width, i, j)].y =0;
            speedVectors21->data[PXL_IDX(width, i, j)].x =-535;
            speedVectors21->data[PXL_IDX(width, i, j)].y =0;
            speedVectors22->data[PXL_IDX(width, i, j)].x =-526;
            speedVectors22->data[PXL_IDX(width, i, j)].y =0;
            speedVectors23->data[PXL_IDX(width, i, j)].x =-517;
            speedVectors23->data[PXL_IDX(width, i, j)].y =0;
            speedVectors24->data[PXL_IDX(width, i, j)].x =-508;
            speedVectors24->data[PXL_IDX(width, i, j)].y =0;
            speedVectors25->data[PXL_IDX(width, i, j)].x =-480;
            speedVectors25->data[PXL_IDX(width, i, j)].y =0;
            speedVectors26->data[PXL_IDX(width, i, j)].x =470;
            speedVectors26->data[PXL_IDX(width, i, j)].y =0;
            speedVectors27->data[PXL_IDX(width, i, j)].x =420;
            speedVectors27->data[PXL_IDX(width, i, j)].y =0;
            speedVectors28->data[PXL_IDX(width, i, j)].x =360;
            speedVectors28->data[PXL_IDX(width, i, j)].y =0;
            speedVectors29->data[PXL_IDX(width, i, j)].x =310;
            speedVectors29->data[PXL_IDX(width, i, j)].y =0;
            speedVectors30->data[PXL_IDX(width, i, j)].x =100;
            speedVectors30->data[PXL_IDX(width, i, j)].y =0;
            
            speedVectors31->data[PXL_IDX(width, i, j)].x =150;
            speedVectors31->data[PXL_IDX(width, i, j)].y =0;
            speedVectors32->data[PXL_IDX(width, i, j)].x =200;
            speedVectors32->data[PXL_IDX(width, i, j)].y =0;
            speedVectors33->data[PXL_IDX(width, i, j)].x =250;
            speedVectors33->data[PXL_IDX(width, i, j)].y =0;
            speedVectors34->data[PXL_IDX(width, i, j)].x =260;
            speedVectors34->data[PXL_IDX(width, i, j)].y =0;
            speedVectors35->data[PXL_IDX(width, i, j)].x =270;
            speedVectors35->data[PXL_IDX(width, i, j)].y =0;
            speedVectors36->data[PXL_IDX(width, i, j)].x =400;
            speedVectors36->data[PXL_IDX(width, i, j)].y =0;
            speedVectors37->data[PXL_IDX(width, i, j)].x =410;
            speedVectors37->data[PXL_IDX(width, i, j)].y =0;
            speedVectors38->data[PXL_IDX(width, i, j)].x =420;
            speedVectors38->data[PXL_IDX(width, i, j)].y =0;
            speedVectors39->data[PXL_IDX(width, i, j)].x =450;
            speedVectors39->data[PXL_IDX(width, i, j)].y =0;
            speedVectors40->data[PXL_IDX(width, i, j)].x =470;
            speedVectors40->data[PXL_IDX(width, i, j)].y =0;
            speedVectors41->data[PXL_IDX(width, i, j)].x =480;
            speedVectors41->data[PXL_IDX(width, i, j)].y =0;
            speedVectors42->data[PXL_IDX(width, i, j)].x =550;
            speedVectors42->data[PXL_IDX(width, i, j)].y =0;
            speedVectors43->data[PXL_IDX(width, i, j)].x =600;
            speedVectors43->data[PXL_IDX(width, i, j)].y =0;
            speedVectors44->data[PXL_IDX(width, i, j)].x =750;
            speedVectors44->data[PXL_IDX(width, i, j)].y =0;
            speedVectors45->data[PXL_IDX(width, i, j)].x =800;
            speedVectors45->data[PXL_IDX(width, i, j)].y =0;
            speedVectors46->data[PXL_IDX(width, i, j)].x =1400;
            speedVectors46->data[PXL_IDX(width, i, j)].y =0;
            speedVectors47->data[PXL_IDX(width, i, j)].x =1800;
            speedVectors47->data[PXL_IDX(width, i, j)].y =0;
            speedVectors48->data[PXL_IDX(width, i, j)].x =2000;
            speedVectors48->data[PXL_IDX(width, i, j)].y =0;
            speedVectors49->data[PXL_IDX(width, i, j)].x =2550;
            speedVectors49->data[PXL_IDX(width, i, j)].y =0;
            speedVectors50->data[PXL_IDX(width, i, j)].x =3000;
            speedVectors50->data[PXL_IDX(width, i, j)].y =0;
            speedVectors51->data[PXL_IDX(width, i, j)].x =2000;
            speedVectors51->data[PXL_IDX(width, i, j)].y =0;
            speedVectors52->data[PXL_IDX(width, i, j)].x =1500;
            speedVectors52->data[PXL_IDX(width, i, j)].y =0;
            speedVectors53->data[PXL_IDX(width, i, j)].x =1000;
            speedVectors53->data[PXL_IDX(width, i, j)].y =0;
            speedVectors54->data[PXL_IDX(width, i, j)].x =500;
            speedVectors54->data[PXL_IDX(width, i, j)].y =0;
            speedVectors55->data[PXL_IDX(width, i, j)].x =-400;
            speedVectors55->data[PXL_IDX(width, i, j)].y =0;
            speedVectors56->data[PXL_IDX(width, i, j)].x =-300;
            speedVectors56->data[PXL_IDX(width, i, j)].y =0;
            speedVectors57->data[PXL_IDX(width, i, j)].x =-200;
            speedVectors57->data[PXL_IDX(width, i, j)].y =0;
            speedVectors58->data[PXL_IDX(width, i, j)].x =-50;
            speedVectors58->data[PXL_IDX(width, i, j)].y =0;
            speedVectors59->data[PXL_IDX(width, i, j)].x =-30;
            speedVectors59->data[PXL_IDX(width, i, j)].y =0;
            speedVectors60->data[PXL_IDX(width, i, j)].x =-10;
            speedVectors60->data[PXL_IDX(width, i, j)].y =0;

        }
    }
    
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors0 andSecondSpeedVectorsTab:speedVectors1 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors1 andSecondSpeedVectorsTab:speedVectors2 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors2 andSecondSpeedVectorsTab:speedVectors3 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors3 andSecondSpeedVectorsTab:speedVectors4 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors4 andSecondSpeedVectorsTab:speedVectors5 betweenInterval:interval andWithImageWidth:width];
    
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors5 andSecondSpeedVectorsTab:speedVectors6 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors6 andSecondSpeedVectorsTab:speedVectors7 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors7 andSecondSpeedVectorsTab:speedVectors8 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors8 andSecondSpeedVectorsTab:speedVectors9 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors9 andSecondSpeedVectorsTab:speedVectors10 betweenInterval:interval andWithImageWidth:width];
    
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors10 andSecondSpeedVectorsTab:speedVectors11 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors11 andSecondSpeedVectorsTab:speedVectors12 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors12 andSecondSpeedVectorsTab:speedVectors13 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors13 andSecondSpeedVectorsTab:speedVectors14 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors14 andSecondSpeedVectorsTab:speedVectors15 betweenInterval:interval andWithImageWidth:width];
    
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors15 andSecondSpeedVectorsTab:speedVectors16 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors16 andSecondSpeedVectorsTab:speedVectors17 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors17 andSecondSpeedVectorsTab:speedVectors18 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors18 andSecondSpeedVectorsTab:speedVectors19 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors19 andSecondSpeedVectorsTab:speedVectors20 betweenInterval:interval andWithImageWidth:width];
    
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors20 andSecondSpeedVectorsTab:speedVectors21 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors21 andSecondSpeedVectorsTab:speedVectors22 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors22 andSecondSpeedVectorsTab:speedVectors23 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors23 andSecondSpeedVectorsTab:speedVectors24 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors24 andSecondSpeedVectorsTab:speedVectors25 betweenInterval:interval andWithImageWidth:width];
    
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors25 andSecondSpeedVectorsTab:speedVectors26 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors26 andSecondSpeedVectorsTab:speedVectors27 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors27 andSecondSpeedVectorsTab:speedVectors28 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors28 andSecondSpeedVectorsTab:speedVectors29 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors29 andSecondSpeedVectorsTab:speedVectors30 betweenInterval:interval andWithImageWidth:width];
    
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors30 andSecondSpeedVectorsTab:speedVectors31 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors31 andSecondSpeedVectorsTab:speedVectors32 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors32 andSecondSpeedVectorsTab:speedVectors33 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors33 andSecondSpeedVectorsTab:speedVectors34 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors34 andSecondSpeedVectorsTab:speedVectors35 betweenInterval:interval andWithImageWidth:width];
    
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors35 andSecondSpeedVectorsTab:speedVectors36 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors36 andSecondSpeedVectorsTab:speedVectors37 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors37 andSecondSpeedVectorsTab:speedVectors38 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors38 andSecondSpeedVectorsTab:speedVectors39 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors39 andSecondSpeedVectorsTab:speedVectors40 betweenInterval:interval andWithImageWidth:width];
    
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors40 andSecondSpeedVectorsTab:speedVectors41 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors41 andSecondSpeedVectorsTab:speedVectors42 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors42 andSecondSpeedVectorsTab:speedVectors43 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors43 andSecondSpeedVectorsTab:speedVectors44 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors44 andSecondSpeedVectorsTab:speedVectors45 betweenInterval:interval andWithImageWidth:width];
    
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors45 andSecondSpeedVectorsTab:speedVectors46 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors46 andSecondSpeedVectorsTab:speedVectors47 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors47 andSecondSpeedVectorsTab:speedVectors48 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors48 andSecondSpeedVectorsTab:speedVectors49 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors49 andSecondSpeedVectorsTab:speedVectors50 betweenInterval:interval andWithImageWidth:width];
    
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors50 andSecondSpeedVectorsTab:speedVectors51 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors51 andSecondSpeedVectorsTab:speedVectors52 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors52 andSecondSpeedVectorsTab:speedVectors53 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors53 andSecondSpeedVectorsTab:speedVectors54 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors54 andSecondSpeedVectorsTab:speedVectors55 betweenInterval:interval andWithImageWidth:width];
    
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors55 andSecondSpeedVectorsTab:speedVectors56 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors56 andSecondSpeedVectorsTab:speedVectors57 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors57 andSecondSpeedVectorsTab:speedVectors58 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors58 andSecondSpeedVectorsTab:speedVectors59 betweenInterval:interval andWithImageWidth:width];
    [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:speedVectors59 andSecondSpeedVectorsTab:speedVectors60 betweenInterval:interval andWithImageWidth:width];
    
    //NSLog(@"%d",(unsigned int)datasetEntry.datacount);
    
    NSString * filePathKmeanEntryDataset = @"/Users/bizoro/Documents/master2/Projet_Synthese/VirtualCoach/KmeanEntryDataSetMainTest.plist";
    [datasetEntry writeKmeanDatasetAtPath:filePathKmeanEntryDataset];
    
    [datasetEntry writeKmeanDatasetForTestAtPath:@"/Users/bizoro/Documents/master2/Projet_Synthese/VirtualCoach/KmeanEntryDataSetMainTest30032016.txt"];
    //(void)writeKmeanDatasetRorTestAtPath:(NSString *)path
    
    KmeanCalculation * kmeanCalculation = [[KmeanCalculation alloc]initKmeanCalculationWithPathOfDataEntries:filePathKmeanEntryDataset andClusterCount:2];
    [kmeanCalculation kmeanProcessWithMaxIteration:60];
    
    NSLog(@"%d %d", [[kmeanCalculation.clusters objectAtIndex:0] countMember] , [[kmeanCalculation.clusters objectAtIndex:1] countMember]);
    
    //NSLog(@"%d %d %d", [[kmeanCalculation.clusters objectAtIndex:0] countMember] , [[kmeanCalculation.clusters objectAtIndex:1] countMember] , [[kmeanCalculation.clusters objectAtIndex:2] countMember]);
    
    NSLog(@"%d %f", [((Cluster *)[kmeanCalculation.clusters objectAtIndex:0]) center].time, [((Cluster *)[kmeanCalculation.clusters objectAtIndex:0]) center].meanAcceleration );
    
    NSLog(@"%d %f", [((Cluster *)[kmeanCalculation.clusters objectAtIndex:1]) center].time, [((Cluster *)[kmeanCalculation.clusters objectAtIndex:1]) center].meanAcceleration );
    
    //NSLog(@"%d %f", [((Cluster *)[kmeanCalculation.clusters objectAtIndex:2]) center].time, [((Cluster *)[kmeanCalculation.clusters objectAtIndex:2]) center].meanAcceleration );
    */
    
    /*
    NSString *sourcePath = @"/Users/bizoro/Documents/master2/Projet_Synthese/eloise";
    NSArray* dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:sourcePath
                                                                        error:NULL];
    NSMutableArray *ppmFiles = [[NSMutableArray alloc] init];
    [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = (NSString *)obj;
        NSString *extension = [[filename pathExtension] lowercaseString];
        if ([extension isEqualToString:@"ppm"]) {
            [ppmFiles addObject:[sourcePath stringByAppendingPathComponent:filename]];
        }
    }];
    
    NSLog(@"countFiles: %lu", (unsigned long)ppmFiles.count);
    
    Histogram * angleHistogram = [[Histogram alloc] init];
    KmeanEntryDataSet * datasetEntry = [[KmeanEntryDataSet alloc] init];
    for(int i=265; i<325; i++){
        //vect2darray_t *opticalflow(gray8i_t *image1, gray8i_t *image2);
        // rgb8i_t *ppmopen(const char *filename);
        // gray8i_t *grayscale(rgb8i_t *src);
        rgb8i_t * img1Rgb;
        rgb8i_t * img2Rgb;
        rgb8i_t * img3Rgb;
        gray8i_t * img1Gray;
        gray8i_t * img2Gray;
        gray8i_t * img3Gray;
        // v1;
        
        if(i < ppmFiles.count-2){
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i]);
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i+1]);
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i+2]);
            //NSLog(@"########################################################");
            
            img1Rgb = ppmopen([[ppmFiles objectAtIndex:i] UTF8String]);
            img2Rgb = ppmopen([[ppmFiles objectAtIndex:i+1] UTF8String]);
            img3Rgb = ppmopen([[ppmFiles objectAtIndex:i+2] UTF8String]);
            img1Gray = grayscale(img1Rgb);
            img2Gray = grayscale(img2Rgb);
            img3Gray = grayscale(img3Rgb);
            rect_t interval;
            interval.start.x = 0;
            interval.start.y = 0;
            interval.end.x = img2Gray->width;
            interval.end.y = img2Gray->height;
            vect2darray_t * v1 = opticalflow(img1Gray, img2Gray);
            vect2darray_t * v2 = opticalflow(img2Gray, img3Gray);
            
            //for (int j=0; j<v2->length; j++) {
              //  NSLog(@"x: %lf and y: %lf for v1", v1->data[j].x, v1->data[j].y);
              //  NSLog(@"x: %lf and y: %lf for v2", v2->data[j].x, v2->data[j].y);
            //}
            
            //NSLog(@"v1: %d and v2: %d", v1->length, v2->length);
            //NSLog(@"#######################################################");
            [angleHistogram generateHistogramFromSpeedVector:v1 betweenInterval:interval andWithImageWidth:img2Gray->width];
            [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:v1 andSecondSpeedVectorsTab:v2 betweenInterval:interval andWithImageWidth:img2Gray->width];
            
        }else if(i < ppmFiles.count-1){
            img1Rgb = ppmopen([[ppmFiles objectAtIndex:i] UTF8String]);
            img2Rgb = ppmopen([[ppmFiles objectAtIndex:i+1] UTF8String]);
            img1Gray = grayscale(img1Rgb);
            img2Gray = grayscale(img2Rgb);
            rect_t interval;
            interval.start.x = 0;
            interval.start.y = 0;
            interval.end.x = img2Gray->width;
            interval.end.y = img2Gray->height;
            vect2darray_t * v1 = opticalflow(img1Gray, img2Gray);
            [angleHistogram generateHistogramFromSpeedVector:v1 betweenInterval:interval andWithImageWidth:img2Gray->width];
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i]);
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i+1]);
            //NSLog(@"########################################################");
        }
        
    }
    
    NSString * filePathKmeanEntryDatasetPlist = @"/Users/bizoro/Documents/master2/Projet_Synthese/VirtualCoach/KmeanEntryDataSetMainTest_27042016.plist";
    NSString * filePathKmeanEntryDatasetTxt = @"/Users/bizoro/Documents/master2/Projet_Synthese/VirtualCoach/KmeanEntryDataSetMainTest_27042016.txt";
    NSString * fileHistogramTxt = @"/Users/bizoro/Documents/master2/Projet_Synthese/VirtualCoach/HistogramTest_27042016.txt";
    [datasetEntry writeKmeanDatasetAtPath:filePathKmeanEntryDatasetPlist];
    //NSString * filePathHistogram = @"/Users/bizoro/Documents/master2/Projet_Synthese/VirtualCoach/HistogramMainTest_27042016.plist";
    //[angleHistogram writeHistogramAtPath:filePathHistogram];
    
    [datasetEntry writeKmeanDatasetForTestAtPath:filePathKmeanEntryDatasetTxt];
    [angleHistogram writeHistogramForTestAtPath:fileHistogramTxt];
    
    KmeanCalculation * kmeanCalculation = [[KmeanCalculation alloc]initKmeanCalculationWithPathOfDataEntries:filePathKmeanEntryDatasetPlist andClusterCount:2];
    [kmeanCalculation kmeanProcessWithMaxIteration:60];
    
    //NSLog(@"%d %d %d", [[kmeanCalculation.clusters objectAtIndex:0] countMember] , [[kmeanCalculation.clusters objectAtIndex:1] countMember] , [[kmeanCalculation.clusters objectAtIndex:2] countMember]);
    
    NSLog(@"%d %d", [[kmeanCalculation.clusters objectAtIndex:0] countMember] , [[kmeanCalculation.clusters objectAtIndex:1] countMember]);
    
    //NSLog(@"%d %d %d %d", [[kmeanCalculation.clusters objectAtIndex:0] countMember] , [[kmeanCalculation.clusters objectAtIndex:1] countMember] , [[kmeanCalculation.clusters objectAtIndex:2] countMember], [[kmeanCalculation.clusters objectAtIndex:3] countMember]);
    
    NSLog(@"%d %f", [((Cluster *)[kmeanCalculation.clusters objectAtIndex:0]) center].time, [((Cluster *)[kmeanCalculation.clusters objectAtIndex:0]) center].meanAcceleration );
    
    NSLog(@"%d %f", [((Cluster *)[kmeanCalculation.clusters objectAtIndex:1]) center].time, [((Cluster *)[kmeanCalculation.clusters objectAtIndex:1]) center].meanAcceleration );
    */
    
    /*
    // ########### Coup droit éloïse 1 ###############
    
    NSString *sourcePath = @"/Users/bizoro/Documents/master2/Projet_Synthese/trouducul";
    NSArray* dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:sourcePath
                                                                        error:NULL];
    NSMutableArray *pgmFiles = [[NSMutableArray alloc] init];
    [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = (NSString *)obj;
        NSString *extension = [[filename pathExtension] lowercaseString];
        if ([extension isEqualToString:@"pgm"]) {
            [pgmFiles addObject:[sourcePath stringByAppendingPathComponent:filename]];
        }
    }];
    
    NSLog(@"countFiles: %lu", (unsigned long)pgmFiles.count);
    
    Histogram * angleHistogram = [[Histogram alloc] init];
    KmeanEntryDataSet * datasetEntry = [[KmeanEntryDataSet alloc] init];
    for(int i=203; i<233; i++){
        
        gray8i_t * img1Gray;
        gray8i_t * img2Gray;
        gray8i_t * img3Gray;
        
        if(i < pgmFiles.count-2){
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i]);
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i+1]);
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i+2]);
            //NSLog(@"########################################################");
            
            img1Gray = pgmopen([[pgmFiles objectAtIndex:i] UTF8String]);
            img2Gray = pgmopen([[pgmFiles objectAtIndex:i+1] UTF8String]);
            img3Gray = pgmopen([[pgmFiles objectAtIndex:i+2] UTF8String]);
            
            rect_t interval;
            interval.start.x = 330;
            interval.start.y = 165;
            interval.end.x = 528;
            interval.end.y = 318;
            //interval.start.x = 0;
            //interval.start.y = 0;
            //interval.end.x = img2Gray->width;
            //interval.end.y = img2Gray->height;
            vect2darray_t * v1 = opticalflow(img1Gray, img2Gray);
            vect2darray_t * v2 = opticalflow(img2Gray, img3Gray);
            
            //for (int j=0; j<v2->length; j++) {
            //  NSLog(@"x: %lf and y: %lf for v1", v1->data[j].x, v1->data[j].y);
            //  NSLog(@"x: %lf and y: %lf for v2", v2->data[j].x, v2->data[j].y);
            //}
            
            //NSLog(@"v1: %d and v2: %d", v1->length, v2->length);
            //NSLog(@"#######################################################");
            [angleHistogram generateHistogramFromSpeedVector:v1 betweenInterval:interval andWithImageWidth:img2Gray->width];
            [datasetEntry addKmeanEntryToDataSetFromFirstSpeedVectorsTab:v1 andSecondSpeedVectorsTab:v2 betweenInterval:interval andWithImageWidth:img2Gray->width];
            
        }else if(i < pgmFiles.count-1){
            img1Gray = pgmopen([[pgmFiles objectAtIndex:i] UTF8String]);
            img2Gray = pgmopen([[pgmFiles objectAtIndex:i+1] UTF8String]);
            
            rect_t interval;
            interval.start.x = 330;
            interval.start.y = 165;
            interval.end.x = 528;
            interval.end.y = 318;
            vect2darray_t * v1 = opticalflow(img1Gray, img2Gray);
            [angleHistogram generateHistogramFromSpeedVector:v1 betweenInterval:interval andWithImageWidth:img2Gray->width];
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i]);
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i+1]);
            //NSLog(@"########################################################");
        }
        
    }
    
    NSString * filePathKmeanEntryDatasetPlist = @"/Users/bizoro/Documents/master2/Projet_Synthese/VirtualCoach/MainTestCoupDroitEloise/KmeanEntryDataSetMainTestCoupDroit1_11052016.plist";
    NSString * filePathKmeanEntryDatasetTxt = @"/Users/bizoro/Documents/master2/Projet_Synthese/VirtualCoach/MainTestCoupDroitEloise/KmeanEntryDataSetMainTestCoupDroit1_11052016.txt";
    NSString * fileHistogramTxt = @"/Users/bizoro/Documents/master2/Projet_Synthese/VirtualCoach/MainTestCoupDroitEloise/HistogramTestCoupDroit1_11052016.txt";
    [datasetEntry writeKmeanDatasetAtPath:filePathKmeanEntryDatasetPlist];
    //NSString * filePathHistogram = @"/Users/bizoro/Documents/master2/Projet_Synthese/VirtualCoach/HistogramMainTest_04052016.plist";
    //[angleHistogram writeHistogramAtPath:filePathHistogram];
    
    [datasetEntry writeKmeanDatasetForTestAtPath:filePathKmeanEntryDatasetTxt];
    [angleHistogram writeHistogramForTestAtPath:fileHistogramTxt];
    
    KmeanCalculation * kmeanCalculation = [[KmeanCalculation alloc]initKmeanCalculationWithPathOfDataEntries:filePathKmeanEntryDatasetPlist andClusterCount:3];
    [kmeanCalculation kmeanProcessWithMaxIteration:60];
    
    NSLog(@"%d %d %d", [[kmeanCalculation.clusters objectAtIndex:0] countMember] , [[kmeanCalculation.clusters objectAtIndex:1] countMember] , [[kmeanCalculation.clusters objectAtIndex:2] countMember]);
    
    //NSLog(@"%d %d", [[kmeanCalculation.clusters objectAtIndex:0] countMember] , [[kmeanCalculation.clusters objectAtIndex:1] countMember]);
    
    //NSLog(@"%d %d %d %d", [[kmeanCalculation.clusters objectAtIndex:0] countMember] , [[kmeanCalculation.clusters objectAtIndex:1] countMember] , [[kmeanCalculation.clusters objectAtIndex:2] countMember], [[kmeanCalculation.clusters objectAtIndex:3] countMember]);
    
    NSLog(@"%d %f", [((Cluster *)[kmeanCalculation.clusters objectAtIndex:0]) center].time, [((Cluster *)[kmeanCalculation.clusters objectAtIndex:0]) center].meanAcceleration );
    
    NSLog(@"%d %f", [((Cluster *)[kmeanCalculation.clusters objectAtIndex:1]) center].time, [((Cluster *)[kmeanCalculation.clusters objectAtIndex:1]) center].meanAcceleration );
    
    NSLog(@"%d %f", [((Cluster *)[kmeanCalculation.clusters objectAtIndex:2]) center].time, [((Cluster *)[kmeanCalculation.clusters objectAtIndex:2]) center].meanAcceleration );
    
    //NSLog(@"%d %f", [((Cluster *)[kmeanCalculation.clusters objectAtIndex:3]) center].time, [((Cluster *)[kmeanCalculation.clusters objectAtIndex:3]) center].meanAcceleration );
    
    NSString * angleMax = [MotionDeduction recognizeTennisMotionWithHistogram:angleHistogram andLeftHanded:false];
    
    NSLog(@"déduction: %@", angleMax);
    
    
    // ########### Coup droit éloïse 2 ###############
    
    NSString *sourcePath2 = @"/Users/bizoro/Documents/master2/Projet_Synthese/trouducul";
    NSArray* dirs2 = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:sourcePath
                                                                        error:NULL];
    NSMutableArray *pgmFiles2 = [[NSMutableArray alloc] init];
    [dirs2 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = (NSString *)obj;
        NSString *extension = [[filename pathExtension] lowercaseString];
        if ([extension isEqualToString:@"pgm"]) {
            [pgmFiles2 addObject:[sourcePath2 stringByAppendingPathComponent:filename]];
        }
    }];
    
    NSLog(@"\n");
    NSLog(@"###############################################");
    NSLog(@"countFiles: %lu", (unsigned long)pgmFiles2.count);
    
    Histogram * angleHistogram2 = [[Histogram alloc] init];
    KmeanEntryDataSet * datasetEntry2 = [[KmeanEntryDataSet alloc] init];
    for(int i=280; i<310; i++){

        gray8i_t * img1Gray;
        gray8i_t * img2Gray;
        gray8i_t * img3Gray;
        
        if(i < pgmFiles2.count-2){
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i]);
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i+1]);
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i+2]);
            //NSLog(@"########################################################");
            
            img1Gray = pgmopen([[pgmFiles2 objectAtIndex:i] UTF8String]);
            img2Gray = pgmopen([[pgmFiles2 objectAtIndex:i+1] UTF8String]);
            img3Gray = pgmopen([[pgmFiles2 objectAtIndex:i+2] UTF8String]);

            rect_t interval;
            interval.start.x = 390;
            interval.start.y = 202;
            interval.end.x = 568;
            interval.end.y = 328;
            //interval.start.x = 0;
            //interval.start.y = 0;
            //interval.end.x = img2Gray->width;
            //interval.end.y = img2Gray->height;
            vect2darray_t * v1 = opticalflow(img1Gray, img2Gray);
            vect2darray_t * v2 = opticalflow(img2Gray, img3Gray);
            
            //for (int j=0; j<v2->length; j++) {
            //  NSLog(@"x: %lf and y: %lf for v1", v1->data[j].x, v1->data[j].y);
            //  NSLog(@"x: %lf and y: %lf for v2", v2->data[j].x, v2->data[j].y);
            //}
            
            //NSLog(@"v1: %d and v2: %d", v1->length, v2->length);
            //NSLog(@"#######################################################");
            [angleHistogram2 generateHistogramFromSpeedVector:v1 betweenInterval:interval andWithImageWidth:img2Gray->width];
            [datasetEntry2 addKmeanEntryToDataSetFromFirstSpeedVectorsTab:v1 andSecondSpeedVectorsTab:v2 betweenInterval:interval andWithImageWidth:img2Gray->width];
            
        }else if(i < pgmFiles2.count-1){
            img1Gray = pgmopen([[pgmFiles2 objectAtIndex:i] UTF8String]);
            img2Gray = pgmopen([[pgmFiles2 objectAtIndex:i+1] UTF8String]);
            
            rect_t interval;
            interval.start.x = 390;
            interval.start.y = 202;
            interval.end.x = 568;
            interval.end.y = 328;
            vect2darray_t * v1 = opticalflow(img1Gray, img2Gray);
            [angleHistogram2 generateHistogramFromSpeedVector:v1 betweenInterval:interval andWithImageWidth:img2Gray->width];
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i]);
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i+1]);
            //NSLog(@"########################################################");
        }
        
    }
    
    NSString * filePathKmeanEntryDatasetPlist2 = @"/Users/bizoro/Documents/master2/Projet_Synthese/VirtualCoach/MainTestCoupDroitEloise/KmeanEntryDataSetMainTestCoupDroit2_11052016.plist";
    NSString * filePathKmeanEntryDatasetTxt2 = @"/Users/bizoro/Documents/master2/Projet_Synthese/VirtualCoach/MainTestCoupDroitEloise/KmeanEntryDataSetMainTestCoupDroit2_11052016.txt";
    NSString * fileHistogramTxt2 = @"/Users/bizoro/Documents/master2/Projet_Synthese/VirtualCoach/MainTestCoupDroitEloise/HistogramTestCoupDroit2_11052016.txt";
    
    [datasetEntry2 writeKmeanDatasetAtPath:filePathKmeanEntryDatasetPlist2];
    [datasetEntry2 writeKmeanDatasetForTestAtPath:filePathKmeanEntryDatasetTxt2];
    [angleHistogram2 writeHistogramForTestAtPath:fileHistogramTxt2];
    
    KmeanCalculation * kmeanCalculation2 = [[KmeanCalculation alloc]initKmeanCalculationWithPathOfDataEntries:filePathKmeanEntryDatasetPlist2 andClusterCount:3];
    [kmeanCalculation2 kmeanProcessWithMaxIteration:60];
    
    NSLog(@"%d %d %d", [[kmeanCalculation2.clusters objectAtIndex:0] countMember] , [[kmeanCalculation2.clusters objectAtIndex:1] countMember] , [[kmeanCalculation2.clusters objectAtIndex:2] countMember]);
    
    //NSLog(@"%d %d", [[kmeanCalculation2.clusters objectAtIndex:0] countMember] , [[kmeanCalculation2.clusters objectAtIndex:1] countMember]);
    
    //NSLog(@"%d %d %d %d", [[kmeanCalculation2.clusters objectAtIndex:0] countMember] , [[kmeanCalculation2.clusters objectAtIndex:1] countMember] , [[kmeanCalculation2.clusters objectAtIndex:2] countMember], [[kmeanCalculation2.clusters objectAtIndex:3] countMember]);
    
    NSLog(@"%d %f", [((Cluster *)[kmeanCalculation2.clusters objectAtIndex:0]) center].time, [((Cluster *)[kmeanCalculation2.clusters objectAtIndex:0]) center].meanAcceleration );
    
    NSLog(@"%d %f", [((Cluster *)[kmeanCalculation2.clusters objectAtIndex:1]) center].time, [((Cluster *)[kmeanCalculation2.clusters objectAtIndex:1]) center].meanAcceleration );
    
    NSLog(@"%d %f", [((Cluster *)[kmeanCalculation2.clusters objectAtIndex:2]) center].time, [((Cluster *)[kmeanCalculation2.clusters objectAtIndex:2]) center].meanAcceleration );
    
    //NSLog(@"%d %f", [((Cluster *)[kmeanCalculation2.clusters objectAtIndex:3]) center].time, [((Cluster *)[kmeanCalculation2.clusters objectAtIndex:3]) center].meanAcceleration );
    
    NSString * angleMax2 = [MotionDeduction recognizeTennisMotionWithHistogram:angleHistogram2 andLeftHanded:false];
    
    NSLog(@"déduction: %@", angleMax2);
    
    
    // ########### Coup droit éloïse 3 ###############
    
    NSString *sourcePath3 = @"/Users/bizoro/Documents/master2/Projet_Synthese/trouducul";
    NSArray* dirs3 = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:sourcePath
                                                                         error:NULL];
    NSMutableArray *pgmFiles3 = [[NSMutableArray alloc] init];
    [dirs3 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = (NSString *)obj;
        NSString *extension = [[filename pathExtension] lowercaseString];
        if ([extension isEqualToString:@"pgm"]) {
            [pgmFiles3 addObject:[sourcePath3 stringByAppendingPathComponent:filename]];
        }
    }];
    
    NSLog(@"\n");
    NSLog(@"###############################################");
    NSLog(@"countFiles: %lu", (unsigned long)pgmFiles3.count);
    
    Histogram * angleHistogram3 = [[Histogram alloc] init];
    KmeanEntryDataSet * datasetEntry3 = [[KmeanEntryDataSet alloc] init];
    for(int i=460; i<490; i++){
        
        gray8i_t * img1Gray;
        gray8i_t * img2Gray;
        gray8i_t * img3Gray;
        
        if(i < pgmFiles3.count-2){
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i]);
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i+1]);
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i+2]);
            //NSLog(@"########################################################");
            
            img1Gray = pgmopen([[pgmFiles3 objectAtIndex:i] UTF8String]);
            img2Gray = pgmopen([[pgmFiles3 objectAtIndex:i+1] UTF8String]);
            img3Gray = pgmopen([[pgmFiles3 objectAtIndex:i+2] UTF8String]);
            
            rect_t interval;
            interval.start.x = 414;
            interval.start.y = 204;
            interval.end.x = 680;
            interval.end.y = 330;
            //interval.start.x = 0;
            //interval.start.y = 0;
            //interval.end.x = img2Gray->width;
            //interval.end.y = img2Gray->height;
            vect2darray_t * v1 = opticalflow(img1Gray, img2Gray);
            vect2darray_t * v2 = opticalflow(img2Gray, img3Gray);
            
            //for (int j=0; j<v2->length; j++) {
            //  NSLog(@"x: %lf and y: %lf for v1", v1->data[j].x, v1->data[j].y);
            //  NSLog(@"x: %lf and y: %lf for v2", v2->data[j].x, v2->data[j].y);
            //}
            
            //NSLog(@"v1: %d and v2: %d", v1->length, v2->length);
            //NSLog(@"#######################################################");
            [angleHistogram3 generateHistogramFromSpeedVector:v1 betweenInterval:interval andWithImageWidth:img2Gray->width];
            [datasetEntry3 addKmeanEntryToDataSetFromFirstSpeedVectorsTab:v1 andSecondSpeedVectorsTab:v2 betweenInterval:interval andWithImageWidth:img2Gray->width];
            
        }else if(i < pgmFiles3.count-1){
            img1Gray = pgmopen([[pgmFiles3 objectAtIndex:i] UTF8String]);
            img2Gray = pgmopen([[pgmFiles3 objectAtIndex:i+1] UTF8String]);
            
            rect_t interval;
            interval.start.x = 414;
            interval.start.y = 204;
            interval.end.x = 680;
            interval.end.y = 330;
            vect2darray_t * v1 = opticalflow(img1Gray, img2Gray);
            [angleHistogram3 generateHistogramFromSpeedVector:v1 betweenInterval:interval andWithImageWidth:img2Gray->width];
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i]);
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i+1]);
            //NSLog(@"########################################################");
        }
        
    }
    
    NSString * filePathKmeanEntryDatasetPlist3 = @"/Users/bizoro/Documents/master2/Projet_Synthese/VirtualCoach/MainTestCoupDroitEloise/KmeanEntryDataSetMainTestCoupDroit3_11052016.plist";
    NSString * filePathKmeanEntryDatasetTxt3 = @"/Users/bizoro/Documents/master2/Projet_Synthese/VirtualCoach/MainTestCoupDroitEloise/KmeanEntryDataSetMainTestCoupDroit3_11052016.txt";
    NSString * fileHistogramTxt3 = @"/Users/bizoro/Documents/master2/Projet_Synthese/VirtualCoach/MainTestCoupDroitEloise/HistogramTestCoupDroit3_11052016.txt";
    [datasetEntry3 writeKmeanDatasetAtPath:filePathKmeanEntryDatasetPlist3];
    
    [datasetEntry3 writeKmeanDatasetForTestAtPath:filePathKmeanEntryDatasetTxt3];
    [angleHistogram3 writeHistogramForTestAtPath:fileHistogramTxt3];
    
    KmeanCalculation * kmeanCalculation3 = [[KmeanCalculation alloc]initKmeanCalculationWithPathOfDataEntries:filePathKmeanEntryDatasetPlist3 andClusterCount:3];
    [kmeanCalculation3 kmeanProcessWithMaxIteration:60];
    
    NSLog(@"%d %d %d", [[kmeanCalculation3.clusters objectAtIndex:0] countMember] , [[kmeanCalculation3.clusters objectAtIndex:1] countMember] , [[kmeanCalculation3.clusters objectAtIndex:2] countMember]);
    
    //NSLog(@"%d %d", [[kmeanCalculation3.clusters objectAtIndex:0] countMember] , [[kmeanCalculation3.clusters objectAtIndex:1] countMember]);
    
    //NSLog(@"%d %d %d %d", [[kmeanCalculation3.clusters objectAtIndex:0] countMember] , [[kmeanCalculation3.clusters objectAtIndex:1] countMember] , [[kmeanCalculation3.clusters objectAtIndex:2] countMember], [[kmeanCalculation3.clusters objectAtIndex:3] countMember]);
    
    NSLog(@"%d %f", [((Cluster *)[kmeanCalculation3.clusters objectAtIndex:0]) center].time, [((Cluster *)[kmeanCalculation3.clusters objectAtIndex:0]) center].meanAcceleration );
    
    NSLog(@"%d %f", [((Cluster *)[kmeanCalculation3.clusters objectAtIndex:1]) center].time, [((Cluster *)[kmeanCalculation3.clusters objectAtIndex:1]) center].meanAcceleration );
    
    NSLog(@"%d %f", [((Cluster *)[kmeanCalculation3.clusters objectAtIndex:2]) center].time, [((Cluster *)[kmeanCalculation3.clusters objectAtIndex:2]) center].meanAcceleration );
    
    //NSLog(@"%d %f", [((Cluster *)[kmeanCalculation3.clusters objectAtIndex:3]) center].time, [((Cluster *)[kmeanCalculation3.clusters objectAtIndex:3]) center].meanAcceleration );
    
    NSString * angleMax3 = [MotionDeduction recognizeTennisMotionWithHistogram:angleHistogram3 andLeftHanded:false];
    
    NSLog(@"déduction: %@", angleMax3);
    
    
    
    // ########### Coup droit éloïse 4 ###############
    
    NSString *sourcePath4 = @"/Users/bizoro/Documents/master2/Projet_Synthese/trouducul";
    NSArray* dirs4 = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:sourcePath
                                                                         error:NULL];
    NSMutableArray *pgmFiles4 = [[NSMutableArray alloc] init];
    [dirs4 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = (NSString *)obj;
        NSString *extension = [[filename pathExtension] lowercaseString];
        if ([extension isEqualToString:@"pgm"]) {
            [pgmFiles4 addObject:[sourcePath4 stringByAppendingPathComponent:filename]];
        }
    }];
    
    NSLog(@"\n");
    NSLog(@"###############################################");
    NSLog(@"countFiles: %lu", (unsigned long)pgmFiles4.count);
    
    Histogram * angleHistogram4 = [[Histogram alloc] init];
    KmeanEntryDataSet * datasetEntry4 = [[KmeanEntryDataSet alloc] init];
    for(int i=550; i<580; i++){
        
        gray8i_t * img1Gray;
        gray8i_t * img2Gray;
        gray8i_t * img3Gray;
        
        if(i < pgmFiles4.count-2){
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i]);
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i+1]);
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i+2]);
            //NSLog(@"########################################################");
            
            img1Gray = pgmopen([[pgmFiles4 objectAtIndex:i] UTF8String]);
            img2Gray = pgmopen([[pgmFiles4 objectAtIndex:i+1] UTF8String]);
            img3Gray = pgmopen([[pgmFiles4 objectAtIndex:i+2] UTF8String]);
            
            rect_t interval;
            interval.start.x = 403;
            interval.start.y = 162;
            interval.end.x = 627;
            interval.end.y = 327;
            //interval.start.x = 0;
            //interval.start.y = 0;
            //interval.end.x = img2Gray->width;
            //interval.end.y = img2Gray->height;
            vect2darray_t * v1 = opticalflow(img1Gray, img2Gray);
            vect2darray_t * v2 = opticalflow(img2Gray, img3Gray);
            
            //for (int j=0; j<v2->length; j++) {
            //  NSLog(@"x: %lf and y: %lf for v1", v1->data[j].x, v1->data[j].y);
            //  NSLog(@"x: %lf and y: %lf for v2", v2->data[j].x, v2->data[j].y);
            //}
            
            //NSLog(@"v1: %d and v2: %d", v1->length, v2->length);
            //NSLog(@"#######################################################");
            [angleHistogram4 generateHistogramFromSpeedVector:v1 betweenInterval:interval andWithImageWidth:img2Gray->width];
            [datasetEntry4 addKmeanEntryToDataSetFromFirstSpeedVectorsTab:v1 andSecondSpeedVectorsTab:v2 betweenInterval:interval andWithImageWidth:img2Gray->width];
            
        }else if(i < pgmFiles4.count-1){
            img1Gray = pgmopen([[pgmFiles4 objectAtIndex:i] UTF8String]);
            img2Gray = pgmopen([[pgmFiles4 objectAtIndex:i+1] UTF8String]);
            
            rect_t interval;
            interval.start.x = 403;
            interval.start.y = 162;
            interval.end.x = 627;
            interval.end.y = 327;
            vect2darray_t * v1 = opticalflow(img1Gray, img2Gray);
            [angleHistogram4 generateHistogramFromSpeedVector:v1 betweenInterval:interval andWithImageWidth:img2Gray->width];
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i]);
            //NSLog(@"filename: %@", [ppmFiles objectAtIndex:i+1]);
            //NSLog(@"########################################################");
        }
        
    }
    
    NSString * filePathKmeanEntryDatasetPlist4 = @"/Users/bizoro/Documents/master2/Projet_Synthese/VirtualCoach/MainTestCoupDroitEloise/KmeanEntryDataSetMainTestCoupDroit4_11052016.plist";
    NSString * filePathKmeanEntryDatasetTxt4 = @"/Users/bizoro/Documents/master2/Projet_Synthese/VirtualCoach/MainTestCoupDroitEloise/KmeanEntryDataSetMainTestCoupDroit4_11052016.txt";
    NSString * fileHistogramTxt4 = @"/Users/bizoro/Documents/master2/Projet_Synthese/VirtualCoach/MainTestCoupDroitEloise/HistogramTestCoupDroit4_11052016.txt";
    [datasetEntry4 writeKmeanDatasetAtPath:filePathKmeanEntryDatasetPlist4];
    
    [datasetEntry4 writeKmeanDatasetForTestAtPath:filePathKmeanEntryDatasetTxt4];
    [angleHistogram4 writeHistogramForTestAtPath:fileHistogramTxt4];
    
    KmeanCalculation * kmeanCalculation4 = [[KmeanCalculation alloc]initKmeanCalculationWithPathOfDataEntries:filePathKmeanEntryDatasetPlist4 andClusterCount:3];
    [kmeanCalculation4 kmeanProcessWithMaxIteration:60];
    
    NSLog(@"%d %d %d", [[kmeanCalculation4.clusters objectAtIndex:0] countMember] , [[kmeanCalculation4.clusters objectAtIndex:1] countMember] , [[kmeanCalculation4.clusters objectAtIndex:2] countMember]);
    
    //NSLog(@"%d %d", [[kmeanCalculation4.clusters objectAtIndex:0] countMember] , [[kmeanCalculation4.clusters objectAtIndex:1] countMember]);
    
    //NSLog(@"%d %d %d %d", [[kmeanCalculation4.clusters objectAtIndex:0] countMember] , [[kmeanCalculation4.clusters objectAtIndex:1] countMember] , [[kmeanCalculation4.clusters objectAtIndex:2] countMember], [[kmeanCalculation4.clusters objectAtIndex:3] countMember]);
    
    NSLog(@"%d %f", [((Cluster *)[kmeanCalculation4.clusters objectAtIndex:0]) center].time, [((Cluster *)[kmeanCalculation4.clusters objectAtIndex:0]) center].meanAcceleration );
    
    NSLog(@"%d %f", [((Cluster *)[kmeanCalculation4.clusters objectAtIndex:1]) center].time, [((Cluster *)[kmeanCalculation4.clusters objectAtIndex:1]) center].meanAcceleration );
    
    NSLog(@"%d %f", [((Cluster *)[kmeanCalculation4.clusters objectAtIndex:2]) center].time, [((Cluster *)[kmeanCalculation4.clusters objectAtIndex:2]) center].meanAcceleration );
    
    //NSLog(@"%d %f", [((Cluster *)[kmeanCalculation4.clusters objectAtIndex:3]) center].time, [((Cluster *)[kmeanCalculation4.clusters objectAtIndex:3]) center].meanAcceleration );
    
    NSString * angleMax4 = [MotionDeduction recognizeTennisMotionWithHistogram:angleHistogram4 andLeftHanded:false];
    
    NSLog(@"déduction: %@", angleMax4);
    
     */
    /*
    DIR *d;
    struct dirent *dir;
    char * dirPath = "/Users/bizoro/Documents/master2/Projet_Synthese/eloise";
    d = opendir(dirPath);
    
    if (d)
    {
        while ((dir = readdir(d)) != NULL)
        {
            if (dir->d_type == DT_REG)
            {
                char * fullPath = (char *) calloc(1+strlen(dirPath)+ strlen(dir->d_name), sizeof(char*));
                strcat(fullPath, dirPath);
                strcat(fullPath, "/");
                strcat(fullPath, dir->d_name);
                printf("%s\n", fullPath);
                
            }
        }
        
        closedir(d);
    }
    
    */
    
    /*
    NSURL * url = [[NSURL alloc] initWithString:@"/Users/bizoro/Documents/master2/Projet_Synthese/eloïse.mov"];
    int FPS = 60;
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.requestedTimeToleranceAfter =  kCMTimeZero;
    generator.requestedTimeToleranceBefore =  kCMTimeZero;
    
    NSLog(@"%f", CMTimeGetSeconds(asset.duration) *  FPS);
    
    for (Float64 i = 0; i < CMTimeGetSeconds(asset.duration) *  FPS ; i++){
        @autoreleasepool {
            CMTime time = CMTimeMake(i, FPS);
            NSError *err;
            CMTime actualTime;
            CGImageRef image = [generator copyCGImageAtTime:time actualTime:&actualTime error:&err];
            UIImage *generatedImage = [[UIImage alloc] initWithCGImage:image];
            NSData *imageData = UIImagePNGRepresentation(generatedImage);
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *fullPath = @"/Users/bizoro/Documents/master2/Projet_Synthese/eloise/out%04d.png";
            [fileManager createFileAtPath:fullPath contents:imageData attributes:nil];
            //[this saveImage: generatedImage atTime:actualTime]; // Saves the image on document directory and not memory
            CGImageRelease(image);
        }
    }
    */
}
