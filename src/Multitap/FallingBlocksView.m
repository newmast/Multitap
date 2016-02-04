//
//  FallingBlocksView.m
//  Multitap
//
//  Created by Nick on 2/2/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import "FallingBlocksView.h"

static NSMutableArray *colors;

@implementation FallingBlocksView

+(instancetype) fallingBlockWithColumns: (int)numberOfColumns
                              andHeight: (double)rowHeight
                               andWidth: (double)rowWidth
{
    NSArray* xibViews = [[NSBundle mainBundle] loadNibNamed:@"FallingBlocksView"
                                                      owner:self
                                                    options:nil];
    
    FallingBlocksView *row = (FallingBlocksView*)[xibViews objectAtIndex:0];
    CGRect frame = CGRectMake(0, 0, rowWidth, rowHeight);
    row.frame = frame;
    
    double blockHeight = rowHeight;
    double blockWidth = rowWidth / numberOfColumns;
    
    double originX = frame.origin.x;
    double originY = frame.origin.y;
    
    NSUInteger randomIndex;
    
    for (int i = 0; i < numberOfColumns; i++)
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(originX + i * blockWidth, originY, blockWidth, blockHeight)];
        randomIndex = arc4random() % [[self getColors] count];
        button.backgroundColor = [self getColors][randomIndex];
        [button setTitle: @"" forState:UIControlStateNormal];
        [button setTag:i];
        [row addSubview:button];
    }
    
    return row;
}

+(NSMutableArray *)getColors
{
    if ([colors count] == 0)
    {
        colors = [NSMutableArray array];
        float INCREMENT = 0.05;
        for (float hue = 0.0; hue < 1.0; hue += INCREMENT) {
            UIColor *color = [UIColor colorWithHue:hue
                                        saturation:1.0
                                        brightness:1.0
                                             alpha:1.0];
            [colors addObject:color];
        }
    }
    
    return colors;
}

@end
