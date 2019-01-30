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
@synthesize gameTitle, button;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIColor *backgroundColor = [[UIColor alloc]initWithRed:121.0/255.0 green: 138.0/255.0 blue: 132.0/255.0 alpha: 1.0];
    UIColor *textColor = [[UIColor alloc]initWithRed:57.0/255.0 green: 57.0/255.0 blue: 57.0/255.0 alpha: 1.0];

    
    self.view.backgroundColor = backgroundColor;
    [gameTitle setTextColor:textColor];
    [gameTitle setFont: [UIFont boldSystemFontOfSize:32]];
    
        
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
