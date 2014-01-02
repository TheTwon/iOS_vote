//
//  ViewController.m
//  if26_vote_loginPage
//
//  Created by if26 on 17/12/13.
//  Copyright (c) 2013 utt. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import "MainViewController.h"
#import "NSURLRequest+IgnoreSSL.h"
#import "RestClient.h"

@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	 self.navigationController.navigationBarHidden = YES;
	_txtPassword.secureTextEntry = YES;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) httpLogin: (NSString *) userLogin withPassword: (NSString *) userPwd;
{
	
	
	NSString *strUri = [NSString stringWithFormat:@"http://127.0.0.1:8000/login?login=%@&pwd=%@",userLogin, userPwd];
	

	//define URI

	//networking code
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUri]
														   cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
													   timeoutInterval:10];
	
	[request setHTTPMethod: @"GET"];
	
    NSError *requestError;
	NSURLResponse *urlResponse = nil;
	//[request canAuthenticateAgainstProtectionSpace:YES];
	
	
	NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
	
	//retrieve data
	NSString *strData = [[NSString alloc]initWithData:response1 encoding:NSUTF8StringEncoding];

	NSError *e = nil;
	NSDictionary *myDict = [NSJSONSerialization JSONObjectWithData:response1 options:kNilOptions error:&requestError];
	
	
	NSLog(@"%@", myDict);
	NSLog(@"%@", [myDict objectForKey:@"status"]);
	
	
	//NSDictionary *myDict = [NSJSONSerialization JSONObjectWithData:_responseData];
	 
	//check auth
	if([[myDict objectForKey:@"status"]isEqualToString:@"ok"])
	{
		NSLog(@"user logged");
		User *suser = [User userSingleton];
		suser.login = userLogin;
		suser.token = [myDict objectForKey:@"token"];
		suser.logged = [NSNumber numberWithBool:YES];
		NSLog(@"%@ %@ %@", suser.login, suser.token, suser.logged);
	
	[self performSegueWithIdentifier:@"loginsegue" sender:self];
	//MainViewController *main = [[MainViewController alloc] initWithNibName:nil bundle:nil];
	//	[self presentViewController:main animated:YES completion:NULL];
	}
	else
	{
		NSLog(@"failed auth");
		NSString *msg = @"wrong login/password combination";
	 
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"failed login"
												  message:msg
												  delegate:nil
											      cancelButtonTitle:@"OK"
												  otherButtonTitles:nil];
	 [alert show];
	}
	 
}

- (IBAction)submitButton:(id)sender {
	
	[self httpLogin:_txtUsername.text withPassword:_txtPassword.text];

	//------------
	
	/*NSString *msg =[NSString stringWithFormat:@" login: %@ pwd: %@", _txtUsername.text, @"superPWD"];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"test"
											  message:msg
											  delegate:nil
										      cancelButtonTitle:@"OK"
										      otherButtonTitles:nil];
	[alert show];
	//[alert release];*/
    
}

- (IBAction)backgroundClick:(id)sender {
    [_txtUsername resignFirstResponder];
    [_txtPassword resignFirstResponder];
}




@end
