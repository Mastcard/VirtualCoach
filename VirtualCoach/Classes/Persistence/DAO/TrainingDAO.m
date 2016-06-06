//
//  TrainingDAO.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 15/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "TrainingDAO.h"

@implementation TrainingDAO

//INSERT
-(id)insertIntoTraining:(NSString *) date name:(NSString *) n place:(NSString *) p
{
    NSString *query = @"insert into Training values (null,'";
    query = [query stringByAppendingString:date];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:n];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:p];
    query = [query stringByAppendingString:@"');"];
    
    NSNumber *insertion = [DatabaseService query:query mode:VCQueryNoMode];
    
    return insertion;
}

//SELECT
-(NSArray *) allTraining
{
    NSString *query = @"select * from Training;";
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    return result;
}

-(int)searchIdByDate:(NSString*) date Name:(NSString *) name Andplace:(NSString *) place
{
    NSString *query = @"select idTraining from Training where date ='";
    query = [query stringByAppendingString:date];
    query = [query stringByAppendingString:@"' and name='"];
    query = [query stringByAppendingString:name];
    query = [query stringByAppendingString:@"' and place='"];
    query = [query stringByAppendingString:place];
    query = [query stringByAppendingString:@"';"];
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    int desc = (int) [result[0][0] longValue];
    
    return desc;;
}

-(int)searchIdByDate:(NSString*) date
{
    NSString *query = @"select idTraining from Training where date ='";
    query = [query stringByAppendingString:date];
    query = [query stringByAppendingString:@"';"];
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    int desc = (int) [result[0][0] longValue];
    
    return desc;
}

//DELETE
-(id)deleteTrainingById:(NSString *) idTrain
{
    NSString *query =@"delete from Training where idTraining ='";
    query = [query stringByAppendingString:idTrain];
    query = [query stringByAppendingString:@"';"];
    
    NSNumber *delete = [DatabaseService query:query mode:VCQueryNoMode];
    
    return delete;
}

@end
