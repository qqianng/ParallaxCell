//
//  cell.h
//  Demo
//
//  Created by new on 16/11/16.
//  Copyright © 2016年 it.sozi. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat CZCellH;

extern NSString * const CZTableVCTableViewDidScrollNotification;

@interface CZCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgView;

@end
