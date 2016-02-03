//
//  FallingBlocksView.h
//  Multitap
//
//  Created by Nick on 2/2/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FallingBlocksView : UIView

@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UIButton *leftmostBlock;
@property (weak, nonatomic) IBOutlet UIButton *leftBlock;
@property (weak, nonatomic) IBOutlet UIButton *rightBlock;
@property (weak, nonatomic) IBOutlet UIButton *rightmostBlock;

@end
