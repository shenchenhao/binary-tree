//
//  TreeView.h
//  搜索二插树
//
//  Created by 沈 晨豪 on 13-8-3.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TreeView : UIView

{
    NSMutableArray *_array;
}

- (void)addLineFrom:(CGPoint)start
                 to:(CGPoint)end;
@end
