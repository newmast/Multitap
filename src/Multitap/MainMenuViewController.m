
//
//  MainMenuViewController.m
//  Multitap
//
//  Created by Nick on 2/3/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import "MainMenuViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self.titleLabel setText:@"MULTITAP"];
    
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
    
    [self.stackView addArrangedSubview:button];
}

-(void)startGame {
    [self performSegueWithIdentifier:@"startGame"
                              sender:self];
}

-(void)handleSwipe {
    [self performSegueWithIdentifier:@"optionsSegue"
                              sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
