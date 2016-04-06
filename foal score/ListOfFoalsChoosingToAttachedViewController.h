//
//  ListOf FoalsChoosingToAttachedViewController.h
//  foal score
//
//  Created by Jun on 2/17/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "FoalInfoModel.h"
#import "CalculationModel.h"
#import "FoalScoreAFAPIClient.h"
#import "UiModal.h"
@interface ListOfFoalsChoosingToAttachedViewController : UIViewController

@property (nonatomic, assign)BOOL isSurvivalScore;
@property (nonatomic, copy) NSString* scoreID;


@end
