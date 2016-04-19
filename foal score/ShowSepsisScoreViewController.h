//
//  ShowSepsisScoreViewController.h
//  foal score
//
//  Created by Jun on 4/6/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListOfFoalsChoosingToAttachedViewController.h"
#import "UiModal.h"
#import "MBProgressHUD.h"
@interface ShowSepsisScoreViewController : UIViewController

@property (nonatomic, copy)NSString* message;
@property(nonatomic, assign) NSInteger sepsisScore;
@property(nonatomic, copy)NSString* scoreID;
@property(nonatomic, assign) BOOL networkError;
@property(nonatomic, assign) BOOL anyNotAvailable;
@end
