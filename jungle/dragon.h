//
//  dragon.h
//  JungleFeast
//
//  Created by Deng Yuanyuan on 13-9-23.
//  Copyright (c) 2013年 Sylvia. All rights reserved.
//

#import "CCNode.h"

@interface dragon : CCNode{
    float xTarget;
    float yTarget;
}
@property (nonatomic,assign) float xTarget;
@property (nonatomic,assign) float yTarget;
@property (nonatomic,assign) BOOL live;

- (void) update;
@end
