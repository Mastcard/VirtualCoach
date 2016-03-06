//
//  NSOrderedDictionary.m
//  VirtualCoach
//
//  Created by itzseven on 03/06/2015.
//  Copyright (c) 2015 itzseven. All rights reserved.
//

#import "NSOrderedDictionary.h"

@implementation KeyValueObject

- (instancetype)initWithObject:(id)object forKey:(id)key
{
    self = [super init];
    
    if (self)
    {
        _object = object;
        _key = key;
    }
    
    return self;
}

@end

@interface NSOrderedDictionary ()

@property (nonatomic) NSMutableArray *array;

@end

@implementation NSOrderedDictionary

- (instancetype)initWithObjects:(NSArray *)objects forKeys:(NSArray *)keys
{
    self = [super init];
    
    if (self)
    {
        _array = [[NSMutableArray alloc] init];
        _allKeys = [NSMutableArray arrayWithArray:keys];
        _allValues = [NSMutableArray arrayWithArray:objects];
        
        if ([objects count] == [keys count])
        {
            _count = [objects count];
            
            for (NSUInteger i = 0; i < [objects count]; i++)
            {
                KeyValueObject *kvo = [[KeyValueObject alloc] initWithObject:[objects objectAtIndex:i]
                                                                      forKey:[keys objectAtIndex:i]];
                [_array addObject:kvo];
            }
        }
    }
    
    return self;
}

+ (instancetype)dictionaryWithObjects:(NSArray *)objects forKeys:(NSArray *)keys
{
    return [[NSOrderedDictionary alloc] initWithObjects:objects forKeys:keys];
}

- (id)objectForKey:(id)key
{
    for (NSUInteger i = 0; i < [_array count]; i++)
    {
        if ([((KeyValueObject *)[_array objectAtIndex:i]).key isEqual:key])
            return ((KeyValueObject *)[_array objectAtIndex:i]).object;
    }
    
    return nil;
}

- (void)setObject:(id)object forKey:(id)key
{
    KeyValueObject *kvo = [[KeyValueObject alloc] initWithObject:object forKey:key];
    
    for (NSUInteger i = 0; i < [_array count]; i++)
    {
        if ([((KeyValueObject *)[_array objectAtIndex:i]).key isEqual:key])
        {
            [_array replaceObjectAtIndex:i withObject:kvo];
            return;
        }
    }
    
    [_array addObject:kvo];
    [_allKeys addObject:key];
    [_allValues addObject:object];
    _count++;
}

-(NSString *)description
{
    NSString *description = @"{ \n";
    
    for (KeyValueObject *kvo in _array)
        description = [description stringByAppendingString:[NSString stringWithFormat:@"%@ = %@\n", kvo.key, kvo.object]];
    
    description = [description stringByAppendingString:@"}"];
    
    return description;
}

@end
