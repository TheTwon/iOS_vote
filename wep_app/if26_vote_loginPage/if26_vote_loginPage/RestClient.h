//
//  RestClient.h
//  if26_vote_loginPage
//
//  Created by jean on 02/01/14.
//  Copyright (c) 2014 utt. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RestClient : NSObject <NSURLConnectionDelegate> {
    NSMutableData *receivedData;
    void (^onReceiveDataCb)(id);
}


- (NSString*)buildUrl: (NSString*)object args:(NSString*)args;
- (id)get:(NSString*)object args:(NSDictionary*)args;
- (id)post:(NSString *)object args:(NSDictionary *)args;
- (id)initWithHandle:(NSString*)handle;
- (id)initWithHandle:(NSString*)handle andKey:(NSString*)key;
- (void)onReceiveData:(void (^)(id))cb;

@end
