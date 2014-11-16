//
//  Wallet.m
//  Honeypot
//
//  Created by Ala Park on 11/14/14.
//  Copyright (c) 2014 Andrew Arnopoulos. All rights reserved.
//

#import "Wallet.h"

@interface Wallet ()

+(NSArray *)getJSON;

@end

@implementation Wallet


-(void)touched
{
    //NSLog(@"%@",self.name);
}

-(Wallet*)createWalletWithID:(NSString*)i andUpdateAt:(NSString*)u andHex:(NSString*)h andName:(NSString*)n andCreateAt:(NSString*)c andWalletID:(NSString*)w andCompromised:(NSNumber*)comp
{
    self.sprite = [SKSpriteNode spriteNodeWithImageNamed:@"button_background.jpg"];
    
    SKSpriteNode* wallet_image = [SKSpriteNode spriteNodeWithImageNamed:@"wallet_icon.png"];
    wallet_image.scale = .75;
    
    wallet_image.position = CGPointMake(wallet_image.position.x - self.sprite.size.width/2 + wallet_image.size.width/2 + 10, wallet_image.position.y);
    
    [self.sprite addChild:wallet_image];
    
    self.wallet_id = i;
    self.update_at = u;
    self.hex = h;
    self.name = n;
    self.created_at = c;
    self.wallet_id = w;
    self.compromised = comp.boolValue;
    
    if(self.compromised) self.sprite.color = [SKColor redColor]; else self.sprite.color = [SKColor greenColor];
    
    self.sprite.colorBlendFactor = .5;
    
    SKLabelNode* text = [[SKLabelNode alloc] init];
    //child name
    [text setName:@"text"];
    //actual name
    text.text = self.name;
    text.fontColor = [SKColor blackColor];
    text.fontSize = 20;
    text.fontName = @"System-Bold";
    [self.sprite addChild:text];
    SKLabelNode* child = (SKLabelNode*)[self.sprite childNodeWithName:@"text"];
    child.position = CGPointMake(wallet_image.position.x + wallet_image.size.width/2 + child.frame.size.width/2 + 10, child.position.y  - 10);
    
    return self;
}

-(id)initWithDictionary:(NSDictionary *)dictionary {
	if (self = [self init]) {
		self.ID = dictionary[@"id"];
		self.update_at = dictionary[@"update_at"];
		self.hex = dictionary[@"hex"];
		self.name = dictionary[@"name"];
		self.created_at = dictionary[@"created_at"];
		self.wallet_id = dictionary[@"wallet_id"];
		self.compromised = [dictionary[@"compromised"] boolValue];
	}
	return self;
}

-(NSDate *) getDate {
	NSDateFormatter * formater = [[NSDateFormatter alloc] init];
	[formater setDateFormat:@"yyyy-MM-ddTHH:mm:ssZ"];
	return [formater dateFromString:self.update_at];
}

-(NSNumber *)getID {
	return (NSNumber *)self.ID;
}

+(NSArray *) getJSON {
	NSString * addressString = @"https://bee-trap.herokuapp.com/users/2/wallet.json";
	NSURL * url = [[NSURL alloc] initWithString:addressString];
	NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
	request.URL = url;
	request.HTTPMethod = @"GET";
	
	NSError * error = nil;
	NSURLResponse * response = nil;
	NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	
	if (!error) {
		NSError * jsonError = nil;
		NSDictionary * dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
		
		if (!jsonError) {
			
			return dictionary[@"wallet"];
		}
	}
	return nil;
}

+(NSDictionary *) getWallets {
	NSMutableDictionary * dictionary = [[NSMutableDictionary alloc] init];
	NSArray * wallets = [Wallet getJSON];
	for (NSDictionary * w in wallets) {
		dictionary[w[@"id"]] = [[Wallet alloc] initWithDictionary:w];
	}
	
	return dictionary;
}

+(NSArray *) getWalletsArray {
	NSMutableArray * wArray = [[NSMutableArray alloc] init];
	NSArray * wallets = [Wallet getJSON];
	for (NSDictionary * w in wallets) {
		[wArray addObject:[[Wallet alloc] initWithDictionary:w]];
	}
	return wArray;
}

@end