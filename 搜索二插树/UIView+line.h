//
//  UIView+line.h
//  搜索二插树
//
//  Created by 沈 晨豪 on 13-12-26.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (line)

-(void)drawLineFrom:(CGPoint)startPoint
                 to:(CGPoint)endPoint;

-(void)drawLines:(NSArray *)pointArray;

@end
