//
//  PlayerTrainingVideo.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 04/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "PlayerTrainingVideoDAO.h"

@implementation PlayerTrainingVideoDAO

//INSERT
-(id)insertIntoPlayer_Training_Video:(NSString *) idPlayer id_training:(NSString *) idtraining id_video:(NSString *) idVideo
{
    
    NSString *query = @"insert into PlayerTrainingVideo values (null,'";
    query = [query stringByAppendingString:idPlayer];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:idtraining];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:idVideo];
    query = [query stringByAppendingString:@"');"];
    
    NSLog(@": %@",query);
    
    NSNumber *insertion = [DatabaseService query:query mode:VCQueryNoMode];
    
    return insertion;
}
//SELECT
-(int)searchIdByPlayer:(NSString *) idPlayer andTraining:(NSString *) idTraining andVideo:(NSString *) idVideo
{
    NSString *query = @"select idPlayerTrainingVideo from PlayerTrainingVideo where idplayer='";
    query = [query stringByAppendingString:idPlayer];
    query = [query stringByAppendingString:@"' and idtraining='"];
    query = [query stringByAppendingString:idTraining];
    query = [query stringByAppendingString:@"' and idvideo='"];
    query = [query stringByAppendingString:idVideo];
    query = [query stringByAppendingString:@"';"];
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    int desc = (int) [result[0][0] longValue];
    
    return desc;
}

//DELETE
-(id)deletePlayerTrainingVideoByIdPlayer:(NSString *) idPlayer
{
    NSString *query =@"delete from PlayerTrainingVideo where idplayer ='";
    query = [query stringByAppendingString:idPlayer];
    query = [query stringByAppendingString:@"';"];
    
    NSNumber *delete = [DatabaseService query:query mode:VCQueryNoMode];
    
    return delete;
}

-(id)deletePlayerTrainingVideoByIdTraining:(NSString *) idTrain
{
    NSString *query =@"delete from PlayerTrainingVideo where idtraining ='";
    query = [query stringByAppendingString:idTrain];
    query = [query stringByAppendingString:@"';"];
    
    NSNumber *delete = [DatabaseService query:query mode:VCQueryNoMode];
    
    return delete;
}

-(id)deletePlayerTrainingVideoByIdVideo:(NSString *) idVideo
{
    NSString *query =@"delete from PlayerTrainingVideo where idvideo ='";
    query = [query stringByAppendingString:idVideo];
    query = [query stringByAppendingString:@"';"];
    
    NSNumber *delete = [DatabaseService query:query mode:VCQueryNoMode];
    
    return delete;
}

-(id)deletePlayerTrainingVideoById:(NSString *) idPTV
{
    NSString *query =@"delete from PlayerTrainingVideo where idPlayerTrainingVideo ='";
    query = [query stringByAppendingString:idPTV];
    query = [query stringByAppendingString:@"';"];
    
    NSNumber *delete = [DatabaseService query:query mode:VCQueryNoMode];
    
    return delete;
}

@end
