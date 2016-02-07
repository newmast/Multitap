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

-(void)goBack {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [[self endMessageLabel] setText:@"GAME OVER!"];
    self.navigationController.navigationBar.hidden = YES;
    MenuButtonView *button = [[MenuButtonView alloc] initWithFrame: CGRectMake(0, 0, 100, 150)];
    
    [button setTitle:@"Start over" forState:UIControlStateNormal];
    
    [button addTarget:self
              action:@selector(goBack)
    forControlEvents:UIControlEventTouchUpInside];
    
    [self.parentStackView addArrangedSubview:button];
    
    [[self callFriendMessage] setNumberOfLines:0];
    ContactsManager *manager = [[ContactsManager alloc] init];
    
    [manager getRandomPersonName:^(NSString *name) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self callFriendMessage] setText: [NSString stringWithFormat:@"Hey, don't you think %@ might enjoy this game?", name]];
        });
    }];
    
    [self.scoreLabel setText:[NSString stringWithFormat: @"Score: %ld", self.currentScore]];

    LocalHighscore *sqlScore = [LocalHighscore new];
    [sqlScore setScore: _currentScore];
    [sqlScore save];
    
    [LocalHighscore queryByCriteria:nil result:^(id data) {
        if([data isKindOfClass:[NSArray class]]){
            NSArray *list = data;
            
            long maxScore = ((LocalHighscore*)list[0]).score;
            for (LocalHighscore *score in list)
            {
                if (score.score > maxScore)
                {
                    maxScore = score.score;
                }
            }
            
            BOOL shouldBeHidden = NO;
            if (maxScore < _currentScore) {
                shouldBeHidden = YES;
            }

            self.beatRecordStackView.hidden = shouldBeHidden;
            
            if (!shouldBeHidden)
            {
                UIImage *noAvatar = [UIImage imageNamed:@"no_avatar.png"];
                [self.victorySelfieImage setImage: noAvatar];
                self.scrollView.minimumZoomScale=1;
                self.scrollView.maximumZoomScale=4.0;
                self.scrollView.contentSize = [self.victorySelfieImage frame].size;
                self.scrollView.delegate = self;
                
                [self.victorySelfieButton setTitle:@"Take victory selfie" forState:UIControlStateNormal];
                [self.shareResultsButton setTitle:@"Share highscore" forState:UIControlStateNormal];
                [self.shareResultsButton addTarget:self
                                            action:@selector(shareResultOnline)
                                  forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }];
}

-(void)shareResultOnline {
    LocationManager *manager = [[LocationManager alloc] init];
    NSLog(@"1");
    [manager fetchWithCompletion:^(CLLocation * location, NSError * error) {
        NSLog(@"2");
        CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
        [geocoder reverseGeocodeLocation:location
                       completionHandler:^(NSArray *placemarks, NSError *error) {
                           if (error){
                               NSLog(@"Geocode failed with error: %@", error);
                               return;
                           }
                           
                           CLPlacemark *placemark = [placemarks objectAtIndex:0];
                           NSLog(@"placemark.country %@",placemark.country);
                           
                       }];
        
    }];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.victorySelfieImage;
}

@end