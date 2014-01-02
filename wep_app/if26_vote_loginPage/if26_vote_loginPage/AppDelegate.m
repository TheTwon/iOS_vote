//
//  AppDelegate.m
//  if26_vote_loginPage
//
//  Created by if26 on 17/12/13.
//  Copyright (c) 2013 utt. All rights reserved.
//

#import "AppDelegate.h"
#import "Vote.h"
#import "VotesEnCoursViewController.h"

@implementation AppDelegate{
    NSMutableArray *votes;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*votes = [NSMutableArray arrayWithCapacity:20];
	Vote *vote = [[Vote alloc] init];
	vote.nom = @"Présidence BDE";
    vote.description = @"Votez pour le nouveau président";
    vote.candidat1 = 52;
    vote.candidat2 = 23;
    [votes addObject:vote];
    
    vote = [[Vote alloc] init];
    vote.nom = @"Couleur officiel UTT";
    vote.description = @"Votez pour la couleur de l'UTT";
    vote.candidat1 = 31;
    vote.candidat2 = 43;
    [votes addObject:vote];
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
	UINavigationController *navigationController =
    [[tabBarController viewControllers] objectAtIndex:0];
	
	VotesEnCoursViewController *votesViewController =
    [[navigationController viewControllers] objectAtIndex:0];*/
	//votesViewController.votes = votes;

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
