//
//  FallingBlocksView.m
//  Multitap
//
//  Created by Nick on 2/2/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import "FallingBlocksView.h"

@implementation FallingBlocksView
{
    NSMutableArray *colors;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray* xibViews = [[NSBundle mainBundle] loadNibNamed:@"FallingBlocksView"
                                                          owner:self
                                                        options:nil];
        
        FallingBlocksView* mainView = (FallingBlocksView*)[xibViews objectAtIndex:0];
        mainView.stackView.frame = frame;
        double blockSize = frame.size.width / 4;
        
        // TODO: Optimize!
        colors = [NSMutableArray array];
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
        mainView.leftmostBlock.backgroundColor = colors[randomIndex];
        mainView.leftmostBlock.frame = CGRectMake(frame.origin.x + 0 * blockSize, frame.origin.y, blockSize, blockSize);
        
        randomIndex = arc4random() % [colors count];
        mainView.leftBlock.backgroundColor = colors[randomIndex];
        mainView.leftBlock.frame = CGRectMake(frame.origin.x + 1 * blockSize, frame.origin.y, blockSize, blockSize);
        
        randomIndex = arc4random() % [colors count];
        mainView.rightBlock.backgroundColor = colors[randomIndex];
        mainView.rightBlock.frame = CGRectMake(frame.origin.x + 2 * blockSize, frame.origin.y, blockSize, blockSize);
        
        randomIndex = arc4random() % [colors count];
        mainView.rightmostBlock.backgroundColor = colors[randomIndex];
        mainView.rightmostBlock.frame = CGRectMake(frame.origin.x + 3 * blockSize, frame.origin.y, blockSize, blockSize);
        
        [self addSubview:mainView];
    }
    return self;
}

@end
