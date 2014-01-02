//
//  NSURLRequest+IgnoreSSL.h
//  if26_vote_loginPage
//
//  Created by jean on 02/01/14.
//  Copyright (c) 2014 utt. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSURLRequest (IgnoreSSL)

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;

@end