//
//  FinishedGameViewController.m
//  Multitap
//
//  Created by Nick on 2/5/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import "FinishedGameViewController.h"

@implementation FinishedGameViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [[self endMessageLabel] setText:@"GAME OVER!"];
    // get random contact;
    NSString *contactName = @"John Doe";
    [[self callFriendMessage] setText: [NSString stringWithFormat:@"Hey, don't you think %@ might enjoy this game?", contactName]];
    
    // check if score is bigger than max score!
}

@end