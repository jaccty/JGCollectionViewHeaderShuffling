//
//  ViewController.m
//  HomeDemo
//
//  Created by 郭军 on 2017/3/13.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import "ViewController.h"
#import "JGCollectionViewCell.h"
#import "JGCollectionReusableView.h"  //头部
#import "WTImageScroll.h"


#define  kColumns 2
#define kDeviceHight [UIScreen mainScreen].bounds.size.height
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define JGMargin 10


@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)NSMutableArray *DataArrM;


@end

static NSString * const JGCollectionCellId = @"JGCollectionCellId";
static NSString *const JGSetHeaderCellId = @"JGSetHeaderCellId";

@implementation ViewController

- (NSMutableArray *)DataArrM {
    if (!_DataArrM) {
        _DataArrM = [NSMutableArray array];
        [_DataArrM addObject:@"1"];
        [_DataArrM addObject:@"1"];
        [_DataArrM addObject:@"1"];
        [_DataArrM addObject:@"1"];
        [_DataArrM addObject:@"1"];
        [_DataArrM addObject:@"1"];
    }
    return _DataArrM;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    //创建collectionView
    [self createCollectionView];
    
}




//创建collectionView
- (void)createCollectionView {
    
    //首先需要创建一个布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //创建cllectionView对象
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
    self.collectionView = collectionView;
    collectionView.contentInset = UIEdgeInsetsMake(64, 0, 59, 0);
    [self.view addSubview:collectionView];
    //设置代理
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor cyanColor];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JGCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:JGCollectionCellId];
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:JGCollectionCellId];
    
    
//    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:JGSetHeaderCellId];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JGCollectionReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:JGSetHeaderCellId];
    
}


#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

//指定有多少个子视图
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.DataArrM.count;
}

//指定子视图
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:JGCollectionCellId forIndexPath:indexPath];
    //返回
    return cell;
}

// 显示表头的数据
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader){
        // JGHeaderView
        JGCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:JGSetHeaderCellId forIndexPath:indexPath];
        
        if (indexPath.section == 0) {
            
            header.SVHeight.constant = 150;
            
            UIView *imageScorll=[WTImageScroll ShowNetWorkImageScrollWithFream:CGRectMake(0, 0, kDeviceWidth, 150) andImageArray:@[@"http://imgstore.cdn.sogou.com/app/a/100540002/457880.jpg",@"http://pic6.huitu.com/res/20130116/84481_20130116142820494200_1.jpg",@"http://img13.poco.cn/mypoco/myphoto/20120828/15/55689209201208281549023849547194135_001.jpg"] andBtnClick:^(NSInteger tagValue) {
                NSLog(@"点击的图片--%@",@(tagValue));
            }];
            
            [header.SV addSubview:imageScorll];
            
        }else {
           header.SVHeight.constant = 0.01;
        }
        
        
        
        return header;
        
    }
    else{
        return nil;
    }
    
//    header.backgroundColor = [UIColor greenColor];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld - %ld",indexPath.section, indexPath.row);
}

// 表头尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
      return CGSizeMake(kDeviceWidth, 200);
    }
    return CGSizeMake(kDeviceWidth, 50);
}



- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}



//返回每个子视图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        CGFloat itemWidth = (kDeviceWidth - (JGMargin * 1.5) * (kColumns + 1) ) / kColumns ;
        return CGSizeMake(itemWidth, 100);
    }else {
        
        CGFloat itemWidth = (kDeviceWidth - (JGMargin * 1.5) * (kColumns + 2) ) / (kColumns + 1) ;
        return CGSizeMake(itemWidth, 100);
    }
    
    
}

//设置每个子视图的缩进
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, (JGMargin * 1.5), 0, (JGMargin * 1.5));
}


//设置子视图上下之间的距离
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return (JGMargin * 1.5);
}

////设置子视图左右之间的距离
//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return kPadding;
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
