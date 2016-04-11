//
//  RegisterViewController.h
//  foal score
//
//  Created by Jun on 3/24/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"
#import "DataManager.h"
#import "FoalScoreAFAPIClient.h"
#import "UiModal.h"
#import "UserInfoViewController.h"
#import "LoginViewController.h"
#import "MBProgressHUD.h"

@interface RegisterViewController : UIViewController
@property (nonatomic, strong) UIViewController* parent;

@end
