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

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeBool:self.flag forKey:@"flag"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
        [self setUserName:[aDecoder decodeObjectForKey:@"userName"]];
        [self setPassword:[aDecoder decodeObjectForKey:@"password"]];
        [self setEmail:[aDecoder decodeObjectForKey:@"email"]];
        [self setUserId:[aDecoder decodeObjectForKey:@"userId"]];
        [self setFlag:[aDecoder decodeBoolForKey:@"flag"]];
    }
    return self;
}
-(instancetype)initWithUserName:(NSString *)name AndPassword:(NSString *)password AndEmailID:(NSString *)email{
    if(self = [super init]){
        self.userName = name;
        self.password = password;
        self.email = email;
        self.flag = true;
    }
    return self;
}

-(instancetype)initWithUserName:(NSString *)name AndPassword:(NSString *)password AndEmailID:(NSString *)email AndUserId:(NSString *)userId{
    if(self = [super init]){
        self.userName = name;
        self.password = password;
        self.email = email;
        self.userId = userId;
        self.flag = true;
    }
    return self;

}
-(instancetype)init{
    if(self = [super init]){
        self.flag = false;
    }
    return self;
}
-(void)modifyUserName:(NSString *)name AndPassword:(NSString *)password AndEmailID:(NSString *)email{
    self.userName = name;
    self.password = password;
    self.email = email;
    self.flag = true;
}

-(void)clearUserInfo{
    [self modifyUserName:@"" AndPassword:@"" AndEmailID:@""];
    self.userId = @"";
    self.flag = false;
}

@end

