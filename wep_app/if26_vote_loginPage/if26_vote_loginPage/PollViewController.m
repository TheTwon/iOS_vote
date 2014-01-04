//
//  PollViewController.m
//  if26_vote_loginPage
//
//  Created by jean on 03/01/14.
//  Copyright (c) 2014 utt. All rights reserved.
//

#import "PollViewController.h"
#import "User.h"
#import "Answer.h"

@interface PollViewController ()

@end

@implementation PollViewController
{
	NSArray *answers;
	UIPickerView *myPickerView;
}

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
	myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 140, 320, 150)];
	myPickerView.delegate = self;
	myPickerView.showsSelectionIndicator = YES;
	[self.view addSubview:myPickerView];
	
	//NSLog(@"--- %d", _v.pollId);
	NSString *sid = [_v.pollId stringValue];

	User *suser = [User userSingleton];
	[self httpGetVote:suser.login withToken:suser.token withPollId:sid];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows = [answers count] - 1;
	
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
	if (![answers count])
		{
			NSLog(@"EMPTY:: %@", answers);
			title = [@"" stringByAppendingFormat:@"%d",row];
		}
	else {
			NSLog(@"FULL:: %@", answers);
			title = answers[row];
	}
    
	
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	int sectionWidth = 300;
	
	return sectionWidth;
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


- (void) httpGetVote: (NSString *) userLogin withToken: (NSString *) userToken withPollId:(NSString *) pollId;
{
	
	NSString *strUri = [NSString stringWithFormat:@"https://127.0.0.1:8000/poll?login=%@&token=%@&poll_id=%@",userLogin, userToken, pollId];
	
	
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strUri]];
	
	// Create url connection and fire request
	NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	// The request is complete and data has been received
	// You can parse the stuff in your instance variable now
	
	
	NSError *e;
	NSDictionary *respDict = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&e];
	
	NSArray *ans = [respDict objectForKey:@"answers"];

	
	NSString *status = [respDict objectForKey:@"status"];
	
	NSMutableArray *tmpAnswers = [NSMutableArray arrayWithCapacity:20];
	
	for (NSDictionary *ia in ans){
		
		Answer *a = [[Answer alloc] init];
		a.answerId = [ia objectForKey:@"id"];
		a.description = [ia objectForKey:@"description"];
		a.pollId = _v.pollId;
		
		[tmpAnswers addObject:a];
		
	}
	
	answers = tmpAnswers;
	
	NSLog(@"answers: %@", ans);
	NSLog(@"status: %@", status);

	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"dbg"
													message:@"tfygvhbjn"
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
	//[self.tableView reloadData];
	[myPickerView reloadAllComponents];
	
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
