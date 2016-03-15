//
//  KmeanEntryDataSet.m
//  VirtualCoach
//
//  Created by Bi ZORO on 04/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import "KmeanEntryDataSet.h"

@implementation KmeanEntryDataSet

-(instancetype)init{
    self = [super init];
    if (self){
        _data=[[NSMutableArray alloc]init];
        _datacount = 0;
    }
    return  self;
}

-(void)addKmeanEntryToDataSetFromFirstSpeedVectorsTab:(speedVector *)speed1 andSecondSpeedVectorsTab:(speedVector *)speed2 betweenInterval:(rect_t)interval andWithImageWidth:(uint16_t)width{
    
    KmeanEntry * entry = [[KmeanEntry alloc] init];
    [entry generateDataEntryForKmeanFromFirstSpeedVectorsTab:speed1 andSecondSpeedVectorsTab:speed2 betweenInterval:interval andWithImageWidth:width];
    [_data insertObject:entry atIndex:_datacount];
    _datacount ++;
    entry.time = _datacount;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.data forKey:@"dataset"];
    [aCoder encodeInt:self.datacount forKey:@"datacount"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self)
    {
        _data = [aDecoder decodeObjectForKey:@"dataset"];
        _datacount =[aDecoder decodeIntForKey:@"datacount"];
    }
    
    return self;
}

- (void)writeKmeanDatasetAtPath:(NSString *)path
{
    [NSKeyedArchiver archiveRootObject:self toFile:path];
}

+ (id)loadKmeanDatasetAtPath:(NSString *)path
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}


@end
