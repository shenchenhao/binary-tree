//
//  SCHTreeNode.m
//  搜索二插树
//
//  Created by 沈 晨豪 on 13-8-3.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import "SCHTreeNode.h"

@implementation SCHTreeNode

@synthesize parent_tree_node = _parent_tree_node;
@synthesize left_tree_node   = _left_tree_node;
@synthesize right_tree_node  = _right_tree_node;

@synthesize tree_value       = _tree_value;
@synthesize tree_depth       = _tree_depth;

@synthesize tree_view        = _tree_view;


@synthesize show_center      = _show_center;
@synthesize start_center     = _start_center;


- (void)setTree_value:(int)tree_value
{
    if(_tree_value == tree_value && _tree_value != 0)
        return;
    
    _tree_value = tree_value;
    _title_label.text = [NSString stringWithFormat:@"%d",tree_value];
}


- (id)init
{
    self = [super init];
    
    if(self)
    {
        _tree_view                   = [[UIView alloc] init];
        _tree_view.backgroundColor   = [UIColor greenColor];
        _tree_view.frame             = CGRectMake(0,
                                                  0,
                                                  40,
                                                  40);
        
        _title_label                 = [[[UILabel alloc] init] autorelease];
        _title_label.frame           = CGRectMake(0,
                                                  0,
                                                  40,
                                                  22);
        
        _title_label.backgroundColor = [UIColor clearColor];
        _title_label.center          = _tree_view.center;
        _title_label.textAlignment   = NSTextAlignmentCenter;
        
        
        [_tree_view addSubview:_title_label];
        
        _tree_value                  = 0;
        _parent_tree_node            = nil;
        _left_tree_node              = nil;
        _right_tree_node             = nil;
        
        
    }
    
    return self;
}

- (void)dealloc
{
    [_tree_view release], _tree_view = nil;
    
    [super dealloc];
    

}

@end
