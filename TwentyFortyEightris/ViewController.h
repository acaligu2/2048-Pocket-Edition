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

@property(nonatomic,strong) IBOutlet UILabel *pocket;
@property (nonatomic, strong) IBOutlet UIView *pocketBackground;

@property (nonatomic, strong) IBOutlet UIButton *reset;
@property (nonatomic, strong) IBOutlet UILabel *gameTitle;
@property (nonatomic, strong) IBOutlet UILabel *swipeTest;
@property (nonatomic, strong) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) IBOutlet UILabel *scoreIndicator;
@property (nonatomic, strong) IBOutlet UIView *tileBackground;
@property (nonatomic, strong) IBOutlet UIView *scoreBackground;
@property (nonatomic, strong) IBOutlet UILabel *gameOver;

@property (nonatomic, strong) IBOutlet UILabel *t0;
@property (nonatomic, strong) IBOutlet UILabel *t1;
@property (nonatomic, strong) IBOutlet UILabel *t2;
@property (nonatomic, strong) IBOutlet UILabel *t3;
@property (nonatomic, strong) IBOutlet UILabel *t4;
@property (nonatomic, strong) IBOutlet UILabel *t5;
@property (nonatomic, strong) IBOutlet UILabel *t6;
@property (nonatomic, strong) IBOutlet UILabel *t7;
@property (nonatomic, strong) IBOutlet UILabel *t8;
@property (nonatomic, strong) IBOutlet UILabel *t9;
@property (nonatomic, strong) IBOutlet UILabel *t10;
@property (nonatomic, strong) IBOutlet UILabel *t11;
@property (nonatomic, strong) IBOutlet UILabel *t12;
@property (nonatomic, strong) IBOutlet UILabel *t13;
@property (nonatomic, strong) IBOutlet UILabel *t14;
@property (nonatomic, strong) IBOutlet UILabel *t15;

-(void)updateColors;
-(void)setScore:(int)scoreAddition;
-(void)moveTile:(TileInformation*)target x:(int)x y:(int)y direction:(NSString*)dir;
-(void)spawnNewTile;
-(void)establishNeighbors:(NSMutableArray*)infoMat;

@end

