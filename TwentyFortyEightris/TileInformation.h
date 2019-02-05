//
//  tileInformation.h
//  TwentyFortyEightris
//
//  Created by Anthony Caligure on 2/5/19.
//  Copyright © 2019 Anthony Caligure. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TileInformation : NSObject{
    
    TileInformation* left;              //Left neighbor
    TileInformation* right;             //Right neighbor
    TileInformation* above;             //Upper neighbor
    TileInformation* below;             //Lower neighbor
    
    int tileScore;                      //Value of tile
    
    int neighborNum;
    
}

-(void)setTileScore: (int)scoreAddition;
-(void)setNeighbor: (TileInformation*)neighborObj inDirection:(NSString*)direction;
-(int)getScore;
-(int)getNeighbors;
-(TileInformation*)getAbove;
-(TileInformation*)getBelow;
-(TileInformation*)getLeft;
-(TileInformation*)getRight;

@end
