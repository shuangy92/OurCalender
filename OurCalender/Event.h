//
//  Event.h
//  OurCalender
//
//  Created by shuang yang on 3/11/15.
//  Copyright (c) 2015 shuang yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject
@property NSString* hostname;
@property NSString* eventTitle;
@property NSString* eventLocation;
@property NSString* startDate;
@property NSString* endDate;
@property NSString* eventDetail;
@property NSString* invites;
@end

