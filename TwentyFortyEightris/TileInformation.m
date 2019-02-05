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
   
    left = nil;
    right = nil;
    above = nil;
    below = nil;
    
    neighborNum = 0;
    
    return self;
    
}

-(int)getNeighbors{
    
    return neighborNum;
    
}

-(TileInformation*)getAbove{
    
    return above;
    
}

-(TileInformation*)getBelow{
    
    return below;
    
}

-(TileInformation*)getRight{
    
    return right;
    
}
-(TileInformation*)getLeft{
    
    return left;
    
}

-(void)setNeighbor:(TileInformation *)neighborObj inDirection:(NSString *)direction{
    
    if([direction  isEqual: @"above"]){
        
        above = neighborObj;
        neighborNum++;
        
    }
    if ([direction  isEqual: @"below"]){
        
        below = neighborObj;
        neighborNum++;
        
    }
    if([direction  isEqual: @"left"]){
        
        left = neighborObj;
        neighborNum++;
        
    }
    if([direction  isEqual: @"right"]){
        
        right = neighborObj;
        neighborNum++;
        
    }
    
}

//Increment score
-(void)setTileScore: (int)scoreAddition{
 
    tileScore = scoreAddition;
    
}

//Return score of tile
-(int)getScore{
    
    return tileScore;
    
}

@end
