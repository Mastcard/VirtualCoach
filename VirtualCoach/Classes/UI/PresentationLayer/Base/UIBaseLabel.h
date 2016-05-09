//
//  UIBaseLabel.h
//  VirtualCoach
//
//  Created by Romain Dubreucq on 06/03/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Layout.h"

@interface UIBaseLabel : UILabel <Layout>

- (void)resizeToFitText;

@end
