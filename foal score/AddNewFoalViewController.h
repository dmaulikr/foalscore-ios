//
//  AddNewFoalViewController.h
//  foal score
//
//  Created by Jun on 2/4/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "FoalInfoModel.h"
#import "UiModal.h"
#import "FoalScoreAFAPIClient.h"
#import "MBProgressHUD.h"
@interface AddNewFoalViewController : UIViewController

- (instancetype)initWithAnIndexOfFoalThatNeedToModify:(NSInteger)index ModifyOrNot:(BOOL)modify;

@end
