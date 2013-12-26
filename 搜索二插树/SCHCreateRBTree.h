//
//  SCHCreateRBTree.h
//  红黑树
//
//  Created by 沈 晨豪 on 13-8-8.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SCHRBTreeNode;
@interface SCHCreateRBTree : NSObject
{
    SCHRBTreeNode   *_root_node;  //跟节点
    
    NSMutableArray  *_tree_node_array;
    
}

- (BOOL)insertTreeNode:(int)value;

- (BOOL)deleteTreeNode:(int)value;

- (SCHRBTreeNode *)searchTreeNode:(int)value;
@end
