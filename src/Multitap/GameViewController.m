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
    _rowHeight = self.gameView.bounds.size.height / 7;
    _rowWidth = self.gameView.bounds.size.width;
    
    [NSTimer scheduledTimerWithTimeInterval: 5
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
    CGPoint touchLocation = [touch locationInView:self.view];
    
    for (UIView *view in self.gameView.subviews)
    {
        CGRect rect = [[[view layer] presentationLayer] frame];
        if (CGRectContainsPoint(rect, touchLocation)) {
            NSLog(@"YES!");
            break;
        }
    }
}

- (void)spawnRow {
    NSArray* xibViews = [[NSBundle mainBundle] loadNibNamed:@"FallingBlocksView"
                                                      owner:self
                                                    options:nil];
    
    FallingBlocksView *row = (FallingBlocksView*)[xibViews objectAtIndex:0];
    CGRect frame = CGRectMake(0, 0, self.gameView.bounds.size.width, self.gameView.bounds.size.height / 8);
    row.frame = frame;
    double blockHeight = frame.size.height;
    double blockWidth = frame.size.width / 4;
    
    double originX = frame.origin.x;
    double originY = frame.origin.y;
    
    // TODO: Optimize!
    NSMutableArray *colors = [NSMutableArray array];
    float INCREMENT = 0.05;
    for (float hue = 0.0; hue < 1.0; hue += INCREMENT) {
        UIColor *color = [UIColor colorWithHue:hue
                                    saturation:1.0
                                    brightness:1.0
                                         alpha:1.0];
        [colors addObject:color];
    }
    NSUInteger randomIndex;
    
    randomIndex = arc4random() % [colors count];
    row.leftmostBlock.backgroundColor = colors[randomIndex];
    row.leftmostBlock.frame = CGRectMake(originX + 0 * blockWidth, originY, blockWidth, blockHeight);
    
    randomIndex = arc4random() % [colors count];
    row.leftBlock.backgroundColor = colors[randomIndex];
    row.leftBlock.frame = CGRectMake(originX + 1 * blockWidth, originY, blockWidth, blockHeight);
    
    randomIndex = arc4random() % [colors count];
    row.rightBlock.backgroundColor = colors[randomIndex];
    row.rightBlock.frame = CGRectMake(originX + 2 * blockWidth, originY, blockWidth, blockHeight);
    
    randomIndex = arc4random() % [colors count];
    row.rightmostBlock.backgroundColor = colors[randomIndex];
    row.rightmostBlock.frame = CGRectMake(originX + 3 * blockWidth, originY, blockWidth, blockHeight);
    
    [row.leftmostBlock setTitle:@"" forState:UIControlStateNormal];
    [row.leftBlock setTitle:@"" forState:UIControlStateNormal];
    [row.rightBlock setTitle:@"" forState:UIControlStateNormal];
    [row.rightmostBlock setTitle:@"" forState:UIControlStateNormal];
    
    [self.gameView addSubview:row];
    
    [UIButton animateWithDuration: _speed
                          delay: 0
                        options: UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear
                     animations:^{
                         //row.frame = CGRectMake(0, self.view.bounds.size.height, _rowWidth, _rowHeight);
                         row.center = CGPointMake(0, 0);
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