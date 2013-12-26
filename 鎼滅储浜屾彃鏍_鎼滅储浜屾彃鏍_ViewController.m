//
//  ViewController.m
//  搜索二插树
//
//  Created by 沈 晨豪 on 13-8-3.
//  Copyright (c) 2013年 sch. All rights reserved.
//

#import "ViewController.h"
#import "SCHBinarySearchTree.h"
@interface ViewController ()

@end

@implementation ViewController


- (IBAction)showButton:(id)sender
{
    [_tree showTree];
}

- (IBAction)preOrderButton:(id)sender
{
    [_tree drawPreOrder];
}

- (IBAction)inOrderButton:(id)sender
{
    [_tree drawInOrder];
}

- (IBAction)postOrderButton:(id)sender
{
    [_tree drawPostOrder];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self)
    {
        _tree = [[SCHBinarySearchTree alloc] initWithValue:10];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
   // _tree.show_view = [[[UIView alloc] initWithFrame:CGRectMake(134,0, 500, 1004)] autorelease];
    //_tree.show_view.backgroundColor = [UIColor whiteColor];
    
  //  [self.view addSubview:_tree.show_view];
    
     _tree.show_view = self.view;
    
    [_tree insertTreeNode:5];
    [_tree insertTreeNode:11];
    [_tree insertTreeNode:18];
    [_tree insertTreeNode:15];
    [_tree insertTreeNode:12];
    [_tree insertTreeNode:7];
    [_tree insertTreeNode:2];
    [_tree insertTreeNode:3];
    [_tree insertTreeNode:9];
    [_tree insertTreeNode:0];
    [_tree insertTreeNode:25];

 
   // [_tree show_view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_tree release], _tree = nil;
    
    [super dealloc];
}
@end
