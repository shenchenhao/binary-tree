//
//  SCHBinarySearchTree.h
//  搜索二插树
//
//  Created by 沈 晨豪 on 13-8-3.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SHOW_CENTER  CGPointMake(768 / 2, 60);

#define X            100
#define Y            80



#define DURATION     0.3f


@class SCHTreeNode;
@interface SCHBinarySearchTree : NSObject
{
    UIView          *_show_view;
    
    SCHTreeNode     *_root_node;
    int              _tree_depth;
    
    NSMutableArray  *_tree_node_array;
    
    BOOL             _is_animation;
    BOOL             _is_show;
    
    CGFloat          _x;
    
    
}

@property (nonatomic,retain)   UIView      *show_view;
@property (nonatomic,readonly) SCHTreeNode *root_node;
- (id)initWithValue:(int)value;

- (void)insertTreeNode:(int)value;

- (void)showTree;

//画前序
- (void)drawPreOrder;
//画中序
- (void)drawInOrder;
//画后顺
- (void)drawPostOrder;
@end
