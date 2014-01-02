//
//  RestClient.m
//  if26_vote_loginPage
//
//  Created by jean on 02/01/14.
//  Copyright (c) 2014 utt. All rights reserved.
//

#import "RestClient.h"

@implementation RestClient

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return YES;
}


- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}
@end
