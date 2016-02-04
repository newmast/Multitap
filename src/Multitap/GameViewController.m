//
//  MenuViewController.m
//  Multitap
//
//  Created by Nick on 2/2/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import "GameViewController.h"

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
    self.topBarView.layer.zPosition = 1;
    // Initialize top bar view components
    self.pointsLabel.textColor = [UIColor whiteColor];
    self.pointsLabel.text = @"0";
    self.pointsLabel.textAlignment = NSTextAlignmentCenter;
    self.pointsLabel.center = self.topBarView.center;
    // Initialize game view components
    _speed = 4;
    _rowHeight = self.gameView.bounds.size.height / 8;
    _rowWidth = self.gameView.bounds.size.width;
    
    [self spawnRow];
    [NSTimer scheduledTimerWithTimeInterval: _speed / ceil(self.gameView.bounds.size.height + 1) * floor(0.9 * _rowHeight)
                                     target:self
                                   selector:@selector(spawnRow)
                                   userInfo:nil
                                    repeats:YES];
    
    [self changeMainColor];
    [NSTimer scheduledTimerWithTimeInterval: 10
                                     target:self
                                   selector:@selector(changeMainColor)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)changeMainColor
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.topBarView.backgroundColor = [GameColors getRandomColor];
    });
}

- (void)updatePoints: (UIButton *)clickedView
{
    NSInteger currentPoints = [[self.pointsLabel text] integerValue];
    UIImage *img = nil;
    if (CGColorEqualToColor([clickedView backgroundColor].CGColor, [self.topBarView backgroundColor].CGColor))
    {
        currentPoints++;
        img = [UIImage imageNamed:@"broken_glass"];
    }
    else
    {
        currentPoints--;
    }
    
    if (img != nil)
    {
        [clickedView setImage:img forState:UIControlStateNormal];
    }
    self.pointsLabel.text = [NSString stringWithFormat:@"%ld", currentPoints];
}

- (void)touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.gameView];
    
    for (FallingBlocksView *view in self.gameView.subviews)
    {
        if ([view.layer.presentationLayer hitTest: touchLocation]) {
            for (UIButton *buttonView in view.subviews)
            {
                if ([buttonView.layer.presentationLayer hitTest: touchLocation]) {
                    if (![buttonView backgroundImageForState:UIControlStateNormal])
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self updatePoints:buttonView];
                        });
                    }
                    break;
                }
            }
        }
    }
}

- (void)spawnRow {
    int numberOfColumns = 4;
    double blockHeight = _rowHeight;
    double blockWidth = _rowWidth / numberOfColumns;
    
    FallingBlocksView *row = [FallingBlocksView fallingBlockWithColumns:numberOfColumns
                                                              andHeight:_rowHeight
                                                               andWidth:_rowWidth];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.gameView addSubview:row];
        
    });
    [UIButton animateWithDuration: _speed
                            delay: 0
                          options: UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                       animations:^{
                            for (UIButton *buttonView in row.subviews)
                            {
                                buttonView.frame = CGRectMake(buttonView.tag * blockWidth, self.gameView.bounds.size.height + blockHeight, blockWidth, blockHeight);
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