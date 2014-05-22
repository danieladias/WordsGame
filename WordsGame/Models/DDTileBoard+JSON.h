//
//  DDTileBoard+JSON.h
//  WordsGame
//
//  Created by Daniela Dias on 24/03/14.
//  Copyright (c) 2014 Daniela Dias. All rights reserved.
//

#import "DDTileBoard.h"

@interface DDTileBoard (JSON)

+ (DDTileBoard *)tileBoardWithJSONDictionary:(NSDictionary *)jsonDictionary;

@end
