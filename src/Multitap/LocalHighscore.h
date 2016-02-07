//
//  LocalHighscore.h
//  Multitap
//
//  Created by Nick on 2/5/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@interface LocalHighscore : SQLitePersistentObject

@property (nonatomic, assign) int scoreId;
@property (nonatomic, assign) long score;

@end
