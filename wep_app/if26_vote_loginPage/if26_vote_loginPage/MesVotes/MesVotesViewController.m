//
//  MesVotesViewController.m
//  if26_vote_loginPage
//
//  Created by ERHART Antoine on 19/12/13.
//  Copyright (c) 2013 utt. All rights reserved.
//

#import "MesVotesViewController.h"
#import "Vote.h"
#import "User.h"
#import "PollResponseViewController.h"

@interface MesVotesViewController ()

@end

@implementation MesVotesViewController

@synthesize votes;

- (void)loadInitialData {
	
	User *suser = [User userSingleton];
	
	[self httpGetAnsweredVotes:suser.login withToken:suser.token];
	

	
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self loadInitialData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.votes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"VoteCell"];
	Vote *vote = [self.votes objectAtIndex:indexPath.row];
	cell.textLabel.text = vote.nom;
	cell.detailTextLabel.text = vote.description;
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	NSLog(@"prepare for segue");
    if ([segue.identifier isEqualToString:@"pollResponseSegue"]) {
		NSLog(@"if pollResponseSegue");
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PollResponseViewController *destViewController = segue.destinationViewController;
        destViewController.v = [votes objectAtIndex:indexPath.row];
    }
}


- (void) httpGetAnsweredVotes: (NSString *) userLogin withToken: (NSString *) userToken;
{
	
	NSString *strUri = [NSString stringWithFormat:@"https://127.0.0.1:8000/answered_polls?login=%@&token=%@",userLogin, userToken];
	
	
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strUri]];
	
	// Create url connection and fire request
	NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	// The request is complete and data has been received
	// You can parse the stuff in your instance variable now
	
	NSError *e;
	NSDictionary *respDict = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&e];
	
	NSArray *userVotes = [respDict objectForKey:@"votes"];
	
	NSString *status = [respDict objectForKey:@"status"];
	
	NSMutableArray *tmpvotes = [NSMutableArray arrayWithCapacity:20];
	for (NSDictionary *ia in userVotes){// do stuff
		
		Vote *vote = [[Vote alloc] init];
		vote.nom = [ia objectForKey:@"title"];
		vote.description = [ia objectForKey:@"description"];
		vote.candidat1 = -1;
		vote.candidat2 = -1;
		vote.pollId = [ia objectForKey:@"id"];
		[tmpvotes addObject:vote];
		
	}
	//NSLog(@"-- %@", tmpvotes);
	self.votes = tmpvotes;
	[self.tableView reloadData];

	
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


//reload view at each apperance {ugly}
- (void) viewWillAppear:(BOOL)animated{
	User *suser = [User userSingleton];
	[self httpGetAnsweredVotes:suser.login withToken:suser.token];
}


@end
