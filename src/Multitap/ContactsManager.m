//
//  ContactsManager.m
//  Multitap
//
//  Created by Nick on 2/6/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import "ContactsManager.h"

@implementation ContactsManager
{
    CNContactStore *store;
}

-(instancetype)init {
    self = [super init];
    
    if (self) {
        store = [[CNContactStore alloc] init];
    }
    
    return self;
}

-(void)getContacts: (void(^)(NSArray* contacts))completionHandler {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            NSArray *keys = @[CNContactGivenNameKey];
            NSString *containerId = store.defaultContainerIdentifier;
            NSPredicate *predicate = [CNContact predicateForContactsInContainerWithIdentifier:containerId];
            NSError *error;
            NSArray *cnContacts = [store unifiedContactsMatchingPredicate:predicate keysToFetch:keys error:&error];
            if (error) {
                NSLog(@"Error fetching contacts %@", error);
            } else {
                for (CNContact *contact in cnContacts) {
                    [result addObject: contact.givenName];
                }
                
                completionHandler(result);
            }
        }
    }];
}

-(void)getRandomPersonName: (void(^)(NSString *name))completionHandler {
    [self getContacts:^(NSArray *contacts) {
        if ([contacts count] == 0)
        {
            completionHandler(@"someone");
            return;
        }
        
        long index = arc4random() % [contacts count];
        
        completionHandler(contacts[index]);
    }];
}
@end
