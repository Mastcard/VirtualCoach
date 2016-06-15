//
//  TrainingDO.h
//  VirtualCoach
//
//  Created by Adrien on 24/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#ifndef TrainingDO_h
#define TrainingDO_h

#import "VideoDO.h"

@interface TrainingDO : NSObject

@property (nonatomic) int trainingId;
@property (nonatomic) NSDate* date;
@property (nonatomic) NSString* name;
@property (nonatomic) NSString* place;
@property (nonatomic) NSMutableArray<VideoDO*>* videos;

-(instancetype)initWithId:(int)trainingId andDate:(NSDate*)date andName:(NSString*)name andPlace:(NSString*)place andVideos:(NSMutableArray<VideoDO*>*)videos;

@end

#endif /* TrainingDO_h */
