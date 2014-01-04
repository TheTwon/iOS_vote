//
//  PostPoll.m
//  if26_vote_loginPage
//
//  Created by jean on 04/01/14.
//  Copyright (c) 2014 utt. All rights reserved.
//

#import "PostPoll.h"

@implementation PostPoll
{
	UIViewController *caller;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	// A response has been received, this is where we initialize the instance var you created
	// so that we can append data to it in the didReceiveData method
	// Furthermore, this method is called each time there is a redirect so reinitializing it
	// also serves to clear it
	_responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	// Append the new data to the instance variable you declared
	[_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
				  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
	// Return nil to indicate not necessary to store a cached response for this connection
	return nil;
}


-(void) setCallingController :(UIViewController *)uivc
{
	caller = uivc;
}


- (void) httpPostVote: (NSString *) userLogin withToken: (NSString *) userToken withPollId:(NSString *) pollId withAnswerId:(NSString *) answerId;
{
	
	NSString *strUri = [NSString stringWithFormat:@"https://127.0.0.1:8000/answer_poll"];
	
	
	NSMutableDictionary *reqDict = [[NSMutableDictionary alloc] init];
	//2
	[reqDict setValue:userLogin forKey:@"login"];
	[reqDict setValue:userToken forKey:@"token"];
	[reqDict setValue:pollId forKey:@"poll_id"];
	[reqDict setValue:answerId forKey:@"answer_id"];
	
	NSLog(@"dictionary::: %@", reqDict);
	NSError *err = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:reqDict options:NSJSONWritingPrettyPrinted error:&err];
	
	NSLog(@"jsondata::: %@", jsonData);
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUri]];
	
	[request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
	[request setHTTPMethod:@"POST"];
    [request setHTTPBody:[NSData dataWithData:jsonData]];
	NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSString *msg = @"vote successful";
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"success!"
													message:msg
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
	[caller.navigationController popViewControllerAnimated:YES];
	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"an error has occured");
	NSString *msg = @"an error has occured, check access to internet";
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"networking error"
													message:msg
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
}


//Ignore bad certificates, only for DEV
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
	return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	
	[challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
	
	[challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}


@end
