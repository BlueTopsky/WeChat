//
//  UIImage+SKYExtension.h
//  MyCategory
//
//  Created by Topsky on 16/9/26.
//  Copyright © 2016年 Topsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SKYExtension)

//根据颜色生成纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color;

//UIView转化为UIImage
+ (UIImage *)imageFromView:(UIView *)view;

//将两个图片生成一张图片
+ (UIImage *)mergeImage:(UIImage *)firstImage withImage:(UIImage *)secondImage;

//改变图片的颜色
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;

//取图片某一像素的颜色
- (UIColor *)colorAtPixel:(CGPoint)point;

//获得灰度图
- (UIImage *)convertToGrayImage;

#pragma mark - rotate

//纠正图片的方向
- (UIImage *)fixOrientation;

//按给定的方向旋转图片
- (UIImage *)rotate:(UIImageOrientation)orient;

//垂直翻转
- (UIImage *)flipVertical;

//水平翻转
- (UIImage *)flipHorizontal;

//将图片旋转degrees角度
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

//将图片旋转radians弧度
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;

#pragma mark - gif

//用一个Gif生成UIImage，传入一个GIFData
+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)theData;

//用一个Gif生成UIImage，传入一个GIF路径
+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)theURL;

@end
