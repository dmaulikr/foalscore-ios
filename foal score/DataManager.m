
//
//  DataManager.m
//  foal score
//
//  Created by Jun on 1/30/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager
+ (UserInfoModel *)userInfo{
    // nextline only run once if it is started with static
    static UserInfoModel* userInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [[UserInfoModel alloc]init];
        
    });
    return userInfo;
}

+ (NSMutableArray *)foals{
    // nextline only run once if it is started with static
    static NSMutableArray* foals = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        foals = [[NSMutableArray alloc]init];
        // Test---------------------------------------
        FoalInfoModel* foal1 = [[FoalInfoModel alloc]initWithName:@"foal1" Age:1 Breed:@"haha" Temperature:12 RespiratoryRate:122 HeartRate:323 Sex:@"Colt" Dystocia:YES SurvivalUntilDischarge:YES Date:[NSDate date]];
        FoalInfoModel* foal2 = [[FoalInfoModel alloc]initWithName:@"foal2" Age:1 Breed:@"haha" Temperature:12 RespiratoryRate:122 HeartRate:323 Sex:@"Filly" Dystocia:YES SurvivalUntilDischarge:YES Date:[NSDate date]];
        [foals addObject:foal1];
        [foals addObject:foal2];
    });
    return foals;
}

@end
