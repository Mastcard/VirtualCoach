//
//  PlayerTrainingVideo.h
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 04/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseService.h"

@interface PlayerTrainingVideoDAO : NSObject

//INSERT
-(id)insertIntoPlayer_Training_Video:(NSString *) idPlayer id_training:(NSString *) idtraining id_video:(NSString *) idVideo;
//SELECT
-(int)searchIdByPlayer:(NSString *) idPlayer andTraining:(NSString *) idTraining andVideo:(NSString *) idVideo;
//DELETE
-(id)deletePlayerTrainingVideoByIdPlayer:(NSString *) idPlayer;
-(id)deletePlayerTrainingVideoByIdTraining:(NSString *) idTrain;
-(id)deletePlayerTrainingVideoByIdVideo:(NSString *) idVideo;
-(id)deletePlayerTrainingVideoById:(NSString *) idPTV;

@end
