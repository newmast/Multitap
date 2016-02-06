//
//  FallingBlocksView.m
//  Multitap
//
//  Created by Nick on 2/2/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import "FallingBlocksView.h"

@implementation FallingBlocksView

+(instancetype) fallingBlockWithColumns: (int)numberOfColumns
                              andHeight: (double)rowHeight
                               andWidth: (double)rowWidth
{
    rowHeight = ceil(rowHeight);
    rowWidth = ceil(rowWidth);
    FallingBlocksView *row = [FallingBlocksView new];
    CGRect frame = CGRectMake(0, 0, rowWidth, rowHeight);
    row.frame = frame;
    
    double blockHeight = rowHeight;
    double blockWidth = ceil(rowWidth / numberOfColumns);
    
    // todo: try with uiview
    for (int i = 0; i < numberOfColumns; i++)
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * blockWidth, 0, blockWidth, blockHeight)];
        [button.layer removeAllAnimations];
        [button setBackgroundColor: [GameColors getRandomColor]];
        [button setTitle: @"" forState:UIControlStateNormal];
        [button setTag:i];
        [row addSubview:button];
    }
    
    return row;
}



@end
