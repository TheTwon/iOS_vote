//
//  PostPoll.h
//  if26_vote_loginPage
//
//  Created by jean on 04/01/14.
//  Copyright (c) 2014 utt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostPoll : NSObject<NSURLConnectionDelegate>
{
    NSMutableData *_responseData;
}

- (void) httpPostVote: (NSString *) userLogin withToken: (NSString *) userToken withPollId:(NSString *) pollId withAnswerId:(NSString *) answerId;
-(void) setCallingController :(UIViewController *)uivc;
@end
