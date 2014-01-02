//
//  User.m
//  if26_vote_loginPage
//
//  Created by jean on 02/01/14.
//  Copyright (c) 2014 utt. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize login, token, logged;

#pragma mark Singleton Methods

+ (id)userSingleton {
    static User *sharedUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUser = [[self alloc] init];
    });
    return sharedUser;
}

- (id)init {
	if (self = [super init]) {
		login = @"none";
		token = @"none";
		logged = [NSNumber numberWithBool:NO];
	}
	return self;
}

- (void)dealloc {
	// Should never be called, but just here for clarity really.
}

@end
