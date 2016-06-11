//
//  MovementDAO.h
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 15/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseService.h"

@interface MovementDAO : NSObject

//INSERT
-(id)insertIntoMovement:(NSString *) type winner:(NSString *) win losing:(NSString *) lose success_rate:(NSString *) sr id_video:(NSString *) idv;
//SELECT
-(NSArray *) allMovement;
-(NSArray *)searchByIdVideo:(NSString*) idv Type:(NSString *) type;
-(NSArray *)searchByIdVideo:(NSString*) idv;
//DELETE
-(id)deleteMovementById:(NSString *) idMvt;

@end
