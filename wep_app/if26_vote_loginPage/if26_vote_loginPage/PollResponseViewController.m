//
//  PollResponseViewController.m
//  if26_vote_loginPage
//
//  Created by jean on 06/01/14.
//  Copyright (c) 2014 utt. All rights reserved.
//

#import "PollResponseViewController.h"
#import "User.h"

@interface PollResponseViewController ()

@end

@implementation PollResponseViewController

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
	[self httpGetVotResponse:suser.login withToken:suser.token withPollId:sid];
	_txtVoteResp.editable = NO;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (void) httpGetVotResponse: (NSString *) userLogin withToken: (NSString *) userToken withPollId:(NSString *) pollId;
{
	
	NSString *strUri = [NSString stringWithFormat:@"https://127.0.0.1:8000/%@/polls/%@/results?token=%@",userLogin, pollId, userToken];
	
	NSLog(@"URI::%@", strUri);
	
	
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strUri]];
	
	// Create url connection and fire request
	NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
}




- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	// The request is complete and data has been received
	// You can parse the stuff in your instance variable now
	
	
	NSError *e;
	NSDictionary *respDict = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&e];
	
	//toutes les réponses
	NSArray *res = [respDict objectForKey:@"results"];
	

	
	NSString *strTitle = [respDict objectForKey:@"description"];
	strTitle = [NSString stringWithFormat:@"\r TITLE: \r %@ \r\r", strTitle];
	//_txtVoteResp.text = [NSString stringWithFormat:@"%@", respDict];

	_txtVoteResp.text = strTitle;
	_txtVoteResp.text = [_txtVoteResp.text stringByAppendingString:@"\r\r ANSWERS: \r\r"];


	

	int tot = 0;
	for (NSDictionary *ia in res){
		
		NSNumber *tmpNumAns = [ia objectForKey:@"num_resp"];
		//int tmpNumAns = tmpTmpNumAns.intValue;
		tot += tmpNumAns.intValue;
	}
	
	NSNumber *total = [NSNumber numberWithInt:tot];
	
	NSString *strTots = [NSString stringWithFormat:@"\r number of votes:  %@\r------------------\r", total];
	_txtVoteResp.text = [_txtVoteResp.text stringByAppendingString:strTots];
	
	
	for (NSDictionary *ia in res){
		
		NSString *strDesc = [ia objectForKey:@"description"];
		NSNumber *numRep = [ia objectForKey:@"num_resp"];
		
		NSNumber *percentage;
		if(total.doubleValue > 0)
		{
			percentage = [NSNumber numberWithDouble:(numRep.doubleValue/total.doubleValue)*100];
		}
		else
		{
			percentage = [NSNumber numberWithDouble:0];
		}
		
		NSLog(@"numvotes:: %@", [ia objectForKey:@"num_resp"]);
		
		strDesc = [NSString stringWithFormat:@"\r %@ : %@ votes ///  %@ %% \r------------------", strDesc, numRep, percentage];
		
		_txtVoteResp.text = [_txtVoteResp.text stringByAppendingString:strDesc];
		
	}
	/*
	NSString *title = [respDict objectForKey:@"title"];
	NSString *desc = [respDict objectForKey:@"description"];
	
	
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
	
	 */
	
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
