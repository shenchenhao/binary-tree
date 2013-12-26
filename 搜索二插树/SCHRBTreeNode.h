//
//  SCHTreeNode.h
//  红黑树
//
//  Created by 沈 晨豪 on 13-8-8.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    Black,
    Red
}Color;



@interface SCHRBTreeNode : NSObject
{
    SCHRBTreeNode *_parent_tree_node;
    SCHRBTreeNode *_left_tree_node;
    SCHRBTreeNode *_right_tree_node;
    
    int            _value;
    Color          _color;
}
@property (nonatomic,assign) SCHRBTreeNode *parent_tree_node;
@property (nonatomic,assign) SCHRBTreeNode *left_tree_node;
@property (nonatomic,assign) SCHRBTreeNode *right_tree_node;

@property (nonatomic,assign) int            value;
@property (nonatomic,assign) Color          color;

@end
