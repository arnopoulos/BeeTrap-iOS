//
//  WalletListViewController.m
//  Honeypot
//
//  Created by Andrew Arnopoulos on 11/14/14.
//  Copyright (c) 2014 Andrew Arnopoulos. All rights reserved.
//

#import "WalletListViewController.h"
#import <SpriteKit/SpriteKit.h>

@interface WalletListViewController ()

@property (weak,nonatomic) SKView * skView;


@end

@implementation WalletListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	SKView * temp = [[SKView alloc] initWithFrame:self.view.bounds];
	self.skView = temp;
	[self.view addSubview:self.skView];
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
