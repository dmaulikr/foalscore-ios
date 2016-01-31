
//
//  DataManager.m
//  foal score
//
//  Created by Jun on 1/30/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager
+(UserInfoModel *)userInfo{
    // nextline only run once if it is started with static
    static UserInfoModel* userInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [[UserInfoModel alloc]init];
        
    });
    return userInfo;
}
@end
