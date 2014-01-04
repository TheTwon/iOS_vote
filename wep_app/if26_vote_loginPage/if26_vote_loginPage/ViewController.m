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
{
	NSString *tmpLogin;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	 self.navigationController.navigationBarHidden = YES;
	_txtPassword.secureTextEntry = YES;
	[[self navigationController] setNavigationBarHidden:NO animated:YES];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) httpLogin: (NSString *) userLogin withPassword: (NSString *) userPwd;
{
	tmpLogin = userLogin;
	
	NSString *strUri = [NSString stringWithFormat:@"https://127.0.0.1:8000/login?login=%@&pwd=%@",userLogin, userPwd];
	

	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strUri]];
	
	// Create url connection and fire request
	NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	[[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (IBAction)submitButton:(id)sender {
	
	[self httpLogin:_txtUsername.text withPassword:_txtPassword.text];

}

- (IBAction)backgroundClick:(id)sender {
    [_txtUsername resignFirstResponder];
    [_txtPassword resignFirstResponder];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	// A response has been received, this is where we initialize the instance var you created
	// so that we can append data to it in the didReceiveData method
	// Furthermore, this method is called each time there is a redirect so reinitializing it
	// also serves to clear it
	_responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	// Append the new data to the instance variable you declared
	[_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
				  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
	// Return nil to indicate not necessary to store a cached response for this connection
	return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	// The request is complete and data has been received
	// You can parse the stuff in your instance variable now
	
	NSError *e;
	NSDictionary *respDict = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&e];
	
	if([[respDict objectForKey:@"status"]isEqualToString:@"ok"])
		{
		NSLog(@"user logged");
		User *suser = [User userSingleton];
		suser.login = tmpLogin;
		suser.token = [respDict objectForKey:@"token"];
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

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"an error has occured");
	NSString *msg = @"an error has occured, check access to internet";
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"networking error"
													message:msg
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
}


//Ignore bad certificates, only for DEV
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
	return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {

	[challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
	
	[challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}


@end
