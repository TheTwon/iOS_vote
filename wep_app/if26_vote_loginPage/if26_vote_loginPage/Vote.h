//
//  Vote.h
//  if26_vote_loginPage
//
//  Created by ERHART Antoine on 19/12/13.
//  Copyright (c) 2013 utt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vote : NSObject

@property (nonatomic, copy) NSString *nom;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, assign) int candidat1;
@property (nonatomic, assign) int candidat2;


@end
