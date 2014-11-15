//
//  Wallet.h
//  Honeypot
//
//  Created by Ala Park on 11/14/14.
//  Copyright (c) 2014 Andrew Arnopoulos. All rights reserved.
//

#ifndef Wallet_H_
#define Wallet_H_

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface Wallet : NSObject 

@property SKSpriteNode *sprite;
@property double starty;

@property NSString *name;
@property NSString* ID;
@property NSString* update_at;
@property NSString* hex;
@property NSString* created_at;
@property NSString* wallet_id;
@property bool compromised;

-(void)touched;
-(Wallet*)createWalletWithID:(NSString*)i andUpdateAt:(NSString*)u andHex:(NSString*)h andName:(NSString*)n andCreateAt:(NSString*)c andWalletID:(NSString*)w andCompromised:(NSNumber*)comp;

@end

#endif