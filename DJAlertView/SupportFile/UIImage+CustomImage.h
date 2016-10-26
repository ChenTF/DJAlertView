//
//  UIImage+CustomImage.h
//  SuYunProject
//
//  Created by iBlock on 14/12/31.
//  Copyright (c) 2014年 iBlock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CustomImage)

/**
 *  目前该方法是直接从Assets.xcassets文件夹中获取文件
 *
 *  @param name 图片名称
 *
 *  @return image
 */
+ (UIImage *)imageNamedFrombundle:(NSString *)name;

/**
 *  根据Color和大小生成图片
 *
 *  @param color 填充颜色
 *  @param size  大小
 *
 *  @return image
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

/**
 *  按指定大小等比例压缩视图
 *
 *  @param size 压缩大小
 *
 *  @return 返回压缩后的图片
 */
- (UIImage *) imageCompressForSize:(CGSize)size;

/**
 *  按指定宽度等比例压缩图片
 *
 *  @param defineWidth 宽度
 *
 *  @return 返回压缩后的图片
 */
- (UIImage *) imageCompressForWidth:(CGFloat)defineWidth;

@end
