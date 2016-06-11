//
//  DatabaseService.h
//  SQLite3Test
//
//  Created by Romain Dubreucq on 18/03/2015.
//  Copyright (c) 2015 Romain Dubreucq. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sqlite3.h>

typedef NS_ENUM(NSUInteger, VCQueryMode) {
    VCQueryNoMode = 0,
    VCSelectIntegerIndexedResult = 1,
    VCSelectColumnIndexedResult = 2
};

@interface DatabaseService : NSObject

+ (void)initWithFile:(NSString *)filePath;
+ (sqlite3 *)instance;
+ (BOOL)initialized;
+ (void)close;
+ (id)query:(NSString *)query mode:(VCQueryMode)mode;
+(int)sqlFile:(NSString *)filePath;

@end
