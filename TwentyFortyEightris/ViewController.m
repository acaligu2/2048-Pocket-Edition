//
//  ViewController.m
//  TwentyFortyEightris
//
//  Created by Anthony Caligure on 1/30/19.
//  Copyright © 2019 Anthony Caligure. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize gameTitle, gameTiles, swipeTest;

NSMutableArray *gameTiles;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *backgroundColor = [[UIColor alloc]initWithRed: 176.0/255.0 green: 210.0/255.0 blue: 202.0/255.0 alpha: 1.0];
    UIColor *textColor = [[UIColor alloc]initWithRed:119.0/255.0 green: 138.0/255.0 blue: 152.0/255.0 alpha: 1.0];
    UIColor *tileColor = [[UIColor alloc]initWithRed:221.0/255.0 green: 221.0/255.0 blue: 221.0/255.0 alpha: 1.0];

    
    self.view.backgroundColor = backgroundColor;
    [gameTitle setTextColor: textColor];
    
    for (UILabel *tile in gameTiles) {
        [tile setBackgroundColor:tileColor];
    }
        
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
