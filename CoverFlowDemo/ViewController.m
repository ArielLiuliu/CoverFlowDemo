//
//  ViewController.m
//  CoverFlowDemo
//
//  Created by lx on 2018/1/6.
//  Copyright © 2018年 lx. All rights reserved.
//

#import "ViewController.h"

#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.translucent = NO;//导航栏不透明
    self.title = @"封面展示";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(20, 20, 200, 40);
    [self.view addSubview:btn];
    [btn setTitle:@"切换模式" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    //创建coverflower
    self.myCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height-200)];
    self.myCarousel.backgroundColor = [UIColor yellowColor];
    self.myCarousel.delegate = self;
    self.myCarousel.dataSource = self;
    self.myCarousel.type = iCarouselTypeCoverFlow;//设置样式为 封面展示
    [self.view addSubview:self.myCarousel];
}

//切换模式
- (void)btnClicked
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择类型" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"直线", @"圆圈", @"反向圆圈", @"圆桶", @"反向圆桶", @"轮子", @"反向轮子", @"封面展示", @"封面展示2", @"时间机器", @"反向时间机器", @"纸牌", nil];
    [sheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    /**
     iCarouselTypeLinear = 0,//直线
     iCarouselTypeRotary,//圆圈
     iCarouselTypeInvertedRotary,//反向圆圈
     iCarouselTypeCylinder,//圆桶
     iCarouselTypeInvertedCylinder,//反向圆桶
     iCarouselTypeCoverFlow,//封面展示
     iCarouselTypeCoverFlow2,//封面展示2
     iCarouselTypeCustom//纸牌
     */
    
    /**
     iCarouselTypeLinear = 0,//直线
     iCarouselTypeRotary,//圆圈
     iCarouselTypeInvertedRotary,//反向圆圈
     iCarouselTypeCylinder,//圆桶
     iCarouselTypeInvertedCylinder,//反向圆桶
     iCarouselTypeWheel,//轮子
     iCarouselTypeInvertedWheel,//反向轮子
     iCarouselTypeCoverFlow,//封面展示
     iCarouselTypeCoverFlow2,//封面展示2
     iCarouselTypeTimeMachine,//时间机器
     iCarouselTypeInvertedTimeMachine,//反向时间机器
     iCarouselTypeCustom//纸牌
     */
    
    self.myCarousel.type = (int)buttonIndex;
    self.title = [actionSheet buttonTitleAtIndex:buttonIndex];
}

#pragma mark - iCarouselDataSource
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return 20;//轮播项总个数
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    if (view == nil) {//创建可重用视图
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth*0.56, kScreenHeight*0.45)];
    }
    
    //设置重用视图内容
    UIImageView *myView = (UIImageView*)view;
    myView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",(int)index]];
    
    return view;
}

#pragma  mark - iCarouselDelegate
- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform {
    transform = CATransform3DRotate(transform, M_PI/8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.myCarousel.itemWidth);
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    switch (option) {
        case iCarouselOptionWrap: {
            //normally you would hard-code this to YES or NO
            return YES;
        }
        case iCarouselOptionSpacing: {
            //add a bit of spacing between the item views
            return value * 1.05f;
        }
        case iCarouselOptionFadeMax: {
            if (self.myCarousel.type == iCarouselTypeCustom)  {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        default:
            return value;
    }
    
    return value;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"当前选中索引：%d", (int)index);
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel {
   
    //使当前展示项完全显示，更改其他项不透明度
    NSArray *visibleViews = carousel.visibleItemViews;//获取所有可见轮播项
    for (UIView *vv in visibleViews) {
        vv.alpha = 0.4;
    }
    UIView *currentView = carousel.currentItemView;//获取当前展示项
    currentView.alpha = 1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
