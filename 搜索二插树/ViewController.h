//
//  ViewController.h
//  搜索二插树
//
//  Created by 沈 晨豪 on 13-8-3.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCHBinarySearchTree;
@interface ViewController : UIViewController
{
    SCHBinarySearchTree *_tree;
}


- (IBAction)showButton:(id)sender;

- (IBAction)preOrderButton:(id)sender;

- (IBAction)inOrderButton:(id)sender;

- (IBAction)postOrderButton:(id)sender;
@end
