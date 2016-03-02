//
//  FoalScoreAFAPIClient.h
//  foal score
//
//  Created by wi800 on 3/2/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface FoalScoreAFAPIClient : AFHTTPSessionManager
+ (instancetype)sharedClient;
@end
