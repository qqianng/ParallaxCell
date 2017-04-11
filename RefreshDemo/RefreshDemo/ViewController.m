//
//  ViewController.m
//  RefreshDemo
//
//  Created by new on 17/3/27.
//  Copyright © 2017年 it.sozi. All rights reserved.
//

#import "ViewController.h"
#import "CZRefreshHeader.h"

@interface ViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CZRefreshHeader *refreshHeader = [CZRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    [self.tableView setRefreshHeader:refreshHeader];
    self.tableView.dataSource = self;
}

- (void)refreshData {
    NSLog(@"refreshData");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.refreshHeader endRefreshing];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}


@end
