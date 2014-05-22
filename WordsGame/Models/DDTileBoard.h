//
//  DDTileBoard.h
//  WordsGame
//
//  Created by Daniela Dias on 24/03/14.
//  Copyright (c) 2014 Daniela Dias. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDTileBoard : NSObject

@property (nonatomic) NSUInteger numberOfRows;
@property (nonatomic) NSUInteger numberOfColumns;

@property (nonatomic, copy) NSArray *gridTiles;
@property (nonatomic, copy) NSArray *solutions;

@end
