//
//  APIHash.h
//  foal score
//
//  Created by Danny Schlitt on 07/03/2016.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIHash : NSObject

+(NSString*)getToken: (NSString*)text;
+(NSString*)subHash: (NSString*)message;
@end
