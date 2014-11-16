//
//  NotificationPoller.m
//  Honeypot
//
//  Created by Andrew Arnopoulos on 11/15/14.
//  Copyright (c) 2014 Andrew Arnopoulos. All rights reserved.
//

#import "NotificationPoller.h"
#import <UIKit/UIKit.h>
#import "Wallet.h"

@implementation NotificationPoller

+(NotificationPoller *) sharedInstance {
	static NotificationPoller * singleton = nil;
	if (!singleton) {
		singleton = [[NotificationPoller alloc] init];
	}
	return singleton;
}

-(void)startPolling:(int)timeInterval {
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
		NSDictionary * oldDictionary = [Wallet getWallets];
		UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
		UIUserNotificationSettings * settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
		[[UIApplication sharedApplication] registerUserNotificationSettings:settings];
		while(true) {
			
			NSDictionary * walletDictionary = [Wallet getWallets];
			
			for (id key in oldDictionary) {
				NSLog(@"%i",[walletDictionary[key] compromised]);
				if ([walletDictionary[key] compromised] && [oldDictionary[key] compromised] != true) {
					UILocalNotification * notification = [[UILocalNotification alloc] init];
					notification.fireDate = [NSDate date];
					notification.alertBody = @"One of your wallets have been compromised. Act quickly to prevent further repercussions!";
					notification.soundName = UILocalNotificationDefaultSoundName;
//					notification.applicationIconBadgeNumber
					[[UIApplication sharedApplication] scheduleLocalNotification:notification];
					
					
					break;
				}
			}
			
			oldDictionary = walletDictionary;
			sleep(timeInterval);
		}
	});
}

@end
