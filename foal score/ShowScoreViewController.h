//
//  ShowScoreViewController.h
//  foal score
//
//  Created by Jun on 2/13/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListOfFoalsChoosingToAttachedViewController.h"
#import "UiModal.h"
@interface ShowScoreViewController : UIViewController

@property(nonatomic, assign) NSInteger survivalScore;

@property(nonatomic, copy)NSString* scoreID;
@property(nonatomic, assign) BOOL networkError;

@end
