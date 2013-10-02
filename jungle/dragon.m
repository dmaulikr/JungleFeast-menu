//
//  dragon.m
//  JungleFeast
//
//  Created by Deng Yuanyuan on 13-9-23.
//  Copyright (c) 2013年 Sylvia. All rights reserved.
//

#import "dragon.h"

@implementation dragon
@synthesize xTarget;
@synthesize yTarget;

- (id) init
{
    self = [super init];
    if (!self) return NULL;
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    xTarget = winSize.width/2;
    yTarget = winSize.height/2;
    //[self schedule:@selector(update:)];
    return self;
}

- (void) update
//:(ccTime)delta
{
    // flip
    if(xTarget > self.position.x){
        self.rotationY = 0;
    }else if(xTarget < self.position.x){
        self.rotationY = 180;
    }
    
    self.position = ccp(xTarget,yTarget);
    
    
}

- (float) radius
{
    return 25;
}


@end
