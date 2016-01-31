//
//  UserInfoModel.h
//  foal score
//
//  Created by Jun on 1/28/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property (nonatomic, copy) NSString* userName;
@property (nonatomic, copy) NSString* password;

- (instancetype)initWithUserName:(NSString *)name AndPassword:(NSString *)password;
- (void)modifyUserName:(NSString *)name AndPassword:(NSString *)password;
@end
