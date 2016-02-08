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

@implementation GameViewController {
    double _rowHeight;
    double _rowWidth;
    double _transitionDuration;
    long _currentlyPressedButtonId;
    float _changeMainColorInterval;
    NSTimeInterval _longPressTimer;
    float _invulnerabilityTimeAfterChangeColor;
    BOOL _isPlayerInvulnerableFromDefeat;
    
    NSTimer *spawnTimer;
    NSTimer *colorTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Gestures
    self.gameView.userInteractionEnabled = YES;
    // Tap
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    [self.gameView addGestureRecognizer:tapRecognizer];
    
    // Double tap
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubleTapRecognizer setNumberOfTapsRequired:2];
    [self.gameView addGestureRecognizer:doubleTapRecognizer];
    
    // Long press
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    
    longPressRecognizer.allowableMovement = 1000.0f;
    self.gameView.userInteractionEnabled = YES;
    [self.gameView addGestureRecognizer:longPressRecognizer];
    
    self.navigationController.navigationBar.hidden = YES;
    [self.gameView layoutIfNeeded];
    self.gameView.tag = 0;
    self.topBarView.layer.zPosition = 1;
    self.progressView.layer.zPosition = 2;
    
    // Initialize top bar view components
    self.pointsLabel.textColor = [UIColor whiteColor];
    self.pointsLabel.text = @"0";
    self.pointsLabel.textAlignment = NSTextAlignmentCenter;
    self.pointsLabel.center = self.topBarView.center;
    
    // Initialize game view components
    _transitionDuration = 7;
    _rowHeight = self.gameView.bounds.size.height / 8;
    _rowWidth = self.gameView.bounds.size.width;
    _invulnerabilityTimeAfterChangeColor = 1.5;
    _isPlayerInvulnerableFromDefeat = NO;
    
    float spawnInterval = _transitionDuration / (self.gameView.bounds.size.height + 2 * _rowHeight) * _rowHeight;
    _changeMainColorInterval = 10;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self spawnRow];
            spawnTimer = [NSTimer scheduledTimerWithTimeInterval:spawnInterval
                                             target:self
                                           selector:@selector(spawnRow)
                                           userInfo:nil
                                            repeats:YES];
            
            [self changeMainColor];
            colorTimer = [NSTimer scheduledTimerWithTimeInterval:_changeMainColorInterval
                                             target:self
                                           selector:@selector(changeMainColor)
                                           userInfo:nil
                                            repeats:YES];
        });
    });
}

-(void)handleTap: (UITapGestureRecognizer *)sender {
    UIButton *block = [self getButtonAtLocation:[sender locationInView:self.gameView]];
    [self updateGameState:block
                 tapCount:1];
}

-(void)handleDoubleTap: (UITapGestureRecognizer *)sender {
    UIButton *block = [self getButtonAtLocation:[sender locationInView:self.gameView]];
    [self updateGameState:block
                 tapCount:3];
}

-(void)handleLongPress: (UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        _currentlyPressedButtonId = [self getButtonAtLocation:[sender locationInView:self.gameView]].tag;
        _longPressTimer = [[NSDate date] timeIntervalSince1970];
    }
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        NSTimeInterval end = [[NSDate date] timeIntervalSince1970];
        
        if (end - _longPressTimer < 0.25) {
            return;
        }
        
        CGPoint touch = [sender locationInView:self.gameView];
        UIButton *button = [self getButtonAtLocation:touch];
        
        if (button.tag == _currentlyPressedButtonId) {
            [self updateGameState:button tapCount:0];
        }
    }
}

- (void)changeMainColor {
    self.topBarView.backgroundColor = [GameColors getRandomColor];
    
    _isPlayerInvulnerableFromDefeat = YES;
    
    [CATransaction begin];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDuration: _invulnerabilityTimeAfterChangeColor];
    animation.autoreverses = YES;
    [animation setFromValue: [NSValue valueWithCGPoint: CGPointMake(self.pointsLabel.center.x - 10, self.pointsLabel.center.y)]];
    [animation setToValue: [NSValue valueWithCGPoint: CGPointMake(self.pointsLabel.center.x + 10, self.pointsLabel.center.y)]];
    [CATransaction setCompletionBlock:^{
        _isPlayerInvulnerableFromDefeat = NO;
    }];
    [self.pointsLabel.layer addAnimation:animation forKey:@"position"];
    [CATransaction commit];
    
    [UIView animateWithDuration:_changeMainColorInterval animations:^{
        [self.progressView setProgress:1.0 animated:YES];
    } completion:^(BOOL finished) { }];
}

- (void)updateGameState:(UIButton *)clickedView
               tapCount:(NSUInteger)tapCount {
        
    NSInteger currentPoints = [[self.pointsLabel text] integerValue];
    UIImage *img = nil;
    if (CGColorEqualToColor([clickedView backgroundColor].CGColor, [self.topBarView backgroundColor].CGColor))
    {
        int points = 1;
        if ([[clickedView.imageView accessibilityIdentifier] isEqualToString: @"longpress.png"])
        {
            if (tapCount == 0) {
                points = 5;
            } else {
                return;
            }
        }
        else if ([[clickedView.imageView accessibilityIdentifier] isEqualToString: @"doubletap.png"])
        {
            if (tapCount >= 2) {
                points = 3;
            } else {
                return;
            }
        }
        else if ([[clickedView.imageView accessibilityIdentifier] isEqualToString: @"broken_glass"])
        {
            points = 0;
        }
        
        currentPoints += points;
        img = [UIImage imageNamed:@"broken_glass"];
    }
    else
    {
        [self performSegueWithIdentifier:@"finishGame" sender:self];
    }

    dispatch_async(dispatch_get_main_queue(),^{
        if (img != nil)
        {
            [clickedView setImage:img forState:UIControlStateNormal];
            [clickedView.imageView setAccessibilityIdentifier:@"broken_glass"];
        }
        
        self.pointsLabel.text = [NSString stringWithFormat:@"%ld", currentPoints];
    });
}

- (UIButton*)getButtonAtLocation:(CGPoint) touchLocation {
    for (FallingBlocksView *view in self.gameView.subviews)
    {
        if ([view.layer.presentationLayer hitTest: touchLocation]) {
            for (UIButton *block in view.subviews)
            {
                CGRect oldFrame = [block.layer.presentationLayer frame];
                
                CGRect calibratedFrame = oldFrame;
                calibratedFrame.origin.y -= oldFrame.size.height;
                
                if (CGRectContainsPoint(calibratedFrame, touchLocation)) {
                    return block;
                }
            }
        }
    }
    
    return nil;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"finishGame"]) {
        [spawnTimer invalidate];
        [colorTimer invalidate];
        FinishedGameViewController *destViewController = segue.destinationViewController;
        destViewController.currentScore = [[self.pointsLabel text] integerValue];
    }
}

- (void)spawnRow {
    int numberOfColumns = 4;
    double blockHeight = _rowHeight;
    double blockWidth = _rowWidth / numberOfColumns;
    
    FallingBlocksView *row = [[FallingBlocksView alloc] initWithColumns:numberOfColumns
                                                              andHeight:_rowHeight
                                                               andWidth:_rowWidth];
    
    [self.gameView addSubview:row];
    
    [UIButton animateWithDuration: _transitionDuration
                            delay: 0
                          options: UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                       animations:^{
                            for (UIButton *buttonView in row.subviews)
                            {
                                buttonView.frame = CGRectMake((buttonView.tag % numberOfColumns) * blockWidth,
                                                              self.gameView.bounds.size.height + blockHeight,
                                                              blockWidth,
                                                              blockHeight);
                            }
                        }
                        completion:^(BOOL finished){
                            for (UIButton *buttonView in row.subviews)
                            {
                                if (![[buttonView.imageView accessibilityIdentifier] isEqualToString:@"broken_glass"] &&
                                    CGColorEqualToColor([buttonView backgroundColor].CGColor, [self.topBarView backgroundColor].CGColor))
                                {
                                    if (!_isPlayerInvulnerableFromDefeat)
                                    {
                                       [self performSegueWithIdentifier:@"finishGame" sender:self];
                                    }
                                }
                            }
                            [row removeFromSuperview];
                        }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end