//
//  MovementReferenceDAO.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 24/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "MovementReferenceDAO.h"

@implementation MovementReferenceDAO

//INSERT
-(id)insertIntoMovementReference:(NSString *) type path:(NSString *) path id_video:(NSString *) idv
{
    NSString *query = @"insert into MovementReference values (null,'";
    query = [query stringByAppendingString:type];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:path];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:idv];
    query = [query stringByAppendingString:@"');"];
    
    NSNumber *insertion = [DatabaseService query:query mode:VCQueryNoMode];
    
    return insertion;
}

//SELECT
-(NSArray *) allMovementRef
{
    NSString *query = @"select * from MovementReference;";
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    return result;
}

-(NSArray *)searchByIdVideoRef:(NSString*) idv Type:(NSString *) type
{
    NSString *query = @"select * from MovementReference where idvideoRef ='";
    query = [query stringByAppendingString:idv];
    query = [query stringByAppendingString:@"' and type='"];
    query = [query stringByAppendingString:type];
    query = [query stringByAppendingString:@"';"];
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    return result;
}

-(NSArray *)searchByIdVideoRef:(NSString*) idv
{
    NSString *query = @"select * from MovementReference where idvideoRef ='";
    query = [query stringByAppendingString:idv];
    query = [query stringByAppendingString:@"';"];
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    return result;
}

//DELETE
-(id)deleteMovementRefById:(NSString *) idMvt
{
    NSString *query =@"delete from MovementReference where idMovementRef='";
    query = [query stringByAppendingString:idMvt];
    query = [query stringByAppendingString:@"';"];
    
    NSNumber *delete = [DatabaseService query:query mode:VCQueryNoMode];
    
    return delete;
}

@end
