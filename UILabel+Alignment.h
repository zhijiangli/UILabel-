//
//  UILabel+Alignment.h
//  OCTest
//
//  Created by 小黎 on 2018/4/14.
//  Copyright © 2018年 小黎. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ZJAlignment) {
    top           = 1, // 上左对齐
    topCenter     = 2, // 上中对齐
    topRight      = 3, // 上右对齐
    topJustify    = 4, // 上两段对齐
    bottom        = 5, // 下左对齐
    bottomCenter  = 6, // 下中对齐
    bottomRight   = 7, // 下右对齐
    bottomJustify = 8, // 下两段对齐
    centerJustify = 9, // 居中两段对齐
};
@interface UILabel (Alignment)
/** 对齐方式为富文本，需要先给text赋值，才能有效*/
@property(nonatomic,assign) ZJAlignment alignment;
@end
