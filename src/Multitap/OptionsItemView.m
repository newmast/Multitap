//
//  OptionsItemView.m
//  Multitap
//
//  Created by Nick on 2/6/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import "OptionsItemView.h"

@implementation OptionsItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    OptionsItemView *mainView;
    if (self)
    {
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"OptionsItemView" owner:self options:nil];
        mainView = [subviewArray objectAtIndex:0];
        [[mainView titleLabel] setFont: [[mainView titleLabel].font fontWithSize: 30.0]];
        
        [[mainView optionSlider] setValue:0.5];
    }
    return mainView;
}

-(void)awakeFromNib {
    [super awakeFromNib];
}

@end
