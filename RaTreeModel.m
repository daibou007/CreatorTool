//
//  RaTreeModel.m
//  CreatorTool
//
//  Created by 杨朋亮 on 1/6/18.
//  Copyright © 2018年 杨朋亮. All rights reserved.
//

#import "RaTreeModel.h"

@implementation RaTreeModel

- (id)initWithName:(NSString *)name children:(NSArray *)children{
    self = [super init];
    if (self) {
        self.children = children;
        self.name = name;
    }
    return self;
}

+ (id)dataObjectWithName:(NSString *)name children:(NSArray *)children{
    return [[self alloc] initWithName:name children:children];
}

@end
