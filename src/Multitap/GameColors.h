//
//  GameColors.h
//  Multitap
//
//  Created by Nick on 2/4/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameColors : NSObject

+(NSMutableArray *)getColors;

+(NSUInteger) getColorCount;

+(UIColor *) getRandomColor;

@end
