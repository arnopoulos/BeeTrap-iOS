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
@property NSString *name;

-(void)touched;

@end

#endif