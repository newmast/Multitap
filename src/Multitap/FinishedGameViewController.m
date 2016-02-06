//
//  FinishedGameViewController.m
//  Multitap
//
//  Created by Nick on 2/5/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import "FinishedGameViewController.h"

@implementation FinishedGameViewController

@synthesize currentScore = _currentScore;

-(void)viewDidLoad {
    [super viewDidLoad];
    [[self endMessageLabel] setText:@"GAME OVER!"];
    // get random contact;
    NSString *contactName = @"John Doe";
    [[self callFriendMessage] setNumberOfLines:0];
    [[self callFriendMessage] setText: [NSString stringWithFormat:@"Hey, don't you think %@ might enjoy this game?", contactName]];
    
    [self.scoreLabel setText:[NSString stringWithFormat: @"Score: %ld", self.currentScore]];
    
    LocalHighscore *sqlScore = [LocalHighscore new];
    
    [sqlScore setScore:_currentScore];
    
    [sqlScore save];
    
    [LocalHighscore queryAll:^(NSArray *objects) {
        long maxScore = ((LocalHighscore *)objects[0]).score;
        for(LocalHighscore *score in objects)
        {
            if (score.score > maxScore)
            {
                maxScore = score.score;
            }
        }
        
        BOOL shouldBeHidden = YES;
        if (maxScore > _currentScore) {
            shouldBeHidden = NO;
        }
        
        NSLog(@"%ld", maxScore);
        
        self.beatRecordStackView.hidden = shouldBeHidden;
    }];
    // check if score is bigger than max score!
}

@end