//
//  PollViewController.h
//  if26_vote_loginPage
//
//  Created by jean on 03/01/14.
//  Copyright (c) 2014 utt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vote.h"

@interface PollViewController : UIViewController<UIPickerViewDelegate, NSURLConnectionDelegate>
{
    NSMutableData *_responseData;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnDone;
@property (weak, nonatomic) Vote *v;

@end
