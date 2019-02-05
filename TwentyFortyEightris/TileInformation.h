//
//  tileInformation.h
//  TwentyFortyEightris
//
//  Created by Anthony Caligure on 2/5/19.
//  Copyright © 2019 Anthony Caligure. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TileInformation : NSObject{
    
    int xCoord;                         //Gives x-location in tile matrix
    int yCoord;                         //Gives y-location in tile matrix
    
    TileInformation* left;              //Left neighbor
    TileInformation* right;             //Right neighbor
    TileInformation* above;             //Upper neighbor
    TileInformation* below;             //Lower neighbor
    
    int tileScore;                      //Value of tile
    
}

-(void)setTileScore: (int)scoreAddition;
-(int)getScore;

@end
