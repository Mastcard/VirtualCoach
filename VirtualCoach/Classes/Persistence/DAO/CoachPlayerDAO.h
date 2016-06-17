//
//  CoachPlayer.h
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 04/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseService.h"

@interface CoachPlayerDAO : NSObject

//INSERT
-(id)insertIntoCoach_Player:(NSString *) idCoach id_player:(NSString *) idPlayer;
//SELECT
-(int)searchIdByCoach:(NSString *) idCoach andPlayer:(NSString *) idPlayer;
-(NSArray*)searchIdPlayersByCoach:(NSString *) idCoach;
//DELETE
-(id)deleteCoachPlayerByIdCoach:(NSString *) idCoach;
-(id)deleteCoachPlayerByIdPlayer:(NSString *) idPlayer;
-(id)deleteCoachPlayerById:(NSString *) idCP;
@end
