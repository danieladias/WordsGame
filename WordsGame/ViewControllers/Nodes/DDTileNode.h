//
//  DDTileNode.h
//  WordsGame
//
//  Created by Daniela Dias on 24/03/14.
//  Copyright (c) 2014 Daniela Dias. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSUInteger, DDTileNodeState) {
    
    DDTileNodeStateUnknown = -1,
    DDTileNodeStateNormal = 0,
    DDTileNodeStateSelected,
    DDTileNodeStateCorrect,
    DDTileNodeStateWrong
};

@class DDTile;

@interface DDTileNode : SKSpriteNode

@property (nonatomic, strong) DDTile *tile;
@property (nonatomic) NSInteger state;

- (instancetype)initWithPosition:(CGPoint)position
                          inSize:(CGSize)size
                       withColor:(UIColor *)color;

@end
