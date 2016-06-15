//
//  MovementReferenceDAO.h
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 24/05/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseService.h"

@interface MovementReferenceDAO : NSObject

//INSERT
-(id)insertIntoMovementReference:(NSString *) type path:(NSString *) path id_video:(NSString *) idv;
//SELECT
-(NSArray *) allMovementRef;
-(NSArray *)searchByIdVideoRef:(NSString*) idv Type:(NSString *) type;
-(NSArray *)searchByIdVideoRef:(NSString*) idv;
//DELETE
-(id)deleteMovementRefById:(NSString *) idMvt;

@end
