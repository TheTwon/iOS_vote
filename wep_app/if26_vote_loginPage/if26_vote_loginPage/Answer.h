//
//  Answer.h
//  if26_vote_loginPage
//
//  Created by jean on 03/01/14.
//  Copyright (c) 2014 utt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Answer : NSObject

@property (nonatomic, copy) NSString *description;
@property (nonatomic, assign) NSNumber *pollId;
@property (nonatomic, assign) NSNumber *answerId;

@end
