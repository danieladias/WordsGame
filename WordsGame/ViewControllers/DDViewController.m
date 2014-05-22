//
//  DDViewController.m
//  WordsGame
//
//  Created by Daniela Dias on 24/03/14.
//  Copyright (c) 2014 Daniela Dias. All rights reserved.
//

#import "DDViewController.h"
#import "DDBoardScene.h"
#import "DDTileBoard+JSON.h"
#import "DDTileBoard+Random.h"

static NSString * const kBoardSampleJSONFilename = @"sample";

@implementation DDViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Read JSON file or create a random board
    
    DDTileBoard *board = [self readJSONBoardFromFileWithName:kBoardSampleJSONFilename];
    //DDTileBoard *board = [DDTileBoard randomTileBoardWithNumberOfRows:7 numberOfColumns:7];
    
    // Configure the view
    
    SKView * skView = (SKView *)self.view;
    
    // Create and configure the scene
    
    SKScene * scene = [[DDBoardScene alloc] initBoard:board withSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene
    
    [skView presentScene:scene];
}

#pragma mark - Private Methods

- (DDTileBoard *)readJSONBoardFromFileWithName:(NSString *)filename {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"json"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    //parse out the json data
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:&error];
    
    return [DDTileBoard tileBoardWithJSONDictionary:json[@"data"]];
}

@end
