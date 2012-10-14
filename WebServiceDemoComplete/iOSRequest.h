//
//  iOSRequest.h
//  WebServiceDemo
//
//  Created by Andrew Barba on 10/14/12.
//  Copyright (c) 2012 Andrew Barba. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestCompletionHandler)(NSString*,NSError*);
typedef void(^RequestDictionaryCompletionHandler)(NSDictionary*);

@interface iOSRequest : NSObject

+(void)requestPath:(NSString *)path
      onCompletion:(RequestCompletionHandler)complete;

+(void)loginWithUserName:(NSString *)userName
             andPassword:(NSString *)password
            onCompletion:(RequestDictionaryCompletionHandler)complete;
@end
