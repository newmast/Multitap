//
//  GlobalHighscore.m
//  Multitap
//
//  Created by Nick on 2/4/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import "GlobalHighscore.h"

@implementation GlobalHighscore

@dynamic highscore;
@dynamic victorySelfie;
@dynamic playerName;

+ (void)load
{
    [self registerSubclass];
}

+(NSString *)parseClassName
{
    return @"Highscores";
}

@end
