//
//  OptionsItemView.h
//  Multitap
//
//  Created by Nick on 2/6/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionsItemView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISlider *optionSlider;

@end
