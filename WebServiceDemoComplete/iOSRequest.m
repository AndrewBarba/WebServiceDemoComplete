//
//  iOSRequest.m
//  WebServiceDemo
//
//  Created by Andrew Barba on 10/14/12.
//  Copyright (c) 2012 Andrew Barba. All rights reserved.
//

#import "iOSRequest.h"
#import "NSString+WebService.h"

@implementation iOSRequest
+(void)requestPath:(NSString *)path onCompletion:(RequestCompletionHandler)complete
{
    // Background Queue
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    
    // URL Request
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]
                                                  cachePolicy:NSURLCacheStorageAllowedInMemoryOnly
                                              timeoutInterval:10];
    
    // Send Request
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:backgroundQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                               if (complete) complete(result,error);
                           }];
}

+(void)loginWithUserName:(NSString *)userName
             andPassword:(NSString *)password
            onCompletion:(RequestDictionaryCompletionHandler)complete
{
    // Encode ARGS for URL
    userName = [userName URLEncode];
    password = [password URLEncode];
    
    NSString *basePath = @"http://joox.fm/tutorial/index.php?";
    NSString *fullPath = [basePath stringByAppendingFormat:@"user_name=%@&password=%@",userName,password];
    
    [iOSRequest requestPath:fullPath onCompletion:^(NSString *result, NSError *error){
        if (error || [result isEqualToString:@""]) {
            if (complete) complete(nil);
        } else {
            NSDictionary *user = [result JSON];
            if (complete) complete(user);
        }
    }];
}
@end
