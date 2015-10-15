//
//  User.h
//  OurCalender
//
//  Created by shuang yang on 3/11/15.
//  Copyright (c) 2015 shuang yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"

@interface User : NSObject
@property NSMutableArray *events;
+ (NSMutableArray *) getEvents;
+ (BOOL)setEvents:(NSMutableArray *)events;
+ (void)addEvents:(NSMutableArray *)event;

+ (NSString *) getUsername;
+ (void)setUsername:(NSString *)name;
@end
