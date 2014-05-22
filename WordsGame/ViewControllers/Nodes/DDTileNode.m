//
//  DDTileNode.m
//  WordsGame
//
//  Created by Daniela Dias on 24/03/14.
//  Copyright (c) 2014 Daniela Dias. All rights reserved.
//

#import "DDTileNode.h"
#import "DDTile.h"

static NSString * const kTileNameKey = @"tileNode";
static NSString * const kTileFontName = @"Helvetica";

@interface DDTileNode ()

@property (nonatomic, strong) SKLabelNode *textLabelNode;

@end

@implementation DDTileNode

#pragma mark - Lifecycle

- (instancetype)initWithPosition:(CGPoint)position
                          inSize:(CGSize)size
                       withColor:(SKColor *)color {
    
    if ((self = [super init])) {
        
        self.color = color;
        self.position = position;
        self.size = size;
        self.name = kTileNameKey;
        self.anchorPoint = CGPointZero;
    }
    
    return self;
}

#pragma mark - Properties

- (SKLabelNode *)textLabelNode {
    
    if (_textLabelNode == nil) {
        
        _textLabelNode = [SKLabelNode labelNodeWithFontNamed:kTileFontName];
        _textLabelNode.fontColor = [UIColor whiteColor];
        _textLabelNode.fontSize = MIN(self.size.width, self.size.height) * 0.60f;
        _textLabelNode.position = CGPointMake(self.size.width / 2.0f, self.size.height / 2.0f);
        _textLabelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        _textLabelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        
        [self addChild:_textLabelNode];
    }

    return _textLabelNode;
}

- (void)setState:(NSInteger)state {
    
    [self removeAllActions];
    
    if (state == DDTileNodeStateNormal) {
    
        SKAction *actionColor = [SKAction colorizeWithColor:[UIColor orangeColor] colorBlendFactor:1.0 duration:0.2];
        SKAction *colorActions = [SKAction sequence:@[actionColor]];
        [self runAction:colorActions];
    
    } else if (state == DDTileNodeStateSelected) {
        
        SKAction *actionScaleUp = [SKAction scaleTo:1.01 duration:0.1];
        SKAction *actionScaleDown = [SKAction scaleTo:1.0 duration:0.1];
        
        SKAction *scaleActions = [SKAction sequence:@[actionScaleUp, actionScaleDown]];
        [self runAction:scaleActions];
        
        SKAction *actionColor = [SKAction colorizeWithColor:[UIColor blueColor] colorBlendFactor:1.0 duration:0.2];
        SKAction *colorActions = [SKAction sequence:@[actionColor]];
        [self runAction:colorActions];
    
    } else if (state == DDTileNodeStateCorrect) {
    
        SKAction *actionColorSuccess = [SKAction colorizeWithColor:[UIColor greenColor] colorBlendFactor:1.0 duration:0.7];
        SKAction *actionColorNormal = [SKAction colorizeWithColor:[UIColor orangeColor] colorBlendFactor:1.0 duration:0.2];
        SKAction *colorActions = [SKAction sequence:@[actionColorSuccess, actionColorNormal]];
        [self runAction:colorActions];
    
        _state = DDTileNodeStateNormal;
        
    } else if (state == DDTileNodeStateWrong) {
    
        SKAction *actionColorFailure = [SKAction colorizeWithColor:[UIColor redColor] colorBlendFactor:1.0 duration:0.7];
        SKAction *actionColorNormal = [SKAction colorizeWithColor:[UIColor orangeColor] colorBlendFactor:1.0 duration:0.2];
        SKAction *colorActions = [SKAction sequence:@[actionColorFailure, actionColorNormal]];
        [self runAction:colorActions];
        
        _state = DDTileNodeStateNormal;
        
    } else {
        
        // Do Something?
    }
}

- (void)setTile:(DDTile *)tile {
    
    _tile = tile;
    
    self.textLabelNode.text = tile.letter;
}

@end
