//
//  VotesEnCoursViewController.h
//  if26_vote_loginPage
//
//  Created by ERHART Antoine on 19/12/13.
//  Copyright (c) 2013 utt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VotesEnCoursViewController : UITableViewController <NSURLConnectionDelegate>
{
    NSMutableData *_responseData;
}
@property (nonatomic, strong) NSMutableArray *votes;


@end
