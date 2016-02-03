//
//  FallingRow.m
//  Multitap
//
//  Created by Nick on 2/2/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import "FallingRow.h"

@implementation FallingRow

- (void)drawRect:(CGRect)rect {
    double buttonSize = rect.size.width / 4;
    
    UIButton *leftmost = [[UIButton alloc] initWithFrame: CGRectMake(0 * buttonSize, 0, buttonSize, buttonSize)];
    UIButton *left = [[UIButton alloc] initWithFrame: CGRectMake(1 * buttonSize, 0, buttonSize, buttonSize)];
    UIButton *right = [[UIButton alloc] initWithFrame: CGRectMake(2 * buttonSize, 0, buttonSize, buttonSize)];
    UIButton *rightmost = [[UIButton alloc] initWithFrame: CGRectMake(3 * buttonSize, 0, buttonSize, buttonSize)];
}

@end
