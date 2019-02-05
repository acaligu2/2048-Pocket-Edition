//
//  ViewController.h
//  TwentyFortyEightris
//
//  Created by Anthony Caligure on 1/30/19.
//  Copyright © 2019 Anthony Caligure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TileInformation.h"

@interface ViewController : UIViewController

@property (retain, nonatomic) IBOutletCollection(UILabel) NSArray *gameTiles;

@property (nonatomic, strong) IBOutlet UILabel *gameTitle;
@property (nonatomic, strong) IBOutlet UILabel *swipeTest;
@property (nonatomic, strong) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) IBOutlet UILabel *scoreIndicator;
@property (nonatomic, strong) IBOutlet UIView *tileBackground;
@property (nonatomic, strong) IBOutlet UIView *scoreBackground;

-(void)setScore:(int)scoreAddition;


@end

