//
//  MainMenuViewController.h
//  Multitap
//
//  Created by Nick on 2/3/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuButtonView.h"
#import "Multitap-Swift.h"

@interface MainMenuViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@end
