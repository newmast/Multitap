//
//  MenuViewController.m
//  Multitap
//
//  Created by Nick on 2/2/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import "GameViewController.h"
#import "FallingBlocksView.h"
#import <QuartzCore/QuartzCore.h>

@interface GameViewController ()
@end

@implementation GameViewController
{
    double _rowHeight;
    double _rowWidth;
    double _speed;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.gameView layoutIfNeeded];
    self.gameView.tag = 0;
    
    // Initialize top bar view components
    self.pointsLabel.textColor = [UIColor whiteColor];
    self.pointsLabel.text = @"0";
    
    // Initialize game view components
    _speed = 8;
    _rowHeight = self.gameView.bounds.size.height / 8;
    _rowWidth = self.gameView.bounds.size.width;
    
    [NSTimer scheduledTimerWithTimeInterval: 0.8
                                     target:self
                                   selector:@selector(spawnRow)
                                   userInfo:nil
                                    repeats:YES];
}

- (void) addPoints
{
    NSInteger currentPoints = [[self.pointsLabel text] integerValue];
    
    currentPoints += 1;
    
    self.pointsLabel.text = [NSString stringWithFormat:@"%ld", currentPoints];
}

- (void) touchesBegan:(NSSet *)touches
            withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.gameView];
    
    for (FallingBlocksView *view in self.gameView.subviews)
    {
        for (UIButton *buttonView in view.subviews)
        {
            if ([buttonView.layer.presentationLayer hitTest: touchLocation]) {
                [self addPoints];
                break;
            }
        }
    }
}

- (void)spawnRow {
    int numberOfColumns = 4;
    double blockHeight = _rowHeight;
    double blockWidth = _rowWidth / numberOfColumns;
    
    FallingBlocksView *row = [FallingBlocksView fallingBlockWithColumns:numberOfColumns andHeight:_rowHeight andWidth:_rowWidth];
    [self.gameView addSubview:row];
    
    [UIButton animateWithDuration: _speed
                          delay: 0
                        options: UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         for (UIButton *buttonView in row.subviews)
                         {
                             buttonView.frame = CGRectMake(buttonView.tag * blockWidth, self.view.bounds.size.height, blockWidth, blockHeight);
                         }
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