//
//  TreeView.m
//  搜索二插树
//
//  Created by 沈 晨豪 on 13-8-3.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import "TreeView.h"
#import "UIView+line.h"

@implementation TreeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        // Initialization code
        _array = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
  
    // Initialization code
    _array = [[NSMutableArray alloc] init];
}


- (void)addLineFrom:(CGPoint)start to:(CGPoint)end
{
  //  NSLog(@"::::%@ -> %@",NSStringFromCGPoint(start),NSStringFromCGPoint(end));

    
    NSArray *add_array = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:start],[NSValue valueWithCGPoint:end],nil];
    [_array addObject:add_array];
    
  
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    [super drawRect:rect];
    
    UIColor *blue = [UIColor colorWithRed:80.f/255.f
                                    green:150.f/255.f
                                     blue:225.f/255.f
                                    alpha:1];
    
    UIColor *white = [UIColor colorWithRed:1
                                     green:1
                                      blue:1
                                     alpha:1];
//    UIColor *green = [UIColor colorWithRed:41.f/255.f
//                                     green:199.f/255.f
//                                      blue:165.f/255.f
//                                     alpha:1];
    [blue setStroke];//设置线条颜色
    [white setFill]; //设置填充颜色
    
  //  NSLog(@"--- %d",_array.count);
    for (NSArray *array in _array)
    {
        CGPoint start;
        [((NSValue *)[array objectAtIndex:0]) getValue:&start];
        
        CGPoint end;
        [((NSValue *)[array objectAtIndex:1]) getValue:&end];
    //    NSLog(@"%@ -> %@",NSStringFromCGPoint(start),NSStringFromCGPoint(end));
        [self drawLineFrom:start to:end];
        
    }
    
    
}


@end
