//
//  APIHash.m
//  foal score
//
//  Created by Danny Schlitt on 07/03/2016.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "APIHash.h"
#import <CommonCrypto/CommonDigest.h>

@interface APIHash()
+()hash;
@end

@implementation APIHash

+(NSString*)getToken:(NSString *)text
{
    NSString* saltedHash = [[self subHash:text] stringByAppendingString:@"e2f7337be7aaa1de9d25d79d679e6913"];
    return [self subHash:saltedHash];
}

+(NSString*)subHash: (NSString*)message
{
    unsigned char hashedChars[32];
    NSData *inputData = [message dataUsingEncoding:NSUTF8StringEncoding];
    CC_SHA256(inputData.bytes, inputData.length, hashedChars);
    return [[NSString alloc] initWithBytes:hashedChars length:sizeof(hashedChars) encoding:NSUTF8StringEncoding];
}

@end