//
//  FallingBlocksView.m
//  Multitap
//
//  Created by Nick on 2/2/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import "FallingBlocksView.h"

@implementation FallingBlocksView

static int currentButtonId = 0;

-(instancetype) initWithColumns: (int)numberOfColumns
                      andHeight: (double)rowHeight
                       andWidth: (double)rowWidth
{
    rowHeight = ceil(rowHeight);
    rowWidth = ceil(rowWidth);
    FallingBlocksView *row = [FallingBlocksView new];
    CGRect frame = CGRectMake(0, -rowHeight, rowWidth, rowHeight);
    row.frame = frame;
    
    double blockHeight = rowHeight;
    double blockWidth = ceil(rowWidth / numberOfColumns);
    
    
    for (int i = 0; i < numberOfColumns; i++)
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * blockWidth, 0, blockWidth, blockHeight)];
        [button.layer removeAllAnimations];
        
        int chance = arc4random() % 15;
        
        if (chance < 3)
        {
            NSString *imageName;
            if (chance == 0)
            {
                imageName = @"doubletap.png";
            }
            else if (chance == 1)
            {
                imageName = @"longpress.png";
            }
            else if (chance == 2)
            {
                imageName = @"lightning.png";
            }
            
            UIImage *image = [UIImage imageNamed:imageName];
            [button setImage:image forState:UIControlStateNormal];
            [button.imageView setAccessibilityIdentifier:imageName];
        }
        
        [button setBackgroundColor: [GameColors getRandomColor]];
        [button setTitle: @"" forState:UIControlStateNormal];
        [button setTag:currentButtonId];
        currentButtonId++;
        [row addSubview:button];
    }
    
    return row;
}

@end
