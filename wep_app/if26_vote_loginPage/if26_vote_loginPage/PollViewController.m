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
#import "PostPoll.h"

@interface PollViewController ()

@end

@implementation PollViewController
{
	NSArray *answers;
	NSMutableArray *superAnswers;
	NSArray *awesomeAnswers;
	UIPickerView *myPickerView;
	NSNumber *selectedRow;
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
	User *suser = [User userSingleton];
	NSString *sid = [_v.pollId stringValue];
	[self httpGetVote:suser.login withToken:suser.token withPollId:sid];
	// Do any additional setup after loading the view.
}


-(void) addChoicePicker
{
	myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 145, 320, 150)];
	myPickerView.delegate = self;
	myPickerView.showsSelectionIndicator = YES;
	[self.view addSubview:myPickerView];
	
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {

	selectedRow = [NSNumber numberWithInt:row];
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows = [answers count];
	
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
			title = [@"" stringByAppendingFormat:@"%d",row];
		}
	else {
			//NSLog(@"FULL:: %@", answers);
			Answer *a = [answers objectAtIndex:row];
			title = a.description;
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

	awesomeAnswers = ans;
	NSString *status = [respDict objectForKey:@"status"];
	NSString *title = [respDict objectForKey:@"title"];
	NSString *desc = [respDict objectForKey:@"description"];
	
	_lblPollDesc.text = desc;
	_lblPollTitle.text = title;
	
	NSMutableArray *tmpAnswers = [NSMutableArray arrayWithCapacity:20];
	
	superAnswers = [NSMutableArray arrayWithCapacity:ans.count];
	for (NSDictionary *ia in ans){
		
		Answer *a = [[Answer alloc] init];
		NSNumber *tmpaId = [ia objectForKey:@"id"];
		a.answerId = tmpaId;
		a.description = [ia objectForKey:@"description"];
		a.pollId = _v.pollId;
		
		[tmpAnswers addObject:a];
		[superAnswers addObject:a];
	}
	
	
	answers =  [tmpAnswers copy];

	[self addChoicePicker];
	
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



- (IBAction)btnPressed:(id)sender {
	
	/*
	PostPoll *pollPoster = [PostPoll alloc];
	NSString *pid =  [_v.pollId stringValue];
	Answer *a = [answers objectAtIndex:(int)selectedRow];
	NSNumber *dbgNum = a.answerId;
	NSString *aid = [a.answerId stringValue];
	
	User *suser = [User userSingleton];
	//[pollPoster httpPostVote:suser.login withToken:suser.token withPollId:pid withAnswerId:aid];
	 */
	if(selectedRow == NULL)
		{
			selectedRow = [[NSNumber alloc] initWithInt:0];
		}
	Answer *a = [superAnswers objectAtIndex:selectedRow.intValue];
	
	
	PostPoll *pollPoster = [PostPoll alloc];
	User *suser = [User userSingleton];
	NSString *pid =  [_v.pollId stringValue];
	[pollPoster setCallingController:self];
	[pollPoster httpPostVote:suser.login withToken:suser.token withPollId:pid withAnswerId:a.answerId.stringValue];
}
@end
