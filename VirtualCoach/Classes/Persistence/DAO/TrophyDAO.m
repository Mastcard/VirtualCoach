//
//  TrophyDAO.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 15/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "TrophyDAO.h"

@implementation TrophyDAO

//INSERT
-(id)insertIntoTrophy:(NSString *) name description:(NSString *) desc
{
    NSString *query = @"insert into Movement values (null,'";
    query = [query stringByAppendingString:name];
    query = [query stringByAppendingString:@"','"];
    query = [query stringByAppendingString:desc];
    query = [query stringByAppendingString:@"');"];
    
    NSNumber *insertion = [DatabaseService query:query mode:VCQueryNoMode];
    
    return insertion;
}
//SELECT
-(NSArray *) allTrophy
{
    
    NSString *query = @"select name,description from Trophy;";
    
    NSArray * result =[[NSArray alloc]init];
    result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
    
    return result;
}

@end
