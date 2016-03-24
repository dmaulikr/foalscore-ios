//
//  APIHash.h
//  foal score
//
//  Created by Danny Schlitt on 07/03/2016.
//  Copyright © 2016 osu.edu. All rights reserved.
//


// CURRENTLY USELESS!!!
// This is not complete, not being used, and going to be abandone most likely.

#import <Foundation/Foundation.h>

@interface APIHash : NSObject

+(NSString*)getToken: (NSString*)text;
+(NSString*)subHash: (NSString*)message;
@end
