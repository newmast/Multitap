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
    FallingBlocksView *row = [FallingBlocksView new];
    CGRect frame = CGRectMake(0, 0, rowWidth, rowHeight);
    row.frame = frame;
    
    double blockHeight = rowHeight;
    double blockWidth = rowWidth / numberOfColumns;
    
    double originX = frame.origin.x;
    double originY = frame.origin.y;
    
    for (int i = 0; i < numberOfColumns; i++)
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(originX + i * blockWidth, originY, blockWidth, blockHeight)];
        
        button.backgroundColor = [GameColors getRandomColor];
        [button setTitle: @"" forState:UIControlStateNormal];
        [button setTag:i];
        [row addSubview:button];
    }
    
    return row;
}



@end
