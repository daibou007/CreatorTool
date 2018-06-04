//
//  MasterViewController.m
//  CreatorTool
//
//  Created by 杨朋亮 on 31/5/18.
//  Copyright © 2018年 杨朋亮. All rights reserved.
//

#import "MasterViewController.h"
#import "RaTreeModel.h"
#import "RATreeView.h"
#import "RaTreeViewCell.h"

#import "YesNoPoViewController.h"

@interface MasterViewController () <RATreeViewDelegate,RATreeViewDataSource>

@property NSMutableArray *objects;
@property NSArray *names;
@property (nonatomic ,strong) RATreeView *raTreeView;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.names = @[@"YES,NO,PO",@"跳板",@"随机输入",@"挑战概念",@"主要观点",@"定义问题",@"剔除错误",@"合并",@"要求",@"评价"];
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;

//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    
    self.raTreeView = [[RATreeView alloc] initWithFrame:self.view.frame];
    self.raTreeView.delegate = self;
    self.raTreeView.dataSource = self;
    
    [self.raTreeView registerNib:[UINib nibWithNibName:@"RaTreeViewCell" bundle:nil] forCellReuseIdentifier:@"RaTreeViewCell"];
    self.raTreeView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.raTreeView];

    [self setData];
    
    [self.raTreeView reloadData];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//加载数据
- (void)setData {
    
    self.objects = [[NSMutableArray alloc] init];
    
    //宝鸡市 (四层)
    RaTreeModel *zijingcun = [RaTreeModel dataObjectWithName:@"紫荆村" children:nil];
    
    RaTreeModel *chengcunzheng = [RaTreeModel dataObjectWithName:@"陈村镇" children:@[zijingcun]];
    
    RaTreeModel *fengxiang = [RaTreeModel dataObjectWithName:@"凤翔县" children:@[chengcunzheng]];
    RaTreeModel *qishan = [RaTreeModel dataObjectWithName:@"岐山县" children:nil];
    RaTreeModel *baoji = [RaTreeModel dataObjectWithName:@"宝鸡市" children:@[fengxiang,qishan]];
    
    //西安市
    RaTreeModel *yantaqu = [RaTreeModel dataObjectWithName:@"雁塔区" children:nil];
    RaTreeModel *xinchengqu = [RaTreeModel dataObjectWithName:@"新城区" children:nil];
    
    RaTreeModel *xian = [RaTreeModel dataObjectWithName:@"西安" children:@[yantaqu,xinchengqu]];
    
    RaTreeModel *shanxi = [RaTreeModel dataObjectWithName:@"陕西" children:@[baoji,xian]];
    
    [self.objects addObject:shanxi];
}
#pragma mark -----------delegate

//返回行高
- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item {
    
    return 50;
}

//将要展开
- (void)treeView:(RATreeView *)treeView willExpandRowForItem:(id)item {
    
    RaTreeViewCell *cell = (RaTreeViewCell *)[treeView cellForItem:item];
    cell.iconView.image = [UIImage imageNamed:@"arrow_down"];
    
}
//将要收缩
- (void)treeView:(RATreeView *)treeView willCollapseRowForItem:(id)item {
    
    RaTreeViewCell *cell = (RaTreeViewCell *)[treeView cellForItem:item];
    cell.iconView.image = [UIImage imageNamed:@"arrow"];
    
}

//已经展开
- (void)treeView:(RATreeView *)treeView didExpandRowForItem:(id)item {
    
    
    NSLog(@"已经展开了");
}
//已经收缩
- (void)treeView:(RATreeView *)treeView didCollapseRowForItem:(id)item {
    
    NSLog(@"已经收缩了");
}

//返回cell
- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item {
    
    
    
    //获取cell
    RaTreeViewCell *cell = [treeView dequeueReusableCellWithIdentifier:@"RaTreeViewCell"];
    cell.iconView.image = [UIImage imageNamed:@"arrow"];
    //当前item
    RaTreeModel *model = item;
    
    //当前层级
    NSInteger level = [treeView levelForCellForItem:item];
    
    //赋值
    [cell setCellBasicInfoWith:model.name level:level children:model.children.count];
    
    UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(cellLongPress:)];
    
    [cell addGestureRecognizer:longPressGesture];
    
    return cell;
    
}

/**
 *  必须实现
 *
 *  @param treeView treeView
 *  @param item    节点对应的item
 *
 *  @return  每一节点对应的个数
 */
- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item
{
    RaTreeModel *model = item;
    
    if (item == nil) {
        
        return self.objects.count;
    }
    
    return model.children.count;
}
/**
 *必须实现的dataSource方法
 *
 *  @param treeView treeView
 *  @param index    子节点的索引
 *  @param item     子节点索引对应的item
 *
 *  @return 返回 节点对应的item
 */
- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item {
    
    RaTreeModel *model = item;
    if (item==nil) {
        
        return self.objects[index];
    }
    
    return model.children[index];
}


//cell的点击方法
- (void)treeView:(RATreeView *)treeView didSelectRowForItem:(id)item {
    
    //获取当前的层
    NSInteger level = [treeView levelForCellForItem:item];
    
    //当前点击的model
    RaTreeModel *model = item;
    
    NSLog(@"点击的是第%ld层,name=%@",level,model.name);
    
}

//单元格是否可以编辑 默认是YES
- (BOOL)treeView:(RATreeView *)treeView canEditRowForItem:(id)item {
    
    return YES;
}

//编辑要实现的方法
- (void)treeView:(RATreeView *)treeView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowForItem:(id)item {
    
    NSLog(@"编辑了实现的方法");
    
    
}

- (void)cellLongPress:(UIGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        UITableViewCell *cell = (UITableViewCell *)recognizer.view;
        [cell becomeFirstResponder];


        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setTargetRect:cell.frame inView:cell.superview];
        [menu setMenuItems:[self creatUIMenuItems]];
        [menu setMenuVisible:YES animated:YES];

    }
}

- (void)handleCellAction:(id)sender{
    NSLog(@"handle copy cell");
    YesNoPoViewController *vtr = [[YesNoPoViewController alloc] init];
    vtr.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vtr animated:YES];
}

- (NSArray*)creatUIMenuItems{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSString *str in self.names) {
        UIMenuItem *menuItem = [[UIMenuItem alloc] initWithTitle:str action:@selector(handleCellAction:)];
        [array addObject:menuItem];
    }
    return array;
}



@end
