//
//  OptionsMenuViewController.m
//  Multitap
//
//  Created by Nick on 2/5/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import "OptionsMenuViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation OptionsMenuViewController
{
    OptionsItemView *soundView;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipeRecognizer =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe)];
    
    [swipeRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer: swipeRecognizer];

    [self.titleLabel setText:@"Options menu"];
    
    soundView = [[OptionsItemView alloc] initWithFrame: CGRectMake(0, 0, 200, 200)];
    
    [soundView.titleLabel setText:@"Is it too loud?"];
    
    float systemVolume = [[AVAudioSession sharedInstance] outputVolume];
    [soundView.optionSlider setValue:systemVolume];
    [soundView.optionSlider addTarget:self action:@selector(changeVolume) forControlEvents:UIControlEventValueChanged];
    
    [self.stackView addArrangedSubview:soundView];
}

-(void)handleSwipe {
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)changeVolume {
    [[SoundManager sharedInstance] changeVolume: [NSNumber numberWithFloat:[[soundView optionSlider] value]]];
}

@end
