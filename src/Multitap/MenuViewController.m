//
//  MenuViewController.m
//  Multitap
//
//  Created by Nick on 2/2/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import "MenuViewController.h"
#import "FallingBlocksView.h"

@interface MenuViewController ()

@end

@implementation MenuViewController
{
    double buttonSize;
    int isRed;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.gameView layoutIfNeeded];
    isRed = 0;
    buttonSize = self.gameView.bounds.size.width / 4;
    
    [NSTimer scheduledTimerWithTimeInterval:6
                                     target:self
                                   selector:@selector(spawnRow)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)spawnRow {
    FallingBlocksView *row = [[[[NSBundle mainBundle] loadNibNamed:@"FallingBlocksView" owner:self options:nil] lastObject] initWithFrame:CGRectMake(0, 0, 200, 200)];
    //UIButton *button = [[UIButton alloc] initWithFrame: CGRectMake(0, 200, buttonSize, buttonSize)];
    
    
    [self.view addSubview:row];
    
    [UIView animateWithDuration:6
                          delay: 0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         row.frame = CGRectMake(0, self.view.bounds.size.height, row.frame.size.width, row.frame.size.width);
                     }
                     completion:^(BOOL finished){
                         [row removeFromSuperview];
                     }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end