//
//  NSURLRequest+IgnoreSSL.m
//  if26_vote_loginPage
//
//  Created by jean on 02/01/14.
//  Copyright (c) 2014 utt. All rights reserved.
//

#import "NSURLRequest+IgnoreSSL.h"

@implementation NSURLRequest (IgnoreSSL)

	+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host
	{
	// ignore certificate errors only for this domain
	if ([host hasSuffix:@"127.0.0.1"])
		{
		return YES;
		}
	else
		{
		return NO;
		}
	}
	
	@end