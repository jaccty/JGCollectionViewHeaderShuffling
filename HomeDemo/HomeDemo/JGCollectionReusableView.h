//
//  JGCollectionReusableView.h
//  HomeDemo
//
//  Created by 郭军 on 2017/3/13.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *SVHeight;

@property (weak, nonatomic) IBOutlet UIView *SV;

@property (weak, nonatomic) IBOutlet UIView *headerV;


@end
