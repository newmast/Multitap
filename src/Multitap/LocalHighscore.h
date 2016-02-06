//
//  LocalHighscore.h
//  Multitap
//
//  Created by Nick on 2/5/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXSqliteObject.h"

@interface LocalHighscore : MXSqliteObject

@property (nonatomic, assign) int scoreId;
@property (nonatomic, assign) long score;

@end
