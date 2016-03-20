//
//  UserInfoModel.h
//  foal score
//
//  Created by Jun on 1/28/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject <NSCoding>

@property (nonatomic, copy) NSString* userName;
@property (nonatomic, copy) NSString* password;
@property (nonatomic, copy) NSString* email;

- (instancetype)initWithUserName:(NSString *)name AndPassword:(NSString *)password AndEmailID:(NSString *)email;
- (void)modifyUserName:(NSString *)name AndPassword:(NSString *)password AndEmailID:(NSString *)email;
@end
