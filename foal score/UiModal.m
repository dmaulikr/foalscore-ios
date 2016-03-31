//
//  UiModal.m
//  foal score
//
//  Created by Jun on 3/30/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "UiModal.h"

@implementation UiModal

+(void)showModalWithTitle:(NSString*)title message:(NSString*)message buttonTitle:(NSString*)buttonTitle viewController:(UIViewController*)vc
{
    if ([UIAlertController class]) {
        UIAlertController *errorDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [errorDialog dismissViewControllerAnimated:YES completion:nil];
        }];
        [errorDialog addAction:defaultAction];
        [vc presentViewController:errorDialog animated:YES completion:nil];
    
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:vc cancelButtonTitle:buttonTitle otherButtonTitles:nil, nil];
        [alert show];
    }
}

@end
