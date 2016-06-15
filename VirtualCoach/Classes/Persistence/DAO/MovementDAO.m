//
//  MovementDAO.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 15/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "MovementDAO.h"

@implementation MovementDAO

//INSERT
-(id)insertIntoMovement:(NSString *) type winner:(NSString *) win losing:(NSString *) lose success_rate:(NSString *) sr id_video:(NSString *) idv
{
    NSString *query = @"insert into Movement values (null,'";
    query = [query stringByAppendingString:type];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:win];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:lose];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:sr];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:idv];
    query = [query stringByAppendingString:@"');"];
    
    NSNumber *insertion = [DatabaseService query:query mode:VCQueryNoMode];
    
    return insertion;
}

//SELECT
-(NSArray *) allMovement
{
    NSString *query = @"select * from Movement;";
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    return result;
}

-(NSArray *)searchByIdVideo:(NSString*) idv Type:(NSString *) type
{
    NSString *query = @"select * from Movement where idvideo ='";
    query = [query stringByAppendingString:idv];
    query = [query stringByAppendingString:@"' and type='"];
    query = [query stringByAppendingString:type];
    query = [query stringByAppendingString:@"';"];
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    return result;
}

-(NSArray *)searchByIdVideo:(NSString*) idv
{
    NSString *query = @"select * from Movement where idvideo ='";
    query = [query stringByAppendingString:idv];
    query = [query stringByAppendingString:@"';"];
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    return result;
}

//DELETE
-(id)deleteMovementById:(NSString *) idMvt
{
    NSString *query =@"delete from Movement where idMovement ='";
    query = [query stringByAppendingString:idMvt];
    query = [query stringByAppendingString:@"';"];
    
    NSNumber *delete = [DatabaseService query:query mode:VCQueryNoMode];
    
    return delete;
}

@end
