//
//  ViewController.h
//  if26_vote_loginPage
//
//  Created by jean on 17/12/13.
//  Copyright (c) 2013 utt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
	NSMutableData *_responseData;
}

@property (weak, nonatomic) IBOutlet UITextField *txtUsername;

@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnNewAccount;

- (IBAction)submitButton:(id)sender;
- (IBAction)backgroundClick:(id)sender;

@end
