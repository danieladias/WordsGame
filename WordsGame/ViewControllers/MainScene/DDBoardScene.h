//
//  DDMyScene.h
//  WordsGame
//

//  Copyright (c) 2014 Daniela Dias. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class DDTileBoard;

@interface DDBoardScene : SKScene

- (instancetype)initBoard:(DDTileBoard *)board withSize:(CGSize)size;

@end
