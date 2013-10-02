//
//  MainMenuLayer.m
//  JungleFeast
//
//  Created by Sylvia on 13-9-15.
//  Copyright 2013年 Sylvia. All rights reserved.
//

#import "MainMenuScene.h"
#import "CCControlButton.h"
#import "CCBReader.h"
#import "GameScene.h"

@implementation MainMenuScene


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainMenuScene *layer = [MainMenuScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}



- (void) pressedPlay:(id)sender
{
    // Load the game scene
    CCScene* layer = [CCBReader sceneWithNodeGraphFromFile:@"GameScene.ccbi"];
    //GameScene *layer = [GameScene node];
    CCScene *scene = [CCScene node];
	[scene addChild: layer];
    // Go to the game scene
    
    [[CCDirector sharedDirector] replaceScene:scene];
}


@end
