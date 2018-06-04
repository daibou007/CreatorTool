//
//  RaTreeViewCell.m
//  CreatorTool
//
//  Created by 杨朋亮 on 1/6/18.
//  Copyright © 2018年 杨朋亮. All rights reserved.
//

#import "RaTreeViewCell.h"

#import "RaTreeViewCell.h"

@interface RaTreeViewCell ()


@end

@implementation RaTreeViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}


- (void)setCellBasicInfoWith:(NSString *)title level:(NSInteger)level children:(NSInteger )children{
    
    //有自孩子时显示图标
    if (children==0) {
        self.iconView.hidden = YES;

    }
    else { //否则不显示
        self.iconView.hidden = NO;
    }
    
    self.titleLable.text = title;
    self.iconView.image = [UIImage imageNamed:@"arrow"];
    
    
    //每一层的布局
    CGFloat left = 10+level*30;
    
    //头像的位置
    CGRect  iconViewFrame = self.iconView.frame;
    
    iconViewFrame.origin.x = left;
    
    self.iconView.frame = iconViewFrame;
    
    //title的位置
    CGRect titleFrame = self.titleLable.frame;
    
    titleFrame.origin.x = 40+left;
    
    self.titleLable.frame = titleFrame;
    
}

@end

