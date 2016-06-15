//
//  CheckDatabaseDAO.m
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 01/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "CheckDatabaseDAO.h"

@implementation CheckDatabaseDAO

-(int)CheckingDatabase:(NSString *)databasePath andScriptCreationPath:(NSString *) sqlPath
{
    
    NSString *query = @"SELECT * FROM sqlite_master where type='table';";
    NSArray * result =[[NSArray alloc]init];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:databasePath]){
        
        [DatabaseService initWithFile:databasePath];

        [DatabaseService sqlFile:sqlPath];
        
        result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
        
        NSLog(@"LIST TABLES NO DATABSE: %@", result);
        
        return 1; //no database /add all database + tables
    }
    else{
        [DatabaseService initWithFile:databasePath];
        
        result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
        
        NSLog(@"LIST TABLES: %@", result);
        
        
        if([result[0] count] <= 1){ //because of table "sqlite-sequence"
            
            [DatabaseService sqlFile:sqlPath];
            
            result = [DatabaseService query:query mode:VCSelectIntegerIndexedResult];
            
            NSLog(@"LIST TABLES NO TABLES: %@", result);
            
            return 2;//no tables /add tables
        }
        else{
            
            NSLog(@"LIST TABLES all exists: %@", result);
            
            return 0; //database + tables exist
        }
        
    }
}

@end
