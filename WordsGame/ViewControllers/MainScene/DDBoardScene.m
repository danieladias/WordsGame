//
//  DDMyScene.m
//  WordsGame
//
//  Created by Daniela Dias on 24/03/14.
//  Copyright (c) 2014 Daniela Dias. All rights reserved.
//

#import "DDBoardScene.h"
#import "DDTileNode.h"
#import "DDTile.h"
#import "DDTileBoard.h"

static NSString * const kWordLabelName = @"wordLabel";
static NSString * const kWordLabelFontName = @"Helvetica";

/**
 * Dimensions and Positions
 */
static CGFloat const kBoardAvailableSpaceWidthPercentage = 0.95f;
static CGFloat const kWordLabelHeightPercentage = 0.10f;
static CGFloat const kWordLabelVerticalMarginPercentage = 0.10f;

@interface DDBoardScene ()

@property (nonatomic, strong) NSMutableArray *selectedNodes;
@property (nonatomic, strong) SKLabelNode *wordLabelNode;

@property (nonatomic, strong) DDTileBoard *board;

/**
 * Methods
 */
- (void)checkWordAndCleanNodesState;

@end

@implementation DDBoardScene

#pragma mark - Lifecycle

- (instancetype)initBoard:(DDTileBoard *)board withSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        
        self.board = board;
        
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor whiteColor];
        
        /**
         * Tiles Dimensions and Padding
         */
        
        CGFloat tilePadding = (size.width * (1 - kBoardAvailableSpaceWidthPercentage)) / (self.board.numberOfColumns + 1);
        CGFloat tileWidth = (size.width * kBoardAvailableSpaceWidthPercentage) / self.board.numberOfColumns;
        CGSize tileSize = CGSizeMake(tileWidth, tileWidth);
        
        CGFloat totalVerticalPadding = ((self.board.numberOfRows - 1) * tilePadding);
        
        /**
         * Board Dimension
         */
        CGFloat boardSize = (self.board.numberOfRows * tileWidth) + totalVerticalPadding;
        
        /**
         * Word Label Position and Dimensions
         */
        
        CGFloat wordLabelVerticalMargin = size.height * kWordLabelVerticalMarginPercentage;
        CGFloat wordLabelHeight = (size.height * kWordLabelHeightPercentage);
        CGFloat wordLabelXPosition = size.width / 2.0f;
        CGFloat wordLabelYPosition = boardSize + wordLabelVerticalMargin + wordLabelHeight;
        
        CGFloat boardTopBottomMargin = (size.height - wordLabelYPosition) / 2.0f;
        
        // Create board with rows and columns

        for (NSUInteger y = 0; y < self.board.numberOfRows; y++) {
            
            CGFloat tileYPositon = (y * tileWidth) + tilePadding * y;
            NSArray *columns = self.board.gridTiles[y];
            
            for (NSUInteger x = 0; x < self.board.numberOfColumns; x++) {
            
                CGFloat tileXPositon = (x * tileWidth) + tilePadding * (x + 1);
                
                // Anchor point of tile is (0,0)
                
                CGPoint tilePosition = CGPointMake(tileXPositon, boardSize - tileWidth + boardTopBottomMargin - tileYPositon);

                DDTileNode *tileNode = [[DDTileNode alloc] initWithPosition:tilePosition
                                                                     inSize:tileSize
                                                                  withColor:[SKColor orangeColor]];
                tileNode.tile = columns[x];
                
                // Add node to scene
                
                [self addChild:tileNode];
            }
        }
        
        // Word Label should appear above board
        
        // What to do if board too big and hides label? Scrollable view?
        
        self.wordLabelNode = [SKLabelNode labelNodeWithFontNamed:kWordLabelFontName];
        self.wordLabelNode.fontColor = [SKColor blackColor];
        self.wordLabelNode.fontSize = wordLabelHeight;
        self.wordLabelNode.position = CGPointMake(wordLabelXPosition, wordLabelYPosition);
        self.wordLabelNode.text = @"";
        self.wordLabelNode.name = kWordLabelName;
        
        [self addChild:self.wordLabelNode];
    }
    
    return self;
}

#pragma mark - Properties

- (NSMutableArray *)selectedNodes {
    
    if (_selectedNodes == nil) {
        
        _selectedNodes = [[NSMutableArray alloc] init];
    }
    
    return _selectedNodes;
}

#pragma mark - Private Methods

- (void)checkWordAndCleanNodesState {
    
    // Check word
    
    DDTileNodeState state = DDTileNodeStateWrong;
    
    if ([self.board.solutions containsObject:self.wordLabelNode.text]) {
        
        // Success
        state = DDTileNodeStateCorrect;
    }
    
    // Animate to show result
    
    for (SKNode *node in self.selectedNodes) {
        
        if ([node isKindOfClass:[DDTileNode class]]) {
            
            DDTileNode *tileNode = (DDTileNode *)node;
            tileNode.state = state;
        }
    }
    
    // Clean states

    self.selectedNodes = nil;
    self.wordLabelNode.text = @"";
}

#pragma mark - Actions

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    /* Called when a touch begins */

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node isKindOfClass:[DDTileNode class]]) {
        
        DDTileNode *tileNode = (DDTileNode *)node;

        // TODO: Add validation for adjacent letter just in case
        
        if (tileNode.state == DDTileNodeStateNormal) {
            
            tileNode.state = DDTileNodeStateSelected;
            
            if (![self.selectedNodes containsObject:tileNode]) {
                
                [self.selectedNodes addObject:tileNode];
                
                // Update word label appending letter of touched tile
                
                self.wordLabelNode.text = [NSString stringWithFormat:@"%@%@", self.wordLabelNode.text, tileNode.tile.letter];
            }
        }
        
        while ([self.selectedNodes containsObject:tileNode] && [self.selectedNodes lastObject] != tileNode) {
            
            DDTileNode *lastNode = (DDTileNode *)[self.selectedNodes lastObject];
            lastNode.state = DDTileNodeStateNormal;
            
            [self.selectedNodes removeObject:lastNode];
            
            // Update word label removing last letter of last touched tile
            
            self.wordLabelNode.text = [self.wordLabelNode.text substringToIndex:[self.wordLabelNode.text length] - 1];
        }
        
    } else {
        
       // Do something
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self checkWordAndCleanNodesState];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {

    [self checkWordAndCleanNodesState];
}


@end
