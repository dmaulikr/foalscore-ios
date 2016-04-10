//
//  HtmlStriper.m
//  foal score
//
//  Created by Jun on 4/3/16.
//  Copyright © 2016 osu.edu. All rights reserved.
//

#import "HtmlStriper.h"

@implementation HtmlStriper

+(NSString *)stringByStrippingHTML:(NSString*)str
{
    NSRange r;
    while ((r = [str rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location     != NSNotFound)
    {
        str = [str stringByReplacingCharactersInRange:r withString:@""];
    }
    str = [str stringByReplacingOccurrencesOfString:@"&ge;"withString:@"≥ "];
    str = [str stringByReplacingOccurrencesOfString:@"&le;"withString:@"≤"];

    return str;
}

@end
