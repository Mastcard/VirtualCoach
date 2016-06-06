//
//  TrainingDAO.h
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 15/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseService.h"

@interface TrainingDAO : NSObject

//INSERT
-(id)insertIntoTraining:(NSString *) date name:(NSString *) n place:(NSString *) p;
//SELECT
-(NSArray *) allTraining;
-(int)searchIdByDate:(NSString*) date Name:(NSString *) name Andplace:(NSString *) place;
-(int)searchIdByDate:(NSString*) date;
//DELETE
-(id)deleteTrainingById:(NSString *) idTrain;

@end
