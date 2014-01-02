//
//  ViewController.h
//  if26_vote_loginPage
//
//  Created by if26 on 17/12/13.
//  Copyright (c) 2013 utt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtUsername;

@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

- (IBAction)submitButton:(id)sender;
- (IBAction)backgroundClick:(id)sender;

@end
