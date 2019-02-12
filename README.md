# CS441_Project2
Anthony Caligure
iOS Clone of 2048 (441 Second Project)

I developed this 2048 clone in xCode using Objective-C. The gameboard is comprised of a matrix of labels. The values are updated based on which direction the user decides to swipe. I implemented the UISwipeGestureRecognizer to make my version more resemblant of the original. The information associated with each tile is stored in a TileInformation object. It contains the current score of the tile, along with pointers to all neighboring tiles. 

To make the clone more unique, I implemented a tile-storage feature. In the bottom left corner, there is a "pocket." This pocket can store one tile value, which can be used at a later point. To store a tile, the user simply taps on the desired game-tile. To add it back to the board, the user taps again on the game-tile where they would like it to be placed. It can only be placed in an empty tile, or merged with a tile of the same value. I used UITapGestureRecognizers associated with each UILabel to achieve this. 
