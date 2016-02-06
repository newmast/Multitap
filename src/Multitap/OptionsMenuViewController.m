//
//  OptionsMenuViewController.m
//  Multitap
//
//  Created by Nick on 2/5/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import "OptionsMenuViewController.h"

@implementation OptionsMenuViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self.titleLabel setText:@"Mom's house"];
    
    OptionsItemView *soundView = [[OptionsItemView alloc] initWithFrame:
                                   CGRectMake(0, 0, 200, 200)];
    
    [soundView.titleLabel setText:@"Is it too loud?"];
    float systemVolume = [[AVAudioSession sharedInstance] outputVolume];
    [soundView.optionSlider setValue:systemVolume];

    [self.stackView addSubview:soundView];
}

@end
