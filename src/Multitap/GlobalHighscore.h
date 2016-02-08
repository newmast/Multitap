//
//  GlobalHighscore.h
//  Multitap
//
//  Created by Nick on 2/4/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface GlobalHighscore : PFObject<PFSubclassing>

@property(nonatomic) long highscore;
@property(strong, nonatomic) NSString *playerName;
@property(strong, nonatomic) NSString *location;
@property(strong, nonatomic) PFFile *victorySelfie;

+(NSString *) parseClassName;

@end
