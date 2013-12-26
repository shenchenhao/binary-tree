//
//  SCHTreeNode.h
//  搜索二插树
//
//  Created by 沈 晨豪 on 13-8-3.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SCHTreeNode;
@interface SCHTreeNode : NSObject
{
    SCHTreeNode *_parent_tree_node;
    SCHTreeNode *_left_tree_node;
    SCHTreeNode *_right_tree_node;
    
    int          _tree_value;
    int          _tree_depth;
    
    UILabel     *_title_label;
    UIView      *_tree_view;
    
    CGPoint      _show_center;
    CGPoint      _start_center;
}

@property (nonatomic,assign) SCHTreeNode *parent_tree_node;
@property (nonatomic,assign) SCHTreeNode *left_tree_node;
@property (nonatomic,assign) SCHTreeNode *right_tree_node;

@property (nonatomic,assign) CGPoint      show_center;
@property (nonatomic,assign) CGPoint      start_center;

@property (nonatomic,assign) int          tree_value;
@property (nonatomic,assign) int          tree_depth;
@property (nonatomic,retain) UIView      *tree_view;
@end
