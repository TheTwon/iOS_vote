//
//  User.h
//  if26_vote_loginPage
//
//  Created by ERHART Antoine on 02/01/14.
//  Copyright (c) 2014 utt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject {
    NSString *login;
	NSString *token;
	NSNumber *logged;
}

@property (nonatomic, retain) NSString *login;
@property (nonatomic, retain) NSString *token;
@property (nonatomic, retain) NSNumber *logged;

+ (id)userSingleton;

@end
