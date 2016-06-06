//
//  CheckDatabaseDAO.h
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 01/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseService.h"

@interface CheckDatabaseDAO : NSObject

-(int)CheckingDatabase:(NSString *)databasePath andScriptCreationPath:(NSString *) sqlPath;

@end
