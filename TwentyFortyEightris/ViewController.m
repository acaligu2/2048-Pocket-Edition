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
    
    [self spawnNewTile];
    [self spawnNewTile];
    
}

//[self setScore:10];

//Creates neighbor relations for all tiles
-(void)establishNeighbors:(NSMutableArray*)infoMat{
    
    for(int i = 0; i < 4; i++){
        
        for(int j = 0; j < 4; j++){
            
            //Top
            if(j - 1 >= 0){
                
                [infoMat[i][j] setNeighbor:infoMat[i][j-1] inDirection:@"above"];
                
            }
            
            //Bottom
            if(j + 1 < 4){
                
                [infoMat[i][j] setNeighbor:infoMat[i][j+1] inDirection:@"below"];
                
            }
            
            //Left
            if(i - 1 >= 0){
                
                [infoMat[i][j] setNeighbor:infoMat[i-1][j] inDirection:@"left"];
                
            }
            
            //Right
            if(i + 1 < 4){
                
                [infoMat[i][j] setNeighbor:infoMat[i+1][j] inDirection:@"right"];
                
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
