//
//  PollResponseViewController.h
//  if26_vote_loginPage
//
//  Created by jean on 06/01/14.
//  Copyright (c) 2014 utt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vote.h"

@interface PollResponseViewController : UIViewController<NSURLConnectionDelegate>
{
    NSMutableData *_responseData;
}

@property (weak, nonatomic) Vote *v;

@property (weak, nonatomic) IBOutlet UITextView *txtVoteResp;

@end
