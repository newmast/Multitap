//
//  FinishedGameViewController.h
//  Multitap
//
//  Created by Nick on 2/5/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalHighscore.h"
#import "MenuButtonView.h"
#import "ContactsManager.h"
#import <CoreLocation/CoreLocation.h>
#import "GlobalHighscore.h"

@interface FinishedGameViewController : UIViewController<UIScrollViewDelegate, CLLocationManagerDelegate>

@property (nonatomic) long currentScore;
@property (weak, nonatomic) IBOutlet UIStackView *parentStackView;
@property (weak, nonatomic) IBOutlet UILabel *endMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *callFriendMessage;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *victorySelfieImage;
@property (weak, nonatomic) IBOutlet UIButton *victorySelfieButton;
@property (weak, nonatomic) IBOutlet UIButton *shareResultsButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIStackView *beatRecordStackView;
@end
