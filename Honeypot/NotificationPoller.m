//
//  NotificationPoller.m
//  Honeypot
//
//  Created by Andrew Arnopoulos on 11/15/14.
//  Copyright (c) 2014 Andrew Arnopoulos. All rights reserved.
//

#import "NotificationPoller.h"
#import <UIKit/UIKit.h>

@implementation NotificationPoller

+(NotificationPoller *) sharedInstance {
	static NotificationPoller * singleton = nil;
	if (!singleton) {
		singleton = [[NotificationPoller alloc] init];
	}
	return singleton;
}

-(void)startPolling:(int)timeInterval {
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
		while(true) {
			UILocalNotification *localNotification = [[UILocalNotification alloc] init];
			
			sleep(timeInterval);
		}
	});
}

@end
