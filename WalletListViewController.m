//
//  WalletListViewController.m
//  Honeypot
//
//  Created by Andrew Arnopoulos on 11/14/14.
//  Copyright (c) 2014 Andrew Arnopoulos. All rights reserved.
//

#import "WalletListViewController.h"
#import "Wallet.h"
#import <SpriteKit/SpriteKit.h>

@interface WalletListViewController ()

@property (weak,nonatomic) SKView * skView;


@end

@implementation WalletListViewController

#define MenuHeight 40
#define ButtonHeight 48

NSMutableArray * walletArray;
SKScene* scene;
bool inWalletPreview = false;
bool scrolling = false;

//Wallet Preview nodes
SKLabelNode* previewer_name;
SKLabelNode* previewer_hex;

-(NSArray *) getJSON {
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	SKView * temp = [[SKView alloc] initWithFrame:self.view.bounds];
	self.skView = temp;
    
    scene = [[SKScene alloc]initWithSize:temp.bounds.size];
    scene.backgroundColor = [SKColor whiteColor];
    
    #pragma mark - Init Wallet Previewer
    previewer_name = [[SKLabelNode alloc]init];
    previewer_name.fontColor = [SKColor blackColor];
    previewer_name.alpha = 0;
    previewer_name.position = CGPointMake(previewer_name.position.x + previewer_name.frame.size.width/2 + scene.frame.size.width/2, previewer_name.position.y - previewer_name.frame.size.height/2 + scene.size.height - 100);
    
    [scene addChild:previewer_name];
    
    previewer_hex = [[SKLabelNode alloc]init];
    previewer_hex.fontColor = [SKColor blackColor];
    previewer_hex.alpha = 0;
    previewer_hex.position = CGPointMake(previewer_hex.position.x + previewer_hex.frame.size.width/2 + scene.frame.size.width/2, previewer_hex.position.y - previewer_hex.frame.size.height/2 + scene.size.height - 140);
    
    [scene addChild:previewer_hex];
    
    
    #pragma mark - Setup wallets
    
    walletArray = [[NSMutableArray alloc]init];
    
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(method)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cog.png"] style:UIBarButtonItemStyleDone target:self action:@selector(editButtonPressed)];
    
    //get wallets
    
    NSArray* wallets = [self getJSON];
    
    if(wallets)
    {
        for(int i = 0; i < wallets.count; i++)
        {
            Wallet* temp = [[Wallet alloc] createWalletWithID:wallets[i][@"id"]
                                                  andUpdateAt:wallets[i][@"update_at"]
                                                       andHex:wallets[i][@"hex"]
                                                      andName:wallets[i][@"name"]
                                                  andCreateAt:wallets[i][@"created_at"]
                                                  andWalletID:wallets[i][@"wallet_id"]
                                               andCompromised:wallets[i][@"compromised"]];
            
            temp.sprite.xScale = scene.size.width/temp.sprite.frame.size.width;
            temp.sprite.yScale = ButtonHeight/temp.sprite.frame.size.height;
            temp.sprite.position = CGPointMake(temp.sprite.frame.size.width/2,
                                               temp.sprite.frame.size.height/2);
            
            [self addWalletToList:temp];
            
        }
    }
//    for(int i = 0; i < 10; i++)
//    {
//        Wallet* temp = [[Wallet alloc]init];
//        
//        temp.sprite = [SKSpriteNode spriteNodeWithImageNamed:@"button_background.png"];
//        temp.sprite.xScale = scene.size.width/temp.sprite.frame.size.width;
//        temp.sprite.yScale = ButtonHeight/temp.sprite.frame.size.height;
//        temp.sprite.position = CGPointMake(temp.sprite.frame.size.width/2,
//                                           temp.sprite.frame.size.height/2);
//        temp.name = [NSString stringWithFormat:@"My Wallet %i",i + 1];
//        SKLabelNode* text = [[SKLabelNode alloc] init];
//        //child name
//        [text setName:@"text"];
//        //actual name
//        text.text = temp.name;
//        text.fontName = @"System-Bold";
//        [temp.sprite addChild:text];
//        SKLabelNode* child = (SKLabelNode*)[temp.sprite childNodeWithName:@"text"];
//        child.position = CGPointMake(child.position.x - 64, child.position.y  - 10);
//        
//        [self addWalletToList:temp];
//        
//    }
    
    [temp presentScene:scene];
	
    [self.view addSubview:self.skView];
}

-(void)editButtonPressed
{
    
}

-(void)method
{
    if(!inWalletPreview) [self dismissViewControllerAnimated:TRUE completion:nil]; else [self goBackToList];
}

-(void)goBackToList
{
    inWalletPreview = false;
    
    //move all buttons right
    for(Wallet* wallet in walletArray)
    {
        wallet.sprite.alpha = 1;
    }
    
    previewer_name.alpha = 0;
    previewer_hex.alpha =0;
}

-(void)showWallet:(Wallet*)wallet
{
    inWalletPreview = true;
    
    //move all buttons left
    for(Wallet* wallet in walletArray)
    {
        wallet.sprite.alpha = 0;
    }
    
    previewer_name.alpha = 1;
    previewer_name.text = wallet.name;
    
    previewer_hex.alpha = 1;
    previewer_hex.text = wallet.hex;
    previewer_hex.scale = (scene.size.width - 40)/previewer_hex.frame.size.width;
}

#pragma mark - Wallet Helper Functions
-(void)addWalletToList:(Wallet*) wallet
{
    [walletArray addObject:wallet];
    SKSpriteNode* sprite = ((Wallet *)walletArray[walletArray.count - 1]).sprite;
    sprite.position = CGPointMake(sprite.position.x,scene.frame.size.height - ButtonHeight*walletArray.count - MenuHeight);
    [scene addChild: sprite];
    
}

-(void)removeWalletFromList:(int)index
{
    [walletArray removeObjectAtIndex:index];
}


#pragma mark - Touch Handling
double touchStarty;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    scrolling = false;
    
    touchStarty = location.y;
    for(Wallet* wallet in walletArray)
    {
        wallet.starty = wallet.sprite.position.y;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    scrolling = true;
    
    double deltay = location.y - touchStarty;
    
    for(Wallet* wallet in walletArray)
    {
        SKSpriteNode* sprite = wallet.sprite;
        sprite.position = CGPointMake(sprite.position.x, wallet.starty - deltay);
        if((((Wallet*)[walletArray objectAtIndex:0]).sprite.position.y
            +
            ((Wallet*)[walletArray objectAtIndex:0]).sprite.size.height/2) > scene.frame.size.height - MenuHeight && deltay < 0)
        {
            //sprite.position = CGPointMake(sprite.position.x, wallet.starty - deltay);
        }
        
        if((((Wallet*)[walletArray objectAtIndex:walletArray.count -1]).sprite.position.y
            -
            ((Wallet*)[walletArray objectAtIndex:walletArray.count -1]).sprite.size.height/2) < 0 && deltay > 0)
        {
            //sprite.position = CGPointMake(sprite.position.x, wallet.starty - deltay);
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    location.y = self.view.bounds.size.height - location.y;
    
    if(scrolling)return;
    
    for(Wallet* wallet in walletArray)
    {
        SKSpriteNode* sprite = wallet.sprite;
        if(sprite.position.y + sprite.frame.size.height/2 > location.y
           &&
           sprite.position.y - sprite.frame.size.height/2 < location.y)
        {
            [self showWallet:wallet];
        }
    }
    
    scrolling = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
