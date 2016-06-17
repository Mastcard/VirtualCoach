//
//  PlayerDAO.h
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 15/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseService.h"

@interface PlayerDAO : NSObject

//INSERT
-(id)insertIntoPlayer:(NSString *) name firstName:(NSString *) fname leftHanded:(NSString *) lh level:(NSString *) level;
//SELECT
-(NSArray *) allPlayers;
-(int)searchIdByName:(NSString *) name firstName:(NSString *) fname;
-(NSArray *) searchPlayerById:(NSString *)idP;
//DELETE
-(id)deletePlayerById:(NSString *) idPlayer;

@end
