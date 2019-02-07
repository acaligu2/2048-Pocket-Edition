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
@synthesize gameTitle, swipeTest, scoreLabel, scoreIndicator, tileBackground, scoreBackground, upperMiddleTiles, topTiles, lowerMiddleTiles, bottomTiles, reset;

int gameScore = 0;

NSMutableArray* tileMatrix;
NSMutableArray* infoMatrix;
NSMutableArray* occupied;
NSNumber *freeSpot;
NSNumber *occupiedSpot;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    tileMatrix = [[NSMutableArray alloc]initWithCapacity:4];
    occupied = [[NSMutableArray alloc]initWithCapacity:16];
    
    freeSpot = [NSNumber numberWithInteger:0];
    occupiedSpot = [NSNumber numberWithInteger:1];

    for(int i = 0; i < 16; i++){
        
        occupied[i] = freeSpot;
        
    }
    
    [tileMatrix addObject:topTiles];
    [tileMatrix addObject:upperMiddleTiles];
    [tileMatrix addObject:lowerMiddleTiles];
    [tileMatrix addObject:bottomTiles];
    
    infoMatrix = [[NSMutableArray alloc] initWithCapacity:4];
    
    int i;
    int j;
    for(i = 0; i < 4; i++){
        
        NSMutableArray *row = [[NSMutableArray alloc] initWithCapacity:4];
        
        for(j = 0; j < 4; j++){
            
            TileInformation *newTile = [[TileInformation alloc] init];
            [row addObject:newTile];
            
        }
        
        [infoMatrix addObject:row];
        
    }
    
    [self establishNeighbors:infoMatrix];
    
    
    [scoreLabel setText:[NSString stringWithFormat:@"%d", gameScore]];
    
    //Establish Colors for game
    
    UIColor *backgroundColor = [[UIColor alloc]initWithRed: 176.0/255.0 green: 210.0/255.0 blue: 202.0/255.0 alpha: 1.0];
    UIColor *textColor = [[UIColor alloc]initWithRed:119.0/255.0 green: 138.0/255.0 blue: 152.0/255.0 alpha: 1.0];
    UIColor *tileColor = [[UIColor alloc]initWithRed:221.0/255.0 green: 221.0/255.0 blue: 221.0/255.0 alpha: 1.0];
    UIColor *accentColor = [[UIColor alloc]initWithRed:201.0/255.0 green: 238.0/255.0 blue: 229.0/255.0 alpha: 1.0];

    
    [tileBackground setBackgroundColor:backgroundColor];
    
    [reset setBackgroundColor:backgroundColor];
    
    self.view.backgroundColor = accentColor;
    [gameTitle setTextColor: textColor];
    [scoreLabel setTextColor: textColor];
    [scoreIndicator setTextColor: textColor];
    
    [scoreBackground setBackgroundColor:backgroundColor];
    
    //Choose first two tiles that will contain vaules

    [self spawnNewTile];
    [self spawnNewTile];
    
    //Loop through array of labels and set all to color
    for(NSMutableArray *row in tileMatrix){
        
        for(UILabel *tile in row){
            
            [tile setBackgroundColor:tileColor];
            
        }
        
    }
    
    
}
- (IBAction)resetGame:(id)sender {
    
    for(int i = 0; i < 4; i++){
        
        for(int j = 0; j < 4; j++){
            
            
            [infoMatrix[i][j] setTileScore:0];
            [tileMatrix[i][j] setText:@""];
            occupied[4 * i + j] = freeSpot;
            
        }
        
        
    }
    
    [scoreLabel setText:[NSString stringWithFormat:@"%d", 0]];
    
    [self spawnNewTile];
    [self spawnNewTile];
    
}

//[self setScore:10];

//Creates neighbor relations for all tiles
-(void)establishNeighbors:(NSMutableArray*)infoMat{
    
    for(int i = 0; i < 4; i++){
        
        for(int j = 0; j < 4; j++){
            
            //Top
            if(i - 1 >= 0){
                
                [infoMat[i][j] setNeighbor:infoMat[i-1][j] inDirection:@"above"];
                
            }
            
            //Bottom
            if(i + 1 < 4){
                
                [infoMat[i][j] setNeighbor:infoMat[i+1][j] inDirection:@"below"];
                
            }
            
            //Left
            if(j - 1 >= 0){
                
                [infoMat[i][j] setNeighbor:infoMat[i][j-1] inDirection:@"left"];
                
            }
            
            //Right
            if(j + 1 < 4){
                
                [infoMat[i][j] setNeighbor:infoMat[i][j+1] inDirection:@"right"];
                
            }
            
        }
        
    }
    
}

//Adds to the score when two tiles are combined
- (void)setScore:(int)scoreAddition{
    
    gameScore += scoreAddition;
    
    [scoreLabel setText:[NSString stringWithFormat:@"%d", gameScore]];
    
}

-(void)spawnNewTile{
    
    //Random coords for first tile
    NSInteger tileOneX = arc4random() % 4;
    NSInteger tileOneY = arc4random() % 4;
    
    while(occupied[4 * tileOneX + tileOneY] == occupiedSpot){
        
        tileOneX = arc4random() % 4;
        tileOneY = arc4random() % 4;
        
    }
    
    occupied[4 * tileOneX + tileOneY] = occupiedSpot;
    
    //Set value of first two tiles
    [tileMatrix[tileOneX][tileOneY] setText:[NSString stringWithFormat:@"%d", 2]];
    
    //Also reflect value in TileInformation class
    [infoMatrix[tileOneX][tileOneY] setTileScore:2];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)moveTile:(TileInformation *)target x:(int)x y:(int)y direction:(NSString*)dir{
    
    if([dir isEqualToString:@"up"]){
        
        if([target getAbove] != nil){
            
            int val = [target getScore];
            [target setTileScore:0];
            [tileMatrix[x][y] setText:@""];
            [[target getAbove] setTileScore:val];
            [tileMatrix[x-1][y] setText:[NSString stringWithFormat:@"%d", val]];
            
            occupied[4 * x + y] = freeSpot;
            occupied[4 * (x-1) + y] = occupiedSpot;
            
            [self moveTile:[target getAbove] x:x-1 y:y direction:@"up"];
            
        }else{
            
            return;
            
        }
        
    }
    if([dir isEqualToString:@"down"]){
        
        if([target getBelow] != nil){
            
            int val = [target getScore];
            [target setTileScore:0];
            [tileMatrix[x][y] setText:@""];
            [[target getBelow] setTileScore:val];
            [tileMatrix[x+1][y] setText:[NSString stringWithFormat:@"%d", val]];
            
            occupied[4 * x + y] = freeSpot;
            occupied[4 * (x+1) + y] = occupiedSpot;
            
            [self moveTile:[target getBelow] x:x+1 y:y direction:@"down"];
            
        }else{
            
            return;
            
        }
        
    }
    if([dir isEqualToString:@"left"]){
        
        if([target getLeft] != nil){
            
            int val = [target getScore];
            [target setTileScore:0];
            [tileMatrix[x][y] setText:@""];
            [[target getLeft] setTileScore:val];
            [tileMatrix[x][y-1] setText:[NSString stringWithFormat:@"%d", val]];
            
            occupied[4 * x + y] = freeSpot;
            occupied[4 * x + (y-1)] = occupiedSpot;
            
            [self moveTile:[target getLeft] x:x y:y-1 direction:@"left"];
            
        }else{
            
            return;
            
        }
        
    }
    if([dir isEqualToString:@"right"]){
        
        if([target getRight] != nil){
            
            int val = [target getScore];
            [target setTileScore:0];
            [tileMatrix[x][y] setText:@""];
            [[target getRight] setTileScore:val];
            [tileMatrix[x][y+1] setText:[NSString stringWithFormat:@"%d", val]];
            
            occupied[4 * x + y] = freeSpot;
            occupied[4 * x + (y+1)] = occupiedSpot;
            
            [self moveTile:[target getRight] x:x y:y+1 direction:@"right"];
            
        }else{
            
            return;
            
        }
        
    }
    
}

//Sends command to manipulate tiles
- (IBAction)swipeTest:(id)sender {
    
    UISwipeGestureRecognizer *senderDir = (UISwipeGestureRecognizer *)sender;
    
    UISwipeGestureRecognizerDirection dir = senderDir.direction;
    
    switch(dir){
            
        case(UISwipeGestureRecognizerDirectionUp):
            
            [swipeTest setText: @"Swiped Up"];
            
            for(int i = 0; i < 4; i++){
                
                for(int j = 0; j < 4; j++){
                    
                    if([infoMatrix[i][j] getScore] > 0){
                        
                        [self moveTile:infoMatrix[i][j] x:i y:j direction:@"up"];
                        
                    }
                    
                }
                
            }
            
            [self spawnNewTile];
            
            break;
            
        case(UISwipeGestureRecognizerDirectionDown):
            
            [swipeTest setText: @"Swiped Down"];
            
            for(int i = 0; i < 4; i++){
                
                for(int j = 0; j < 4; j++){
                    
                    if([infoMatrix[i][j] getScore] > 0){
                        
                        [self moveTile:infoMatrix[i][j] x:i y:j direction:@"down"];
                    }
                    
                }
                
            }
            
            [self spawnNewTile];
            
            break;
            
        case(UISwipeGestureRecognizerDirectionRight):
            
            [swipeTest setText: @"Swiped Right"];
            
            for(int i = 0; i < 4; i++){
                
                for(int j = 0; j < 4; j++){
                    
                    if([infoMatrix[i][j] getScore] > 0){
                        
                        [self moveTile:infoMatrix[i][j] x:i y:j direction:@"right"];
                        
                    }
                    
                }
                
            }
            
            [self spawnNewTile];
            
            break;
            
        case(UISwipeGestureRecognizerDirectionLeft):
            
            [swipeTest setText: @"Swiped Left"];
            
            for(int i = 0; i < 4; i++){
                
                for(int j = 0; j < 4; j++){
                    
                    if([infoMatrix[i][j] getScore] > 0){
                        
                        [self moveTile:infoMatrix[i][j] x:i y:j direction:@"left"];
                    }
                    
                }
                
            }
            
            [self spawnNewTile];
            
            break;
            
        default:
            
            break;
            
            
    }
    
    
    
}

@end
