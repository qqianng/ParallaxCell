//
//  tableVC.m
//  Demo
//
//  Created by new on 16/11/16.
//  Copyright © 2016年 it.sozi. All rights reserved.
//

#import "CZTableVC.h"
#import "CZCell.h"

@interface CZTableVC ()
@end

@implementation CZTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationController.navigationBarHidden = YES;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CZCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CZCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CZCell" owner:nil options:nil].lastObject;
    }
    cell.bgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.row%3+1]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CZCellH;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [[NSNotificationCenter defaultCenter] postNotificationName:CZTableVCTableViewDidScrollNotification object:nil];
}


@end
