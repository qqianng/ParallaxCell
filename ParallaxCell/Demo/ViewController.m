//
//  ViewController.m
//  Demo
//
//  Created by new on 16/11/16.
//  Copyright © 2016年 it.sozi. All rights reserved.
//

#import "ViewController.h"
#import "CZTableVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CZTableVC *tableVC = [[CZTableVC alloc] init];
    [self.navigationController pushViewController:tableVC animated:NO];
}


@end
