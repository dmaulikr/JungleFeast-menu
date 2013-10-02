//
//  heart.m
//  JungleFeast
//
//  Created by Deng Yuanyuan on 13-9-27.
//  Copyright (c) 2013年 Sylvia. All rights reserved.
//

#import "heart.h"

@implementation Heart
-(id) init{
    self.charSprite = [CCSprite spriteWithFile:@"heart.png"];
    self.speed = 20;
    self.point = 0;
    isclean = NO;
    
    return self;
}

- (void) dealloc
{
    self.charSprite = nil;
    [super dealloc];
}
@end
