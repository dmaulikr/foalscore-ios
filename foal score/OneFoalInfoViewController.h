//
//  OneFoalInfoViewController.h
//  foal score
//
//  Created by Jun on 2/10/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoalInfoModel.h"
#import "DataManager.h"
#import "CalculationModel.h"
#import "UiModal.h"
#import "FoalScoreAFAPIClient.h"
#import "MBProgressHUD.h"
#import "AddNewFoalViewController.h"

@interface OneFoalInfoViewController : UIViewController
// foal data
@property (nonatomic, assign) NSInteger indexOfFoal;
@end
