//
//  HowToPlay.m
//  JungleFeast
//
//  Created by fcqiao on 13-10-1.
//  Copyright (c) 2013年 Sylvia. All rights reserved.
//

#import "HowToPlay.h"
#import "CCBReader.h"

@implementation HowToPlay
-(void) back:(id)sender
{
    CCScene* mainScene=[CCBReader sceneWithNodeGraphFromFile:@"MainMenuScene.ccbi"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}

@end
