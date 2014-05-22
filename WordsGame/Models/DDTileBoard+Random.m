//
//  DDTileBoard+Random.m
//  WordsGame
//
//  Created by Daniela Dias on 24/03/14.
//  Copyright (c) 2014 Daniela Dias. All rights reserved.
//

#import "DDTileBoard+Random.h"
#import "DDTile.h"

static NSString * const kLettersAvailable = @"ABCDEFGHIJKLMNOPQRSTUVWXY";

@implementation DDTileBoard (Random)

#pragma mark - Class Methods

+ (DDTileBoard *)randomTileBoardWithNumberOfRows:(NSUInteger)numberOfRows numberOfColumns:(NSUInteger)numberOfColumns {
    
    if (numberOfColumns == 0 || numberOfRows == 0) {
        
        return nil;
    }
    
    // Generate a random board
    
    NSMutableArray *grid = [[NSMutableArray alloc] initWithCapacity:numberOfRows];
    
    for (NSUInteger y = 0; y < numberOfRows; y++) {
    
        @autoreleasepool {
        
            NSMutableArray *columns = [[NSMutableArray alloc] initWithCapacity:numberOfColumns];
        
            for (NSUInteger x = 0; x < numberOfColumns; x++) {
                
                DDTile *tile = [[DDTile alloc] init];
                tile.letter = [DDTileBoard generateRandomLetter];
                [columns addObject:tile];
            }
        
            [grid addObject:[columns copy]];
        }
    }
    
    DDTileBoard *tileBoard = [[DDTileBoard alloc] init];
    tileBoard.numberOfColumns = numberOfColumns;
    tileBoard.numberOfRows = numberOfRows;
    tileBoard.gridTiles = [grid copy];
    
    // Compute solutions for random board
    
    // Read words from dictionary file
    
    tileBoard.solutions = [tileBoard precomputeSolutionsWithDictionaryOfWords:@[]];
    
    ////////////////////////////////////
    
    return tileBoard;
}

#pragma mark - Helpers

+ (NSString *)generateRandomLetter {
    
    unichar randomCharacter = [kLettersAvailable characterAtIndex: arc4random() % [kLettersAvailable length]];
    
    return [NSString stringWithFormat:@"%C", randomCharacter];
}

- (NSArray *)precomputeSolutionsWithDictionaryOfWords:(NSArray *)dictionaryOfWords {
    
    NSMutableArray *solutions = [[NSMutableArray alloc] init];
    
    // Reading the dictionary to memory store the number of letters in the biggest word
    
    // Start with letters in tiles grid and check for matches
    
    // Then create combinations of two letters with adjacent letters in the grid and check for matches - graph
    
    // Repeat until the number of letters in the biggest word
    
    return [solutions copy];
}

@end
