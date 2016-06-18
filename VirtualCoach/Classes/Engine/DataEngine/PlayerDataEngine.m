//
//  PlayerDataEngine.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 06/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "PlayerDataEngine.h"
#import "PlayerDAO.h"
#import "StatisticalDAO.h"
#import "TrophyDAO.h"

@implementation PlayerDataEngine

//INSERT
-(id)insertPlayer:(PlayerDO *)playerDO
{
    NSString *leftHanded = @"0";
    if(playerDO.leftHanded == YES){
        leftHanded= @"0";
    }
    else{
        leftHanded = @"1";
    }
    
    return [_playerDAO insertIntoPlayer:playerDO.name firstName:playerDO.firstName leftHanded:leftHanded level:nil];
}

//SELECT
-(NSMutableArray<PlayerDO*>*)selectAllPlayers
{
    NSMutableArray<PlayerDO*> *arrayPlayerDO;
    PlayerDO *playerDO;
    PlayerDAO *playerDAO;
    NSMutableArray<StatisticDO*> *arrayStatDO;
    StatisticDO *statDO;
    StatisticalDAO *statDAO;
    NSMutableArray<TrophyDO*> *arrayTrophyDO;
    TrophyDO *trophyDO;
    TrophyDAO *trophyDAO;
    
    NSArray *players = [playerDAO allPlayers];
    
    for(int i = 0; i<[players count]; i++){
        for(int j = 0; j<[players[i] count]; j++){
            
            NSArray *oneStat = [statDAO searchByIdPlayer:players[0][j]];
            
            statDO = [statDO initWithId:(int)[[oneStat objectAtIndex:0] objectAtIndex:0]
                       andForehandCount:(int)[[oneStat objectAtIndex:1] objectAtIndex:0]
                       andBackhandCount:(int)[[oneStat objectAtIndex:2] objectAtIndex:0]
                        andServiceCount:(int)[[oneStat objectAtIndex:3] objectAtIndex:0]
                          andWinningRun:(int)[[oneStat objectAtIndex:4] objectAtIndex:0]
                          andLoosingRun:(int)[[oneStat objectAtIndex:5] objectAtIndex:0]
           andForehandGlobalSuccessRate:[[[oneStat objectAtIndex:6] objectAtIndex:0 ]floatValue]
           andBackhandGlobalSuccessRate:[[[oneStat objectAtIndex:7] objectAtIndex:0] floatValue]
            andServiceGlobalSuccessRate:[[[oneStat objectAtIndex:8] objectAtIndex:0] floatValue]
                                 andDay:(int)[[oneStat objectAtIndex:9] objectAtIndex:0]
                               andMonth:(int)[[oneStat objectAtIndex:10] objectAtIndex:0]
                                andYear:(int)[[oneStat objectAtIndex:11] objectAtIndex:0]
                      ];
            
            [arrayStatDO addObject:statDO];
            
            
            
            bool leftHanded = YES;
            if([players[3][0] integerValue] == 1){
                leftHanded= NO;
            }
            else{
                leftHanded = YES;
            }
            
            playerDO = [playerDO initWithId:players[0][j] andName:players[1][j] andFirstName:players[2][j] andLeftHanded:leftHanded andStatistics:statDO andTrophies:nil];
            
            [arrayPlayerDO addObject:playerDO];
        }
    }
    
    return arrayPlayerDO;
}

//DELETE
-(id)deletePlayerId:(PlayerDO*)playerDO
{
    return [_playerDAO deletePlayerById:[NSString stringWithFormat:@"%i", playerDO.playerId]];
}
    
@end
