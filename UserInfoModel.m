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
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
        [self setUserName:[aDecoder decodeObjectForKey:@"userName"]];
        [self setPassword:[aDecoder decodeObjectForKey:@"password"]];
        [self setEmail:[aDecoder decodeObjectForKey:@"email"]];
         
    }
    return self;
}
-(instancetype)initWithUserName:(NSString *)name AndPassword:(NSString *)password AndEmailID:(NSString *)email{
    if(self = [super init]){
        self.userName = name;
        self.password = password;
        self.email = email;
    }
    return self;
}

-(void)modifyUserName:(NSString *)name AndPassword:(NSString *)password AndEmailID:(NSString *)email{
    self.userName = name;
    self.password = password;
    self.email = email;
}

@end

