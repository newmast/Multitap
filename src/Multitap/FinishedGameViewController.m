//
//  FinishedGameViewController.m
//  Multitap
//
//  Created by Nick on 2/5/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import "FinishedGameViewController.h"

@implementation FinishedGameViewController
{
    CLLocationManager *locationManager;
    NSString *_username;
}

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
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [locationManager requestWhenInUseAuthorization];
    }
    
    
    LocalHighscore *sqlScore = [LocalHighscore new];
    [sqlScore setScore: _currentScore];
    [sqlScore save];
    
    [LocalHighscore queryByCriteria:nil result:^(id data) {
        if([data isKindOfClass:[NSArray class]]){
            NSArray *list = data;
            
            BOOL shouldBeHidden = YES;
            if ([list count] > 0) {
                long maxScore = ((LocalHighscore*)list[0]).score;
                for (LocalHighscore *score in list)
                {
                    if (score.score > maxScore)
                    {
                        maxScore = score.score;
                    }
                }
                
                shouldBeHidden = NO;
                if (maxScore < _currentScore) { // TODO: EDIT
                    shouldBeHidden = YES;
                }
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

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    [locationManager stopUpdatingLocation];
    
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = placemarks[0];
        NSString *country = placemark.country;
        
        GlobalHighscore *highscore = [GlobalHighscore object];
        NSData *imageData = UIImagePNGRepresentation([self.victorySelfieImage image]);
        PFFile *image = [PFFile fileWithData:imageData];
        
        [highscore setHighscore: _currentScore];
        [highscore setPlayerName: _username];
        [highscore setVictorySelfie: image];
        [highscore setLocation:country];
        
        [highscore saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"SUCCESS"
                                                                                     message:@"You shared your result successfully!"
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                [[self navigationController] popToRootViewControllerAnimated:YES];
            }];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }];
    }];
}

-(void)shareResultOnline {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Hello!"
                                                                   message:@"How would you like to be remembered?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action)
    {
        if (_username == nil) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                     message:@"Your name cannot be empty!"
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                       }];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
            return;
        }
        [locationManager startUpdatingLocation];
    }];
    
    [alert addAction:defaultAction];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"What's your name?";
        
        [textField addTarget:self action:@selector(getText:) forControlEvents:UIControlEventEditingChanged];
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)getText:(UITextField *)theTextField {
    if ([[theTextField text] length] == 0) {
        _username = nil;
        return;
    }
    
    _username = [theTextField text];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.victorySelfieImage;
}

@end