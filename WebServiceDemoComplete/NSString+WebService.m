//
//  NSString+WebService.m
//  WebServiceDemo
//
//  Created by Andrew Barba on 10/14/12.
//  Copyright (c) 2012 Andrew Barba. All rights reserved.
//

#import "NSString+WebService.h"

@implementation NSString (WebService)
-(id)JSON
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data
                                           options:NSJSONReadingMutableLeaves|NSJSONReadingMutableContainers
                                             error:nil];
}

-(NSString *)URLEncode
{
    return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                     NULL,
                                                                     (__bridge CFStringRef)self,
                                                                     NULL,
                                                                     (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                     kCFStringEncodingUTF8));
}
@end
