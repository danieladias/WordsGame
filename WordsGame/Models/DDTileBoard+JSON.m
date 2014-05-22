//
//  DDTileBoard+JSON.m
//  WordsGame
//
//  Created by Daniela Dias on 24/03/14.
//  Copyright (c) 2014 Daniela Dias. All rights reserved.
//

#import "DDTileBoard+JSON.h"
#import "DDTile.h"

@implementation DDTileBoard (JSON)

+ (DDTileBoard *)tileBoardWithJSONDictionary:(NSDictionary *)jsonDictionary {
    
    if (jsonDictionary == nil
        || jsonDictionary[@"grid"] == nil
        || jsonDictionary[@"words"] == nil ) {
        
        return nil;
    }
    
    if (![jsonDictionary[@"grid"] isKindOfClass:[NSDictionary class]]
        || ![jsonDictionary[@"words"] isKindOfClass:[NSArray class]]) {
        
        return nil;
    }
    
    DDTileBoard *tileBoard = [[DDTileBoard alloc] init];
    
    // Parse Board
    
    NSDictionary *gridDictionary = jsonDictionary[@"grid"];
    NSArray *gridKeysOrdered = [gridDictionary.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSMutableArray *grid = [[NSMutableArray alloc] init];
    NSMutableArray *columns = [[NSMutableArray alloc] init];
    
    NSString *lastRowLetter = @"";
    
    for (NSString *gridTileKey in gridKeysOrdered) {
        
        NSString *rowLetter = [gridTileKey substringToIndex:1];
        NSString *tileLetter = gridDictionary[gridTileKey];

        DDTile *tile = [[DDTile alloc] init];
        tile.letter = tileLetter;
        
        if (![lastRowLetter length] || [rowLetter isEqualToString:lastRowLetter]) {
            
            [columns addObject:tile];
            
        } else {
            
            // Validate equal number of columns in each row
            
            [grid addObject:[columns copy]];
            [columns removeAllObjects];
            [columns addObject:tile];
        }
        
        lastRowLetter = rowLetter;
    }
    
    [grid addObject:[columns copy]];
    tileBoard.gridTiles = [grid copy];
    tileBoard.numberOfRows = grid.count;
    tileBoard.numberOfColumns = columns.count;
    
    // Parse words
    
    NSArray *wordsArray = jsonDictionary[@"words"];
    NSMutableArray *solutions = [[NSMutableArray alloc] initWithCapacity:wordsArray.count];
    
    for (NSString *word in wordsArray) {
        
        [solutions addObject:word];
    }
    
    tileBoard.solutions = [solutions copy];
    
    return tileBoard;
}

@end
