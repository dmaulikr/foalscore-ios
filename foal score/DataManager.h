//
//  DataManager.h
//  foal score
//
//  Created by Jun on 1/30/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
#import "FoalInfoModel.h"
@interface DataManager : NSObject
@property (nonatomic, strong) UserInfoModel* userInfo;
+ (Boolean)loginOrNot;
+ (UserInfoModel *)userInfo;
+ (NSMutableArray *)foals;

+ (NSString *)foalInfoArchivePath;
+ (NSString *)userInfoArchivePath;
+ (BOOL)saveChanges;

+ (BOOL)first;
+ (void)setFirst:(BOOL)isFirst;
@end
