//
//  UIImage+CustomImage.m
//  SuYunProject
//
//  Created by iBlock on 14/12/31.
//  Copyright (c) 2014年 iBlock. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>
#import "UIImage+CustomImage.h"

@implementation UIImage (CustomImage)

+ (UIImage *)imageNamedFrombundle:(NSString *)name
{
    return [UIImage imageNamed:name];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur
{
    //模糊度,
    if ((blur < 0.1f) || (blur > 2.0f)) {
        blur = 0.5f;
    }

    // boxSize必须大于0
    int boxSize = (int)(blur * 100);

    boxSize -= (boxSize % 2) + 1;

    NSLog(@"boxSize:%i", boxSize);

    //图像处理

    CGImageRef img = image.CGImage;

    //需要引入#import <Accelerate/Accelerate.h>

    /*

     This document describes the Accelerate Framework, which contains C APIs for vector and matrix math, digital signal
     processing, large number handling, and image processing.

     本文档介绍了Accelerate
     Framework，其中包含C语言应用程序接口（API）的向量和矩阵数学，数字信号处理，大量处理和图像处理。

     */

    //图像缓存,输入缓存，输出缓存

    vImage_Buffer inBuffer, outBuffer;

    vImage_Error error;

    //像素缓存

    void *pixelBuffer;

    //数据源提供者，Defines an opaque type that supplies Quartz with data.

    CGDataProviderRef inProvider = CGImageGetDataProvider(img);

    // provider’s data.

    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);

    //宽，高，字节/行，data

    inBuffer.width = CGImageGetWidth(img);

    inBuffer.height = CGImageGetHeight(img);

    inBuffer.rowBytes = CGImageGetBytesPerRow(img);

    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);

    //像数缓存，字节行*图片高

    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));

    outBuffer.data = pixelBuffer;

    outBuffer.width = CGImageGetWidth(img);

    outBuffer.height = CGImageGetHeight(img);

    outBuffer.rowBytes = CGImageGetBytesPerRow(img);

    // 第三个中间的缓存区,抗锯齿的效果

    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));

    vImage_Buffer outBuffer2;

    outBuffer2.data = pixelBuffer2;

    outBuffer2.width = CGImageGetWidth(img);

    outBuffer2.height = CGImageGetHeight(img);

    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);

    // Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of
    // a box filter.

    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);

    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);

    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);

    if (error) {

        NSLog(@"error from convolution %ld", error);
    }

    //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));

    //颜色空间DeviceRGB

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8

    CGContextRef ctx = CGBitmapContextCreate(

        outBuffer.data,

        outBuffer.width,

        outBuffer.height,

        8,

        outBuffer.rowBytes,

        colorSpace,

        CGImageGetBitmapInfo(image.CGImage));

    //根据上下文，处理过的图片，重新组件

    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);

    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];

    // clean up

    CGContextRelease(ctx);

    CGColorSpaceRelease(colorSpace);

    free(pixelBuffer);

    free(pixelBuffer2);

    CFRelease(inBitmapData);

    CGColorSpaceRelease(colorSpace);

    CGImageRelease(imageRef);

    return returnImage;
}

- (UIImage *) imageCompressForSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [self drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

- (UIImage *) imageCompressForWidth:(CGFloat)defineWidth{
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

@end
