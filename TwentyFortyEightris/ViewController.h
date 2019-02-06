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

@property (retain, nonatomic) IBOutletCollection(UILabel) NSMutableArray *topTiles;
@property (retain, nonatomic) IBOutletCollection(UILabel) NSMutableArray *upperMiddleTiles;
@property (retain, nonatomic) IBOutletCollection(UILabel) NSMutableArray *lowerMiddleTiles;
@property (retain, nonatomic) IBOutletCollection(UILabel) NSMutableArray *bottomTiles;

@property (nonatomic, strong) IBOutlet UIButton *reset;
@property (nonatomic, strong) IBOutlet UILabel *gameTitle;
@property (nonatomic, strong) IBOutlet UILabel *swipeTest;
@property (nonatomic, strong) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) IBOutlet UILabel *scoreIndicator;
@property (nonatomic, strong) IBOutlet UIView *tileBackground;
@property (nonatomic, strong) IBOutlet UIView *scoreBackground;

-(void)setScore:(int)scoreAddition;
-(void)moveTile:(TileInformation*)target x:(int)x y:(int)y direction:(NSString*)dir;
-(void)spawnNewTile;
-(void)establishNeighbors:(NSMutableArray*)infoMat;

@end

