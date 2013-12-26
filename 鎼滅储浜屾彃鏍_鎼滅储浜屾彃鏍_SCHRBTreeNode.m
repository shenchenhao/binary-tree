//
//  SCHTreeNode.m
//  红黑树
//
//  Created by 沈 晨豪 on 13-8-8.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import "SCHRBTreeNode.h"

@implementation SCHRBTreeNode

@synthesize parent_tree_node = _parent_tree_node;
@synthesize left_tree_node   = _left_tree_node;
@synthesize right_tree_node  = _right_tree_node;

@synthesize value            = _value;
@synthesize color            = _color;

- (id)init
{
    self = [super init];
    
    if(self)
    {
        _parent_tree_node = nil;
        _left_tree_node   = nil;
        _right_tree_node  = nil;
        _color            = Red;  //红
    }
    
    return self;
    
}
@end
