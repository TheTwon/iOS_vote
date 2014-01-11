//
//  NewAccountViewController.m
//  if26_vote_loginPage
//
//  Created by ERHART Antoine on 04/01/14.
//  Copyright (c) 2014 utt. All rights reserved.
//

#import "NewAccountViewController.h"

@interface NewAccountViewController ()

@end

@implementation NewAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[[self navigationController] setNavigationBarHidden:NO animated:YES];
	_txtNewPwd.secureTextEntry = YES;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[_txtNewPwd resignFirstResponder];
    [_txtNewName resignFirstResponder];
}

- (IBAction)createUser:(id)sender {
	//do connection here
	NSString *msg = @"bubadibip";
	
	if([_txtNewName.text isEqualToString:@""] || [_txtNewPwd.text isEqualToString:@""])
		{
			msg = @"empty parameters";
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"invalid imputs"
														message:msg
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
			[alert show];
		}
	else
		{
			[self httpPostNewUser:_txtNewName.text withPwd:_txtNewPwd.text];
		}

}

- (IBAction)backgroundClick:(id)sender {
    [_txtNewPwd resignFirstResponder];
    [_txtNewName resignFirstResponder];
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


- (void) httpPostNewUser: (NSString *) userLogin withPwd: (NSString *) userPwd;
{
	
	NSString *strUri = [NSString stringWithFormat:@"https://127.0.0.1:8000/users/%@", userLogin];
	
	NSMutableDictionary *reqDict = [[NSMutableDictionary alloc] init];
	//2
	//[reqDict setValue:userLogin forKey:@"login"];
	[reqDict setValue:userPwd forKey:@"pwd"];

	
	NSLog(@"dictionary::: %@", reqDict);
	NSError *err = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:reqDict options:NSJSONWritingPrettyPrinted error:&err];
	
	NSLog(@"jsondata::: %@", jsonData);
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUri]];
	
	[request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
	[request setHTTPMethod:@"PUT"];
    [request setHTTPBody:[NSData dataWithData:jsonData]];
	// Create url connection and fire request
	NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	// The request is complete and data has been received
	// You can parse the stuff in your instance variable now
	
	NSError *e;
	NSDictionary *respDict = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&e];
	
	NSLog(@"echoed:::: %@", respDict);
	NSString *status = [respDict objectForKey:@"status"];
	
	if(![status isEqualToString:@"ok"]){
		NSString *error = [respDict objectForKey:@"error_type"];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error creating user"
														message:error
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
		[alert show];
	}
	else
	{

	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"user created"
													message:@"congratulations!!!"
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
	[self.navigationController popViewControllerAnimated:YES]; 
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
