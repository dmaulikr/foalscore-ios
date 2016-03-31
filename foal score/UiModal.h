//
//  UiModal.h
//  foal score
//
//  Created by Jun on 3/30/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UiModal : NSObject
+(void)showModalWithTitle:(NSString*)title message:(NSString*)message buttonTitle:(NSString*)buttonTitle viewController:(UIViewController*)vc;


@end
