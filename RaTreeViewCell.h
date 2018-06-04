//
//  RaTreeViewCell.h
//  CreatorTool
//
//  Created by 杨朋亮 on 1/6/18.
//  Copyright © 2018年 杨朋亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RaTreeViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconView;//图标

@property (weak, nonatomic) IBOutlet UILabel *titleLable;//标题

//赋值
- (void)setCellBasicInfoWith:(NSString *)title level:(NSInteger)level children:(NSInteger )children;


@end
