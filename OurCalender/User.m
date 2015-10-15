//
//  User.m
//  OurCalender
//
//  Created by shuang yang on 3/11/15.
//  Copyright (c) 2015 shuang yang. All rights reserved.
//

#import "User.h"

@interface User()

@end

static NSString* _username = nil;
static NSMutableArray* _events = nil;

@implementation User
+ (NSString *) getUsername {
    return _username;
}

+ (void) setUsername:(NSString*) value {
    _username = value;
    NSLog(@"Username recorded:%@",_username);
}
+ (NSMutableArray *) getEvents {
    return _events;
}
+ (BOOL)setEvents:(NSMutableArray *)events {
    NSSet *oldSet = [NSSet setWithArray:_events];
    NSSet *newSet = [NSSet setWithArray:events];
    
    if ([oldSet isEqualToSet:newSet]) {
        return false;
    }
    _events = events;

    return true;
    
}
+ (void)addEvents:(NSMutableArray *)event {
   [ _events addObject:event];
    
}
@end
