//
//  NewAccountViewController.h
//  if26_vote_loginPage
//
//  Created by jean on 04/01/14.
//  Copyright (c) 2014 utt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewAccountViewController : UIViewController <NSURLConnectionDelegate>
{
    NSMutableData *_responseData;
}
@property (weak, nonatomic) IBOutlet UITextField *txtNewName;
@property (weak, nonatomic) IBOutlet UITextField *txtNewPwd;
@property (weak, nonatomic) IBOutlet UIButton *btnCreateAccount;


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

- (IBAction)createUser:(id)sender;

@end
