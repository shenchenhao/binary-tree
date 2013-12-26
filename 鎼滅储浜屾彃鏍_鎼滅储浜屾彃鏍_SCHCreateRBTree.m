//
//  SCHCreateRBTree.m
//  红黑树
//
//  Created by 沈 晨豪 on 13-8-8.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import "SCHCreateRBTree.h"
#import "SCHRBTreeNode.h"

@interface SCHCreateRBTree(private)

//插入时候节点的调整
- (void)insertFixUp:(SCHRBTreeNode *)insert_node;

//删除时候节点的调整
- (void)deleteFixUpChild:(SCHRBTreeNode *)child_node parent:(SCHRBTreeNode *)parent_node;

/*左旋*/
- (void)treeNodeRotateLeft:(SCHRBTreeNode *)rotate_node;
/*右旋*/
- (void)treeNodeRotateRight:(SCHRBTreeNode *)rotate_node;

@end
@implementation SCHCreateRBTree

- (id)init
{
    self = [super init];
    
    if(self)
    {
      
    }
    
    return self;
}


#pragma mark - 
#pragma mark - 私有函数

//对插入的节点进行调整
- (void)insertFixUp:(SCHRBTreeNode *)insert_node
{
    SCHRBTreeNode *parent_node   = nil; //父亲节点
    SCHRBTreeNode *g_parent_node = nil; //祖父节点
    SCHRBTreeNode *uncle_node    = nil; //叔叔节点
    SCHRBTreeNode *temp_node     = nil; //临时节点
    
    SCHRBTreeNode *current_node  = insert_node;
    SCHRBTreeNode *root_node     = _root_node;
    
    //0:父亲为黑色
    //什么都不发生
    
    //1:插入节点的父节点是红色 
    while((parent_node = current_node.parent_tree_node) && Red == parent_node.color)
    {
        //祖父节点
        g_parent_node = parent_node.parent_tree_node;
        
        //父亲是 祖父的左子树
        if(parent_node == g_parent_node.left_tree_node)
        {
            
            //叔叔存在 且 为红
            if((uncle_node = g_parent_node.right_tree_node) && Red ==  uncle_node.color)
            {
                uncle_node.color    = Black;
                parent_node.color   = Black;
                g_parent_node.color = Red;
                
                current_node        = g_parent_node;
            }
            //叔叔为黑 或者 不存在
            else
            {
                //当前节点是右子树的时候
                if(parent_node.right_tree_node == current_node)
                {
                    //左旋
                    [self treeNodeRotateLeft:parent_node];
                    root_node    = _root_node;
                    
                    temp_node    = parent_node;
                    parent_node  = current_node;
                    current_node = temp_node;
                }
                
                parent_node.color   = Black;
                g_parent_node.color = Red;
                //右旋
                [self treeNodeRotateRight:g_parent_node];
                root_node           = _root_node;
            }
        }
        //父亲是 祖父的右子树
        else
        {
            //叔叔存在 且 为红
            if((uncle_node = g_parent_node.left_tree_node) && Red == uncle_node.color)
            {
                uncle_node.color    = Black;
                parent_node.color   = Black;
                g_parent_node.color = Red;
                current_node        = g_parent_node;
            }
            //叔叔为黑 或者 不存在
            else
            {
                if(parent_node.left_tree_node == current_node)
                {
                    //右旋
                    [self treeNodeRotateRight:parent_node];
                    root_node    = _root_node;
                    
                    temp_node    = parent_node;
                    parent_node  = current_node;
                    current_node = temp_node;
                }
                
                parent_node.color   = Black;
                g_parent_node.color = Red;
                //左旋
                [self treeNodeRotateLeft:g_parent_node];
                root_node           = _root_node;
                
            }
        }
        
    }

    //根节点一直是黑的
    root_node.color = Black;
    
}


/*
 x: 删除节点
 y: x的兄弟
 情况1：x的兄弟y是红色的。
 
 情况2：x的兄弟y是黑色的，且y的俩个孩子都是黑色的。
 
 情况3：x的兄弟y是黑色的，y的左孩子是红色，y的右孩子是黑色。
 
 情况4：x的兄弟y是黑色的，且y的右孩子时红色的。
 */

//删除时候节点的调整
- (void)deleteFixUpChild:(SCHRBTreeNode *)child_node parent:(SCHRBTreeNode *)parent_node
{
    SCHRBTreeNode *brother_node;
    SCHRBTreeNode *brother_left_node;
    SCHRBTreeNode *brother_right_node;
    
    SCHRBTreeNode *node = child_node;  //node 是 从结构上被替换到的那个点原来的位置 不是指 数字
    
    while ((nil == node || Black ==  node.color) && node != _root_node)
    {
        
        //node 为右子树的时
        if (parent_node.left_tree_node == node)
        {
            brother_node = parent_node.right_tree_node;
            
            //1: x的兄弟y是红色
            if(brother_node.left_tree_node == node)
            {
                brother_node.color = Black;
                parent_node.color  = Red;
                
                //左旋
                [self treeNodeRotateLeft:parent_node];
                
                brother_node       = parent_node.right_tree_node;
            }
            
            
            //2: X的兄弟是y 是黑色且2个儿子也为黑色  或者是 nil
            if((nil == brother_node.right_tree_node || Black == brother_node.right_tree_node) &&
               (nil == brother_node.left_tree_node || Black == brother_node.left_tree_node))
            {
                brother_node.color = Red;
                node               = parent_node;
                parent_node        = node.parent_tree_node;
                
            }
            //3: x的兄弟y是黑色的 且y的左孩子是红色，右孩子是黑色
            else
            {
                if(nil == brother_node.right_tree_node || Black == brother_node.right_tree_node.color)
                {
                    if((brother_left_node = brother_node.left_tree_node))
                    {
                        brother_left_node.color = Black;
                    }
                    
                    brother_node.color = Red;
                    
                    //右旋
                    [self treeNodeRotateRight:brother_node];
                    brother_node       = parent_node.right_tree_node;
                }
                
                //4: x的兄弟y是黑色的
                brother_node.color = parent_node.color;
                parent_node.color  = Black;
                
                if(brother_node.right_tree_node)
                {
                    brother_node.right_tree_node.color = Black;
                }
                
                //左旋
                [self treeNodeRotateLeft:parent_node];
                
                node = _root_node;
                break;
            }
        }
        else
        {
            brother_node = parent_node.right_tree_node;
            
            //1: x的兄弟y是红色
            if (Red == brother_node.color)
            {
                brother_node.color = Black;
                parent_node.color  = Red;
                
                //右旋
                [self treeNodeRotateRight:parent_node];
                brother_node = parent_node.left_tree_node;
            }
            
            //2: X的兄弟是y 是黑色且2个儿子也为黑色  或者是 nil
            if((nil == brother_node.right_tree_node || Black == brother_node.right_tree_node) &&
               (nil == brother_node.left_tree_node || Black == brother_node.left_tree_node))
            {
                brother_node.color = Red;
                node               = parent_node;
                parent_node        = node.parent_tree_node;
                
            }
            //3: x的兄弟y是黑色的 且y的左孩子是黑色，右孩子是红色
            else
            {
                if(nil == brother_node.left_tree_node || Black == brother_node.left_tree_node.color)
                {
                    if((brother_right_node = brother_node.right_tree_node))
                    {
                        brother_right_node.color = Black;
                    }
                    
                    brother_node.color = Red;
                    
                    //左旋
                    [self treeNodeRotateLeft:brother_node];
                    brother_node       = parent_node.left_tree_node;
                }
                
                //4: x的兄弟y是黑色的
                brother_node.color = parent_node.color;
                parent_node.color  = Black;
                
                if(brother_node.left_tree_node)
                {
                    brother_node.left_tree_node.color = Black;
                }
                
                //右旋
                [self treeNodeRotateRight:parent_node];
                node = _root_node;
                
                break;
            }
            
        }
        
    }
    
    
    if(node)
    {
        node.color = Black;
    }
}


/* 
   rotate_node                   right
    /      \                   /        \
   a        right     ->  rotate_node     y
             / \             /     \
            x   y           a       x
 */

/*左旋*/
- (void)treeNodeRotateLeft:(SCHRBTreeNode *)rotate_node
{
    SCHRBTreeNode *right = rotate_node.right_tree_node;
    
    if((rotate_node.right_tree_node = right.left_tree_node))
    {
        right.left_tree_node.parent_tree_node = rotate_node;
    }
    
    
    right.left_tree_node = rotate_node;
    
    if((right.parent_tree_node = rotate_node.parent_tree_node))
    {
        if(rotate_node == rotate_node.parent_tree_node.right_tree_node)
        {
            rotate_node.parent_tree_node.right_tree_node = right;
        }
        else
        {
            rotate_node.parent_tree_node.left_tree_node  = right;
        }
    }
    else
    {
        _root_node = right;
    }
    
    
    rotate_node.parent_tree_node = right;
    
}

/*     rotate_node                 left
        /       \               /         \
      left       c     ->      a       rotate_node
      /  \                               /    \
     a    b                             b      c
*/


/*右旋*/
- (void)treeNodeRotateRight:(SCHRBTreeNode *)rotate_node
{
    SCHRBTreeNode *left = rotate_node.left_tree_node;
    
    if((rotate_node.left_tree_node = left.right_tree_node))
    {
        left.right_tree_node.parent_tree_node = rotate_node;
    }
    
    left.right_tree_node = rotate_node;
    
    if((left.parent_tree_node = rotate_node.parent_tree_node))
    {
        if(rotate_node == rotate_node.parent_tree_node.right_tree_node)
        {
            rotate_node.parent_tree_node.right_tree_node = left;
        }
        else
        {
            rotate_node.parent_tree_node.left_tree_node  = left;
        }
    }
    else
    {
        _root_node = left;
    }
    
    rotate_node.parent_tree_node = left;

}


#pragma mark -
#pragma mark - 公共函数

- (SCHRBTreeNode *)searchTreeNode:(int)value
{
    SCHRBTreeNode *current_node = _root_node;
    int            compare_value;
    while (current_node)
    {
        compare_value = value - current_node.value;
        
        if(value > 0)
        {
            current_node = current_node.right_tree_node;
        }
        else if(value < 0)
        {
            current_node = current_node.left_tree_node;
        }
        else
        {
            return current_node;
        }
        
        
    }
    
    return nil;
}


- (BOOL)insertTreeNode:(int)value
{
    if(nil == _root_node)
    {
        _root_node       = [[[SCHRBTreeNode alloc] init] autorelease];
        _root_node.color = Black;
        _root_node.value = value;
        
        [_tree_node_array addObject:_root_node];
        
    }
    else
    {
        SCHRBTreeNode *current_node        = _root_node;
        SCHRBTreeNode *current_parent_node = nil;
        while (YES)
        {
//            if(value == current_node.value)
//                return NO;
            
            //左
            if(value < current_node.value)
            {
                current_parent_node = current_node;
                current_node        = current_node.left_tree_node;
            }
            //右
            else
            {
                current_parent_node = current_node;
                current_node        = current_node.right_tree_node;
            }
            
            if(nil == current_node)
            {
                current_node                  = [[[SCHRBTreeNode alloc] init] autorelease];
                current_node.value            = value;
                current_node.parent_tree_node = current_parent_node;
                
                [_tree_node_array addObject:current_node];
                
                [self insertFixUp:current_node];
            }
            
        }
    }
    
     return YES;
}

/*
 情况1：x的兄弟w是红色的。
 
 情况2：x的兄弟w是黑色的，且w的俩个孩子都是黑色的。
 
 情况3：x的兄弟w是黑色的，w的左孩子是红色，w的右孩子是黑色。
 
 情况4：x的兄弟w是黑色的，且w的右孩子时红色的。
 */

- (BOOL)deleteTreeNode:(int)value
{
    SCHRBTreeNode *current_node = [self searchTreeNode:value];
    
    if(!current_node)
    {
        NSLog(@"不存在删除的 节点");
        return NO;
    }
    
    SCHRBTreeNode *child_node;
    SCHRBTreeNode *parent_node;
    SCHRBTreeNode *delete_node;
    SCHRBTreeNode *left_node;
    
    Color          node_color;
    
    delete_node = current_node;
    
    //删除节点 有左右子树
    if(delete_node.left_tree_node && delete_node.right_tree_node)
    {
        current_node = current_node.right_tree_node;
        
        
        while ((left_node = current_node.left_tree_node))
        {
            current_node = left_node;
        }
        
        child_node  = current_node.right_tree_node;//循环下来 左子树而且大于删除节点的最小值 已经是nil 所以只有右孩子
        parent_node = current_node.parent_tree_node;
        node_color  = current_node.color;
        
        
        if(child_node)
        {
            child_node.parent_tree_node = parent_node;
        }
        
        if (parent_node)
        {
            if(current_node == parent_node.left_tree_node)
            {
                parent_node.left_tree_node = child_node;
            }
            else
            {
                parent_node.right_tree_node = child_node;
            }
        }
        else
        {
            _root_node = child_node;
        }
        
        if(current_node.parent_tree_node == delete_node)
        {
            parent_node = delete_node;
        }
        
        current_node.parent_tree_node = delete_node.parent_tree_node;
        current_node.color            = delete_node.color;
        current_node.right_tree_node  = delete_node.right_tree_node;
        current_node.left_tree_node   = delete_node.left_tree_node;
        
        if(delete_node.parent_tree_node)
        {
            if(delete_node.parent_tree_node.left_tree_node == delete_node)
            {
                delete_node.parent_tree_node.left_tree_node = current_node;
            }
            else
            {
                delete_node.parent_tree_node.right_tree_node = current_node;
            }
        }
        else
        {
            _root_node = current_node;
        }
        
        delete_node.left_tree_node.parent_tree_node = current_node;
        
        if(delete_node.right_tree_node)
        {
            delete_node.right_tree_node.parent_tree_node = current_node;
        }
        
    }
    else
    {
        if(nil == current_node.left_tree_node)
        {
            child_node = current_node.right_tree_node;
        }
        else if(nil == current_node.right_tree_node)
        {
            child_node = current_node.left_tree_node;
        }
        
        parent_node = current_node.parent_tree_node;
        node_color  = current_node.color;
        
        if(child_node)
        {
            child_node.parent_tree_node = parent_node;
        }
        
        if(parent_node)
        {
            if(parent_node.left_tree_node == current_node)
            {
                parent_node.left_tree_node = child_node;
            }
            else
            {
                parent_node.right_tree_node = child_node;
            }
        }
        else
        {
            _root_node = child_node;
        }
    }
    
    //移除 需要删除的节点
    [_tree_node_array removeObject:delete_node];
    
    
    //如果移动的点是黑色的话
    if(Black == node_color)
    {
        [self deleteFixUpChild:child_node parent:parent_node];
    }
    
    return YES;
}

@end



























