//
//  UserInfoModel.m
//  foal score
//
//  Created by Jun on 1/28/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "UserInfoModel.h"

@interface UserInfoModel()



@end

@implementation UserInfoModel

-(instancetype)initWithUserName:(NSString *)name AndPassword:(NSString *)password{
    if(self = [super init]){
        self.userName = name;
        self.password = password;
    }
    return self;
}

-(void)modifyUserName:(NSString *)name AndPassword:(NSString *)password{
    self.userName = name;
    self.password = password;
}

@end

