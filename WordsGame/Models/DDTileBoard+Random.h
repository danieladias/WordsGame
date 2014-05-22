//
//  DDTileBoard+Random.h
//  WordsGame
//
//  Created by Daniela Dias on 24/03/14.
//  Copyright (c) 2014 Daniela Dias. All rights reserved.
//

#import "DDTileBoard.h"

@interface DDTileBoard (Random)

+ (DDTileBoard *)randomTileBoardWithNumberOfRows:(NSUInteger)numberOfRows
                                 numberOfColumns:(NSUInteger)numberOfColumns;

@end
