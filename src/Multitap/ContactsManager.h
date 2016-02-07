//
//  ContactsManager.h
//  Multitap
//
//  Created by Nick on 2/6/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Contacts/Contacts.h>

@interface ContactsManager : NSObject

-(void)getContacts: (void(^)(NSArray* contacts))completionHandler;

-(void)getRandomPersonName: (void(^)(NSString *name))completionHandler;

@end
