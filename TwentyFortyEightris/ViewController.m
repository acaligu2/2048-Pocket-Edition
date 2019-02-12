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
@synthesize gameTitle, gameOver, swipeTest, scoreLabel, scoreIndicator, tileBackground, scoreBackground, reset, pocket, pocketBackground, t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15;

int gameScore = 0;
int pocketVal = 0;

NSMutableArray* tileMatrix;
NSMutableArray* topTiles;
NSMutableArray* upperMiddleTiles;
NSMutableArray* lowerMiddleTiles;
NSMutableArray* bottomTiles;
NSMutableArray* infoMatrix;
NSMutableArray* occupied;
NSNumber *freeSpot;
NSNumber *occupiedSpot;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    tileMatrix = [[NSMutableArray alloc]initWithCapacity:4];
    
    topTiles = [[NSMutableArray alloc]initWithCapacity:4];
    upperMiddleTiles = [[NSMutableArray alloc]initWithCapacity:4];
    lowerMiddleTiles = [[NSMutableArray alloc]initWithCapacity:4];
    bottomTiles = [[NSMutableArray alloc]initWithCapacity:4];
    
    [topTiles addObject:t0];
    [topTiles addObject:t1];
    [topTiles addObject:t2];
    [topTiles addObject:t3];
    
    [upperMiddleTiles addObject:t4];
    [upperMiddleTiles addObject:t5];
    [upperMiddleTiles addObject:t6];
    [upperMiddleTiles addObject:t7];
    
    [lowerMiddleTiles addObject:t8];
    [lowerMiddleTiles addObject:t9];
    [lowerMiddleTiles addObject:t10];
    [lowerMiddleTiles addObject:t11];
    
    [bottomTiles addObject:t12];
    [bottomTiles addObject:t13];
    [bottomTiles addObject:t14];
    [bottomTiles addObject:t15];
    
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
    
    for(int i = 0; i < 4; i++){
        
        for(int j = 0; j < 4; j++){
            
            int val = (4 * i + j);
            [tileMatrix[i][j] setTag:val];
            
        }
        
    }
    
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
    
    [pocket setBackgroundColor: tileColor];
    [pocketBackground setBackgroundColor:backgroundColor];
    
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
    
    [self updateColors];
    
    
}
- (IBAction)resetGame:(id)sender {
 
    [gameTitle setText:@"Twenty-Forty-Eight"];
    
    for(int i = 0; i < 4; i++){
        
        for(int j = 0; j < 4; j++){
            
            
            [infoMatrix[i][j] setTileScore:0];
            [tileMatrix[i][j] setText:@""];
            occupied[4 * i + j] = freeSpot;
            
        }
        
        
    }
    
    [scoreLabel setText:[NSString stringWithFormat:@"%d", 0]];
    gameScore = 0;
    pocketVal = 0;
    [pocket setText:@""];
    
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
    
    Boolean full = true;
    
    for(int i = 0; i < 16; i++){
        
        if(occupied[i] != occupiedSpot){
         
            full = false;
            
        }
            
    }
    
    //Game Over
    if(full){
        
        [self resetGame:NULL];
        
    }
    
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
    
    [self updateColors];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)moveTile:(TileInformation *)target x:(int)x y:(int)y direction:(NSString*)dir{
    
    TileInformation *nextStep;
    int newX = -1;
    int newY = -1;
    NSString *nextDir = @"";

    if([dir isEqualToString:@"up"]){ nextStep = [target getAbove]; newX = x - 1; newY = y; nextDir = @"up"; }
    if([dir isEqualToString:@"down"]){ nextStep = [target getBelow]; newX = x + 1; newY = y; nextDir = @"down";}
    if([dir isEqualToString:@"left"]){ nextStep = [target getLeft]; newX = x; newY = y - 1; nextDir = @"left";}
    if([dir isEqualToString:@"right"]){ nextStep = [target getRight]; newX = x; newY = y + 1; nextDir = @"right";}
    
    if(nextStep != nil){
        
        int val;
        
        if([nextStep getScore] != [target getScore]){
            
            if([nextStep getScore] == 0){
                
                val = [target getScore];
                [target setTileScore:0];
                [tileMatrix[x][y] setText:@""];
                [nextStep setTileScore:val];
                [tileMatrix[newX][newY] setText:[NSString stringWithFormat:@"%d", val]];
                
                occupied[4 * x + y] = freeSpot;
                occupied[4 * newX + newY] = occupiedSpot;
                
            }
            
        }
            
            
        if([nextStep getScore] == [target getScore]){
            
            val = [target getScore] * 2;
            
            [target setTileScore:0];
            
            [tileMatrix[x][y] setText:@""];
            
            [nextStep setTileScore:val];
            
            [tileMatrix[newX][newY] setText:[NSString stringWithFormat:@"%d", val]];
            
            occupied[4 * x + y] = freeSpot;
            occupied[4 * newX + newY] = occupiedSpot;
            
            [self setScore:val];
                
        }
        
        [self moveTile:nextStep x:newX y:newY direction:nextDir];
        
    }else{
        
        return;
        
    }
    
}

-(void)updateColors{
    
    for(int i = 0; i < 4; i++){
        
        for(int j = 0; j < 4; j++){
            
            int val = [infoMatrix[i][j] getScore];
            UIColor *newTileColor;
            
            switch(val){
                    
                case 0:
                    newTileColor = [[UIColor alloc]initWithRed:221.0/255.0 green: 221.0/255.0 blue: 221.0/255.0 alpha: 1.0];
                    break;
                case 2:
                    newTileColor = [[UIColor alloc]initWithRed: 229.0/255.0 green: 210.0/255.0 blue: 227.0/255.0 alpha: 1.0];
                    break;
                case 4:
                    newTileColor = [[UIColor alloc]initWithRed: 226.0/255.0 green: 201.0/255.0 blue: 224.0/255.0 alpha: 1.0];
                    break;
                case 8:
                    newTileColor = [[UIColor alloc]initWithRed: 236.0/255.0 green: 190.0/255.0 blue: 222.0/255.0 alpha: 1.0];
                    break;
                case 16:
                    newTileColor = [[UIColor alloc]initWithRed: 216.0/255.0 green: 171.0/255.0 blue: 203.0/255.0 alpha: 1.0];
                    break;
                case 32:
                    newTileColor = [[UIColor alloc]initWithRed: 171.0/255.0 green: 136.0/255.0 blue: 180.0/255.0 alpha: 1.0];
                    break;
                case 64:
                    newTileColor = [[UIColor alloc]initWithRed: 147.0/255.0 green: 115.0/255.0 blue: 155.0/255.0 alpha: 1.0];
                    break;
                case 128:
                    newTileColor = [[UIColor alloc]initWithRed: 108.0/255.0 green: 82.0/255.0 blue: 159.0/255.0 alpha: 1.0];
                    break;
                case 256:
                    newTileColor = [[UIColor alloc]initWithRed: 79.0/255.0 green: 57.0/255.0 blue: 124.0/255.0 alpha: 1.0];
                    break;
                case 512:
                    newTileColor = [[UIColor alloc]initWithRed: 39.0/255.0 green: 41.0/255.0 blue: 133.0/255.0 alpha: 1.0];
                    break;
                case 1024:
                    newTileColor = [[UIColor alloc]initWithRed: 23.0/255.0 green: 25.0/255.0 blue: 91.0/255.0 alpha: 1.0];
                    break;
                case 2048:
                    newTileColor = [[UIColor alloc]initWithRed: 14.0/255.0 green: 15.0/255.0 blue: 76.0/255.0 alpha: 1.0];
                    break;
                default:
                    newTileColor = [[UIColor alloc]initWithRed: 5.0/255.0 green: 6.0/255.0 blue: 48.0/255.0 alpha: 1.0];
                    break;
                    
                    
            }
            
            [tileMatrix[i][j] setBackgroundColor:newTileColor];
            
        }
        
    }
    
    UIColor *newTileColor;
    
    switch(pocketVal){
            
        case 0:
            newTileColor = [[UIColor alloc]initWithRed:221.0/255.0 green: 221.0/255.0 blue: 221.0/255.0 alpha: 1.0];
            break;
        case 2:
            newTileColor = [[UIColor alloc]initWithRed: 229.0/255.0 green: 210.0/255.0 blue: 227.0/255.0 alpha: 1.0];
            break;
        case 4:
            newTileColor = [[UIColor alloc]initWithRed: 226.0/255.0 green: 201.0/255.0 blue: 224.0/255.0 alpha: 1.0];
            break;
        case 8:
            newTileColor = [[UIColor alloc]initWithRed: 236.0/255.0 green: 190.0/255.0 blue: 222.0/255.0 alpha: 1.0];
            break;
        case 16:
            newTileColor = [[UIColor alloc]initWithRed: 216.0/255.0 green: 171.0/255.0 blue: 203.0/255.0 alpha: 1.0];
            break;
        case 32:
            newTileColor = [[UIColor alloc]initWithRed: 171.0/255.0 green: 136.0/255.0 blue: 180.0/255.0 alpha: 1.0];
            break;
        case 64:
            newTileColor = [[UIColor alloc]initWithRed: 147.0/255.0 green: 115.0/255.0 blue: 155.0/255.0 alpha: 1.0];
            break;
        case 128:
            newTileColor = [[UIColor alloc]initWithRed: 108.0/255.0 green: 82.0/255.0 blue: 159.0/255.0 alpha: 1.0];
            break;
        case 256:
            newTileColor = [[UIColor alloc]initWithRed: 79.0/255.0 green: 57.0/255.0 blue: 124.0/255.0 alpha: 1.0];
            break;
        case 512:
            newTileColor = [[UIColor alloc]initWithRed: 39.0/255.0 green: 41.0/255.0 blue: 133.0/255.0 alpha: 1.0];
            break;
        case 1024:
            newTileColor = [[UIColor alloc]initWithRed: 23.0/255.0 green: 25.0/255.0 blue: 91.0/255.0 alpha: 1.0];
            break;
        case 2048:
            newTileColor = [[UIColor alloc]initWithRed: 14.0/255.0 green: 15.0/255.0 blue: 76.0/255.0 alpha: 1.0];
            break;
        default:
            newTileColor = [[UIColor alloc]initWithRed: 5.0/255.0 green: 6.0/255.0 blue: 48.0/255.0 alpha: 1.0];
            break;
            
            
    }
    
    [pocket setBackgroundColor:newTileColor];
    
}

//Sends command to manipulate tiles
- (IBAction)swipeTest:(id)sender {
    
    UISwipeGestureRecognizer *senderDir = (UISwipeGestureRecognizer *)sender;
    
    UISwipeGestureRecognizerDirection dir = senderDir.direction;
    
    NSString* initialDirection = @"";
    
    switch(dir){
            
        case(UISwipeGestureRecognizerDirectionUp):

            initialDirection = @"up";
            break;
            
        case(UISwipeGestureRecognizerDirectionDown):

            initialDirection = @"down";
            break;
            
        case(UISwipeGestureRecognizerDirectionRight):

            initialDirection = @"right";
            break;
            
        case(UISwipeGestureRecognizerDirectionLeft):

            initialDirection = @"left";
            break;
            
        default:
            
            break;
            
            
    }
    
    for(int i = 0; i < 4; i++){
        
        for(int j = 0; j < 4; j++){
            
            if([infoMatrix[i][j] getScore] > 0){
                
                [self moveTile:infoMatrix[i][j] x:i y:j direction:initialDirection];
                
            }
            
        }
        
    }
    
    [self spawnNewTile];
    
    [self updateColors];
    
}
- (IBAction)moveToPocket:(id)sender {
    
    int xCoord = -1;
    int yCoord = -1;
    
    UIView *test = [sender view];
    
    UILabel *testL = (UILabel *)test;
    
    long labelID = [testL tag];
    
    switch(labelID){
            
        case 0:
            xCoord = 0;
            yCoord = 0;
            break;
        case 1:
            xCoord = 0;
            yCoord = 1;
            break;
        case 2:
            xCoord = 0;
            yCoord = 2;
            break;
        case 3:
            xCoord = 0;
            yCoord = 3;
            break;
        case 4:
            xCoord = 1;
            yCoord = 0;
            break;
        case 5:
            xCoord = 1;
            yCoord = 1;
            break;
        case 6:
            xCoord = 1;
            yCoord = 2;
            break;

        case 7:
            xCoord = 1;
            yCoord = 3;
            break;

        case 8:
            xCoord = 2;
            yCoord = 0;
            break;

        case 9:
            xCoord = 2;
            yCoord = 1;
            break;

        case 10:
            xCoord = 2;
            yCoord = 2;
            break;

        case 11:
            xCoord = 2;
            yCoord = 3;
            break;

        case 12:
            xCoord = 3;
            yCoord = 0;
            break;
            
        case 13:
            xCoord = 3;
            yCoord = 1;
            break;

        case 14:
            xCoord = 3;
            yCoord = 2;
            break;

        case 15:
            xCoord = 3;
            yCoord = 3;
            break;
        default:
            break;
    
    }
    
    if([infoMatrix[xCoord][yCoord] getScore] != 0){
        
        if([[pocket text] isEqualToString: @""]){
            
            pocketVal = [infoMatrix[xCoord][yCoord] getScore];
            
            [pocket setText:[NSString stringWithFormat:@"%d", [infoMatrix[xCoord][yCoord] getScore]]];
            [infoMatrix[xCoord][yCoord] setTileScore:0];
            [tileMatrix[xCoord][yCoord] setText:@""];
            
            occupied[4*xCoord + yCoord] = freeSpot;
            
        }else if(pocketVal == [infoMatrix[xCoord][yCoord] getScore]){
            
            int newVal = [infoMatrix[xCoord][yCoord] getScore] * 2;
            
            [pocket setText:@""];
            [infoMatrix[xCoord][yCoord] setTileScore:newVal];
            [tileMatrix[xCoord][yCoord] setText:[NSString stringWithFormat:@"%d", newVal]];

            
            pocketVal = 0;
            
        }
        
    }else{
        
        if(![[pocket text] isEqualToString:@""]){
            
            NSString* newVal = [pocket text];
            
            [pocket setText:@""];
            [infoMatrix[xCoord][yCoord] setTileScore: pocketVal];
            [tileMatrix[xCoord][yCoord] setText:newVal];
            
            occupied[4*xCoord + yCoord] = occupiedSpot;
            pocketVal = 0;
            
        }
        
    }
    
    [self updateColors];
    
}

@end
