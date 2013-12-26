//
//  SCHBinarySearchTree.m
//  搜索二插树
//
//  Created by 沈 晨豪 on 13-8-3.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import "SCHBinarySearchTree.h"
#import "SCHTreeNode.h"
#import "TreeView.h"
#import <QuartzCore/QuartzCore.h>

@interface SCHBinarySearchTree(private)

- (void)resetSize;

- (void)preOrder:(SCHTreeNode *)node
         isRight:(BOOL)is_right;

- (void)preOrderMove:(SCHTreeNode *)node count:(int *)tree_count color:(UIColor *)color;
- (void)inOrderMove:(SCHTreeNode *)node count:(int *)tree_count color:(UIColor *)color;
- (void)postOrderMove:(SCHTreeNode *)node count:(int *)tree_count color:(UIColor *)color;

- (void)drawPathStartPoint:(CGPoint)start
                  endPoint:(CGPoint)end;
@end

@implementation SCHBinarySearchTree

@synthesize show_view = _show_view;
@synthesize root_node = _root_node;

#pragma mark - 
#pragma mark - 私有方法
- (void)resetSize
{
    if((X - _tree_depth * 20) <= 0)
    {
        _x = 20 << _tree_depth;
     
        _x += X;
        
    }
    
    [self preOrder:_root_node isRight:NO];
}

- (void)preOrder:(SCHTreeNode *)node isRight:(BOOL)is_right
{
    if(node != nil)
    {
      
        if(1 == node.tree_depth)
        {

            node.start_center     = node.parent_tree_node.show_center;
            node.show_center      = CGPointMake(node.parent_tree_node.show_center.x + (is_right?_x:-_x),
                                                node.parent_tree_node.show_center.y + Y);
        }
        
        if(0 != node.tree_depth && 1 != node.tree_depth)
        {
            node.start_center     = node.parent_tree_node.show_center;
            node.show_center      = CGPointMake(node.parent_tree_node.show_center.x + (is_right?40 :-40 ),
                                                node.parent_tree_node.show_center.y + Y);
        }

        [self preOrder:node.left_tree_node isRight:NO];
        [self preOrder:node.right_tree_node isRight:YES];

    }
}


- (void)preOrderMove:(SCHTreeNode *)node count:(int *)tree_count color:(UIColor *)color
{
    if(nil != node)
    {
        *tree_count  += 1;
        
        __block int i = *tree_count;
        [UIView animateWithDuration:0.3
                              delay:0.3 * (*tree_count - 1)
                            options:UIViewAnimationCurveEaseIn
                         animations:^{
                             node.tree_view.backgroundColor = color;
        } completion:^(BOOL finished) {
   
            if(i == _tree_node_array.count)
            {
                
                _is_animation = NO;
            }
        }];
        
        
        [self preOrderMove:node.left_tree_node  count:tree_count color:color];
        [self preOrderMove:node.right_tree_node count:tree_count color:color];
        
    }
}

- (void)inOrderMove:(SCHTreeNode *)node count:(int *)tree_count color:(UIColor *)color
{
    if(nil != node)
    {
        [self inOrderMove:node.left_tree_node  count:tree_count color:color];
        
        *tree_count  += 1;
        
        __block int i = *tree_count;
        [UIView animateWithDuration:0.3
                              delay:0.3 * (*tree_count - 1)
                            options:UIViewAnimationCurveEaseIn
                         animations:^{
                             node.tree_view.backgroundColor = color;
                         } completion:^(BOOL finished) {
                             
                             if(i == _tree_node_array.count)
                             {
                                 
                                 _is_animation = NO;
                             }
                         }];
        
        [self inOrderMove:node.right_tree_node count:tree_count color:color];
        
    }
}

- (void)postOrderMove:(SCHTreeNode *)node count:(int *)tree_count color:(UIColor *)color
{
    if(nil != node)
    {
        [self postOrderMove:node.left_tree_node  count:tree_count color:color];
        [self postOrderMove:node.right_tree_node count:tree_count color:color];
        
        *tree_count  += 1;
        
        __block int i = *tree_count;
        [UIView animateWithDuration:0.3
                              delay:0.3 * (*tree_count - 1)
                            options:UIViewAnimationCurveEaseIn
                         animations:^{
                             node.tree_view.backgroundColor = color;
                         } completion:^(BOOL finished) {
                             
                             if(i == _tree_node_array.count)
                             {
                                 
                                 _is_animation = NO;
                             }
                         }];
        
        
        
    }
}

- (void)drawPathStartPoint:(CGPoint)start
                  endPoint:(CGPoint)end
{
    [((TreeView *)_show_view) addLineFrom:start to:end];
   // [_show_view dr]
}

#pragma mark -
#pragma mark - 初始化

- (id)initWithValue:(int)value
{
    self = [super init];
    
    if(self)
    {
        _show_view              = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              0,
                                                              320,
                                                              460)];
        _tree_node_array        = [[NSMutableArray alloc] init];
        
        _root_node              = [[[SCHTreeNode alloc] init] autorelease];
        _root_node.tree_value   = value;
        _root_node.show_center  = SHOW_CENTER;
        _root_node.start_center = SHOW_CENTER;
        _root_node.tree_depth   = 0;
        _tree_depth             = 0;
        
        [_tree_node_array addObject:_root_node];
        
        _is_animation         = NO;
        _is_show              = NO;
        
    }
    
    return self;
}

- (id)init
{
    self = [super init];
    
    if(self)
    {
        _show_view            = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                         0,
                                                                         320,
                                                                         460)];
        _tree_node_array      = [[NSMutableArray alloc] init];
        
        
        _is_animation         = NO;
        _is_show              = NO;
        
    }
    
    return self;
}


- (void)insertTreeNode:(int)value
{
    if(nil == _root_node)
    {
        _root_node              = [[[SCHTreeNode alloc] init] autorelease];
        _root_node.tree_value   = value;
        _root_node.show_center  = SHOW_CENTER;
        _root_node.start_center = SHOW_CENTER;
        _root_node.tree_depth   = 0;
        _tree_depth             = 0;
        
        [_tree_node_array addObject:_root_node];
    }
    else
    {
        SCHTreeNode *current_node = _root_node;
        SCHTreeNode *parent_node  = nil;
        int          depth        = 1;
        BOOL         is_right     = YES;
        
        while (YES)
        {
            
            //左
            if(value < current_node.tree_value)
            {
                is_right     = NO;
                parent_node  = current_node;
                current_node = current_node.left_tree_node;
                
            
            }
            //右
            else
            {
                is_right     = YES;
                parent_node  = current_node;
                current_node = current_node.right_tree_node;
            }
            
            
            if(nil == current_node)
            {
                
                SCHTreeNode *new_node     = [[[SCHTreeNode alloc] init] autorelease];
                
                if(is_right)
                {
                    parent_node.right_tree_node  = new_node;
                }
                else
                {
                    parent_node.left_tree_node   = new_node;
                }
                
                new_node.tree_value       = value;
                new_node.parent_tree_node = parent_node;
                new_node.tree_depth       = depth;
                _tree_depth               = depth;
                
                new_node.start_center     = parent_node.show_center;
                new_node.show_center      = CGPointMake(parent_node.show_center.x + (is_right?X - 20 * depth:-X + 20 * depth),
                                                        parent_node.show_center.y + Y);
           //     NSLog(@"%@ - %@",NSStringFromCGPoint(new_node.start_center),NSStringFromCGPoint(new_node.show_center));
                [_tree_node_array addObject:new_node];
                
                break;
            }
            
            
            ++depth;
            
        }
        
    }
}

- (void)showTree
{
    
    if(_is_animation)
        return;
    
    _is_animation = YES;
    
    /*已经显示了*/
    if(_is_show)
    {
        /*未完成*/
        return;
    }
    _is_show      = YES;
    
    
 //   [self resetSize];
    
    __block int i = 0;

   // NSLog(@"%d",_tree_node_array.count);
    for (SCHTreeNode *node in _tree_node_array)
    {
        node.tree_view.alpha  = 0.0f;
        node.tree_view.center = node.start_center;
     //   NSLog(@"%@",NSStringFromCGRect(node.tree_view.frame));
        [_show_view addSubview:node.tree_view];
        

        
        
        [UIView animateWithDuration:DURATION
                              delay:node.tree_depth * DURATION * 2
                            options:UIViewAnimationCurveLinear
                         animations:^{
                             
                             node.tree_view.alpha = 1.0f;
                             
                             
                         } completion:^(BOOL finished) {
                             
                             [self drawPathStartPoint:node.start_center
                                             endPoint:node.show_center];
                             
                             [UIView animateWithDuration:DURATION
                                                   delay:0.0f
                                                 options:UIViewAnimationCurveLinear
                                              animations:^{
                                                  
                                                  node.tree_view.center = node.show_center;
                                                  
                                              } completion:^(BOOL finished) {
                                                  
                                                  ++i;
                                                  if(i == _tree_node_array.count)
                                                  {
                                                      _is_animation = NO;
                                                  }
                                                  
                                                  
                                              }];
                         }];
    }
}



- (void)drawPreOrder
{
    if(_is_animation)
        return;
    
    _is_animation = YES;
    
    int      count = 0;
    
    UIColor *color = [UIColor colorWithRed:((arc4random() % 256)) / 255.0f
                                     green:((arc4random() % 256)) / 255.0f
                                      blue:((arc4random() % 256)) / 255.0f
                                     alpha:1.0f];
    [self preOrderMove:_root_node count:&count color:color];
    
    
}

//画中序
- (void)drawInOrder
{
    if(_is_animation)
        return;
    
    _is_animation = YES;
    
    int      count = 0;
    
    UIColor *color = [UIColor colorWithRed:((arc4random() % 256)) / 255.0f
                                     green:((arc4random() % 256)) / 255.0f
                                      blue:((arc4random() % 256)) / 255.0f
                                     alpha:1.0f];
    [self inOrderMove:_root_node count:&count color:color];
 

}

//画后顺
- (void)drawPostOrder
{
    if(_is_animation)
        return;
    
    _is_animation = YES;
    
    int      count = 0;
    
    UIColor *color = [UIColor colorWithRed:((arc4random() % 256)) / 255.0f
                                     green:((arc4random() % 256)) / 255.0f
                                      blue:((arc4random() % 256)) / 255.0f
                                     alpha:1.0f];
    [self postOrderMove:_root_node count:&count color:color];
    
}

#pragma mark - 
#pragma mark - dealloc

- (void)dealloc
{
    [_show_view       release], _show_view       = nil;
    
    [_tree_node_array release], _tree_node_array = nil;
    
    [super dealloc];
}

@end
