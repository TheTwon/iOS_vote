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


-(void)loginUser:(NSString *)login password:(NSString *)pwd
{
	NSString *strUri = [NSString stringWithFormat:@"http://127.0.0.1:8000/login?login=%@&pwd=%@",login, pwd];
	
	NSLog(@"string url: %@", strUri);
	NSURL *nsUri = [NSURL URLWithString:strUri];
	NSLog(@"nsurl: %@", nsUri);
	NSURLRequest *req = [NSURLRequest requestWithURL:nsUri
                                         cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                     timeoutInterval:60.0];
	
	NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
	
	if (conn) {
        NSLog(@"Connection is up.");
        receivedData = [NSMutableData data];
        NSLog(@"%@", [[conn currentRequest] URL]);
    }
}
@end
