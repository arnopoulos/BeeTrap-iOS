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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	SKView * temp = [[SKView alloc] initWithFrame:self.view.bounds];
	self.skView = temp;
    
    scene = [[SKScene alloc]initWithSize:temp.bounds.size];
    
    #pragma mark - Setup wallets
    
    walletArray = [[NSMutableArray alloc]init];
    
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(method)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cog.png"] style:UIBarButtonItemStyleDone target:self action:@selector(editButtonPressed)];
    
    //get
    for(int i = 0; i < 10; i++)
    {
        Wallet* temp = [[Wallet alloc]init];
        
        temp.sprite = [SKSpriteNode spriteNodeWithImageNamed:@"button_background.png"];
        temp.sprite.xScale = scene.size.width/temp.sprite.frame.size.width;
        temp.sprite.yScale = ButtonHeight/temp.sprite.frame.size.height;
        temp.sprite.position = CGPointMake(temp.sprite.frame.size.width/2,
                                           temp.sprite.frame.size.height/2);
        temp.name = [NSString stringWithFormat:@"My Wallet %i",i + 1];
        SKLabelNode* text = [[SKLabelNode alloc] init];
        //child name
        [text setName:@"text"];
        //actual name
        text.text = temp.name;
        text.fontName = @"System-Bold";
        [temp.sprite addChild:text];
        SKLabelNode* child = (SKLabelNode*)[temp.sprite childNodeWithName:@"text"];
        child.position = CGPointMake(child.position.x - 64, child.position.y  - 10);
        
        [self addWalletToList:temp];
        
    }
    
    [temp presentScene:scene];
	
    [self.view addSubview:self.skView];
}

-(void)editButtonPressed
{
    
}

-(void)method
{
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

#pragma mark - Wallet Helper Functions
-(void)addWalletToList:(Wallet*) wallet
{
    [walletArray addObject:wallet];
    SKSpriteNode* sprite = ((Wallet *)walletArray[walletArray.count - 1]).sprite;
    sprite.position = CGPointMake(sprite.position.x,scene.frame.size.height - ButtonHeight*walletArray.count - MenuHeight);
    [scene addChild: sprite];
    
}


#pragma mark - Touch Handling
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    location.y = self.view.bounds.size.height - location.y;
    
    for(Wallet* wallet in walletArray)
    {
        SKSpriteNode* sprite = wallet.sprite;
        if(sprite.position.y + sprite.frame.size.height/2 > location.y
           &&
           sprite.position.y - sprite.frame.size.height/2 < location.y)
        {
            [wallet touched];
        }
    }
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
