//
//  NotificationPoller.h
//  Honeypot
//
//  Created by Andrew Arnopoulos on 11/15/14.
//  Copyright (c) 2014 Andrew Arnopoulos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationPoller : NSObject

+(NotificationPoller *) sharedInstance;

-(void) startPolling:(int) timeInterval;

@end
