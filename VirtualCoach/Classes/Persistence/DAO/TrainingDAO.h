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
-(NSArray *)searchByDate:(NSString*) date Name:(NSString *) name Andplace:(NSString *) place;
-(NSArray *)searchByDate:(NSString*) date;
//DELETE
-(id)deleteTrainingById:(NSString *) idTrain;

@end
