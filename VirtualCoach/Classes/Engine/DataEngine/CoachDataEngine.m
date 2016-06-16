//
//  CoachDataEngine.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 06/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "CoachDataEngine.h"
#import "CoachPlayerDAO.h"
#import "VideoReferenceDAO.h"
#import "PlayerDAO.h"

@implementation CoachDataEngine

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _coachDAO = [[CoachDAO alloc] init];
    }
    
    return self;
}

//INSERT
-(id)insertCoach:(CoachDO*)coachDO
{
    NSString *leftHanded = @"0";
    if(coachDO.leftHanded == YES){
        leftHanded= @"0";
    }
    else{
        leftHanded = @"1";
    }
    return [_coachDAO insertIntoCoach:coachDO.name firstName:coachDO.firstName leftHanded:leftHanded login:coachDO.login password:coachDO.password];
}

//SELECT
-(NSMutableArray<CoachDO*>*)selectAllCoaches
{
    CoachPlayerDAO *coachPlayerDAO;
    CoachDO *coachDO;
    PlayerDAO *playerDAO;
    PlayerDO *playerDO;
    VideoReferenceDAO *videoRefDAO;
    ReferenceVideoDO *videoRefDO;
    NSMutableArray<PlayerDO*> *arrayPlayerDO;
    NSMutableArray<CoachDO*> *arrayCoachDO;
    NSMutableArray<ReferenceVideoDO*>* arrayVideoReferenceDO;
    NSArray *allCoaches = [_coachDAO allCoaches];
    
    for(int i = 0; i<[allCoaches count]; i++){
        for(int j = 0; j<[allCoaches[i] count]; j++){
            
            NSArray *playesId = [coachPlayerDAO searchIdPlayersByCoach:allCoaches[0][j]];
            
            for(int p=0;p<[playesId count];p++){
                for(int pp=0; pp<[playesId[p] count];pp++){
                    NSString *idPlayer =playesId[p][pp];
                    
                    NSArray *onePlayer = [playerDAO searchPlayerById:idPlayer];
                    
                    bool leftHanded = YES;
                    if([onePlayer[3][0] integerValue] == 1){
                        leftHanded= NO;
                    }
                    else{
                        leftHanded = YES;
                    }
                    playerDO = [playerDO initWithId:(int)[[onePlayer objectAtIndex:0] objectAtIndex:0] andName:onePlayer[1][0] andFirstName:onePlayer[2][0] andLeftHanded:leftHanded andStatistics:nil andTrophies:nil];
                    
                    [arrayPlayerDO addObject:playerDO];
                }
            }
            
            NSArray *oneVideoRef = [videoRefDAO searchVideoRefByIdCoach:allCoaches[0][j]];
            
            bool processed = YES;
            if([oneVideoRef[3][0] integerValue] == 1){
                processed= NO;
            }
            else{
                processed = YES;
            }
            
            bool removed = YES;
            if([oneVideoRef[4][0] integerValue] == 1){
                removed= NO;
            }
            else{
                removed = YES;
            }
            
            videoRefDO = [videoRefDO initWithId:(int)[[oneVideoRef objectAtIndex:0] objectAtIndex:0] andName:oneVideoRef[1][0] andProcessed:processed andRemoved:removed andReferenceMovements:nil];
            
            [arrayVideoReferenceDO addObject:videoRefDO];
            
            
            coachDO = [[CoachDO alloc] initWithCoachId:(int)[[allCoaches objectAtIndex:0] objectAtIndex:j] andName:allCoaches[1][j] andFirstName:allCoaches[2][j] andLogin:allCoaches[4][j] andPassword:allCoaches[5][j] andLeftHanded:allCoaches[3][j] andPlayers:arrayPlayerDO andReferenceVideos:arrayVideoReferenceDO];
            
            [arrayCoachDO addObject:coachDO];
        }
    }
    for( int t = 0; t < arrayCoachDO.count; t++ ) {
        NSLog( @"%@", [arrayCoachDO objectAtIndex:t]);
    }
    
    return arrayCoachDO;
    
}

//DELETE
/*-(id)deleteCoachById:(CoachDO*)coachDO
{
    return [_coachDAO deleteCoachById:[NSString stringWithFormat:@"%i", coachDO.coachId]];
}*/

@end
