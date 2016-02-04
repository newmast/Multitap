//
//  ViewController.h
//  Multitap
//
//  Created by Nick on 2/2/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameColors.h"
#import "GlobalHighscore.h"
#import "FallingBlocksView.h"
#import <QuartzCore/QuartzCore.h>

@interface GameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *topBarView;
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;

@end

