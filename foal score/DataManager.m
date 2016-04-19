
//
//  DataManager.m
//  foal score
//
//  Created by Jun on 1/30/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager
static BOOL first = false;
+ (BOOL)first{
    return first;
}
+ (void)setFirst:(BOOL)isFirst{
    first =isFirst;
}
+ (Boolean)loginOrNot{
    UserInfoModel* user = [DataManager userInfo];
    if (user!=nil && user.flag == true) {
        return true;
    }else{
        return false;
    }
}
+ (UserInfoModel *)userInfo{
    // nextline only run once if it is started with static
    static UserInfoModel* userInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [DataManager userInfoArchivePath];
        userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if(!userInfo){
            userInfo =  [[UserInfoModel alloc]init];
        }
    });
    return userInfo;
}

+ (NSMutableArray *)foals{
    // nextline only run once if it is started with static
    static NSMutableArray* foals = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [DataManager foalInfoArchivePath];
        foals = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if(!foals){
            foals = [[NSMutableArray alloc]init];
        }
    });
    return foals;
}

+ (NSString *)foalInfoArchivePath{
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"foalInfo.archive"];
}

+ (NSString *)userInfoArchivePath{
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"userInfo.archive"];
}

+ (BOOL)saveChanges{
    NSString *path_user = [DataManager userInfoArchivePath];
    NSString *path_info = [DataManager foalInfoArchivePath];
    BOOL flag2 = [NSKeyedArchiver archiveRootObject:[DataManager userInfo] toFile:path_user];
    BOOL flag1 = [NSKeyedArchiver archiveRootObject:[DataManager foals] toFile:path_info];
    return flag1&&flag2;
}

@end
