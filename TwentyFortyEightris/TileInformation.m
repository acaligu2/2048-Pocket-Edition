//
//  tileInformation.m
//  TwentyFortyEightris
//
//  Created by Anthony Caligure on 2/5/19.
//  Copyright © 2019 Anthony Caligure. All rights reserved.
//

#import "tileInformation.h"

@implementation TileInformation

//Initialize values
-(id)init{
    
    tileScore = 0;
    xCoord = -1;
    yCoord = -1;
    
    left = nil;
    right = nil;
    above = nil;
    below = nil;
    
    return self;
    
}

//Increment score
-(void)setTileScore: (int)scoreAddition{
 
    tileScore += scoreAddition;
    
}

//Return score of tile
-(int)getScore{
    
    return tileScore;
    
}

@end
