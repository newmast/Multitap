//
//  GameColors.m
//  Multitap
//
//  Created by Nick on 2/4/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import "GameColors.h"

@implementation GameColors

static NSMutableArray *colors;

+(NSMutableArray *)getColors {
    if ([colors count] == 0)
    {
        colors = [NSMutableArray array];
        float INCREMENT = 0.2;
        for (float hue = 0.0; hue < 1; hue += INCREMENT) {
            UIColor *color = [UIColor colorWithHue:hue
                                        saturation:1.0
                                        brightness:1.0
                                             alpha:1.0];
            [colors addObject:color];
        }
    }
    
    return colors;
}

+(NSUInteger) getColorCount {
    if ([colors count] == 0)
    {
        [self getColors];
    }
    
    return [colors count];
}

+(UIColor *) getRandomColor {
    NSUInteger randomIndex = arc4random() % [self getColorCount];
    
    return [self getColors][randomIndex];
}

@end
