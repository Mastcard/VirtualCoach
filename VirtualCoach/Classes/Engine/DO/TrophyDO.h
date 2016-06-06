//
//  Trophy.h
//  VirtualCoach
//
//  Created by Adrien on 25/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#ifndef Trophy_h
#define Trophy_h

@interface TrophyDO : NSObject

@property (nonatomic) int trophyId;
@property (nonatomic) NSString* name;
@property (nonatomic) NSString* trophyDescription;

-(instancetype)initWithId:(int)id andName:(NSString*)name andDescription:(NSString*)description;

@end

#endif /* Trophy_h */
