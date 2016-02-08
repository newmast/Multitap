
//
//  MainMenuViewController.m
//  Multitap
//
//  Created by Nick on 2/3/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import "MainMenuViewController.h"
#import "ArrowView.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self.titleLabel setText:@"MULTITAP"];
    
    [[SoundManager sharedInstance] playBackgroundMusic: @"backgroundMusic" soundExtension: @"mp3"];
    
    UISwipeGestureRecognizer *swipeRecognizer =
        [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe)];
    
    [swipeRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    
    [self.view addGestureRecognizer: swipeRecognizer];
    MenuButtonView *button = [[MenuButtonView alloc] initWithFrame: CGRectMake(0,0,200,300)];
    
    [button setTitle:@"START"
            forState:UIControlStateNormal];
    
    [button addTarget:self
               action:@selector(startGame)
     forControlEvents:UIControlEventTouchUpInside];
    
    MenuButtonView *exitButton = [[MenuButtonView alloc] initWithFrame: CGRectMake(0,0,200,300)];
    
    [exitButton setTitle:@"EXIT"
            forState:UIControlStateNormal];
    
    [exitButton addTarget:self
               action:@selector(exitGame)
     forControlEvents:UIControlEventTouchUpInside];
    
    [self.stackView addArrangedSubview:button];
    [self.stackView addArrangedSubview:exitButton];
}

-(void)startGame {
    [self performSegueWithIdentifier:@"startGame"
                              sender:self];
}

-(void)exitGame {
    exit(0);
}

-(void)handleSwipe {
    [self performSegueWithIdentifier:@"optionsSegue"
                              sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
