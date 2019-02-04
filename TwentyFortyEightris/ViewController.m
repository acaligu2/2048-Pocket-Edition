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
    
    //Establish Colors for game
    
    UIColor *backgroundColor = [[UIColor alloc]initWithRed: 176.0/255.0 green: 210.0/255.0 blue: 202.0/255.0 alpha: 1.0];
    UIColor *textColor = [[UIColor alloc]initWithRed:119.0/255.0 green: 138.0/255.0 blue: 152.0/255.0 alpha: 1.0];
    UIColor *tileColor = [[UIColor alloc]initWithRed:221.0/255.0 green: 221.0/255.0 blue: 221.0/255.0 alpha: 1.0];

    
    self.view.backgroundColor = backgroundColor;
    [gameTitle setTextColor: textColor];
    
    //Choose first two tiles that will contain vaules
    
    NSInteger firstTile = arc4random() % 16;
    NSInteger secondTile = arc4random() % 16;
    
    //Ensure the same tile isn't picked
    if(secondTile == firstTile){
        
        secondTile = arc4random() % 16;
        
    }
    
    //Loop through array of labels and set all to color
    for (UILabel *tile in gameTiles) {
        [tile setBackgroundColor:tileColor];
    }
    
    [gameTiles[firstTile] setText: @"2"];
    [gameTiles[secondTile] setText: @"2"];
        
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)swipeTest:(id)sender {
    
    UISwipeGestureRecognizer *senderDir = (UISwipeGestureRecognizer *)sender;
    
    UISwipeGestureRecognizerDirection dir = senderDir.direction;
    
    switch(dir){
    
        case(UISwipeGestureRecognizerDirectionUp):
            
            [swipeTest setText: @"Swiped Up"];
            break;
            
        case(UISwipeGestureRecognizerDirectionDown):
            
            [swipeTest setText: @"Swiped Down"];
            break;
            
        case(UISwipeGestureRecognizerDirectionRight):
            
            [swipeTest setText: @"Swiped Right"];
            break;
            
        case(UISwipeGestureRecognizerDirectionLeft):
            
            [swipeTest setText: @"Swiped Left"];
            break;
            
        default:
            
            break;
            
            
    }
    
}

@end
