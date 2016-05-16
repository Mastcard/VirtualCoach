//
//  NSOrderedDictionary.h
//  VirtualCoach
//
//  Created by itzseven on 03/06/2015.
//  Copyright (c) 2015 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyValueObject : NSObject

@property (nonatomic) id key;
@property (nonatomic) id object;

- (instancetype)initWithObject:(id)object forKey:(id)key;

@end

@interface NSOrderedDictionary : NSObject

@property (nonatomic) NSMutableArray *allKeys;
@property (nonatomic) NSMutableArray *allValues;
@property (nonatomic) NSUInteger count;

- (instancetype)initWithObjects:(NSArray *)objects forKeys:(NSArray *)keys;
+ (instancetype)dictionaryWithObjects:(NSArray *)objects forKeys:(NSArray *)keys;
- (id)objectForKey:(id)key;
- (void)setObject:(id)object forKey:(id)key;

@end
