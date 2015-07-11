//
//  UIImage+Resizable.m
//  DataSetViewer
//
//  Created by Guillermo Zafra on 12/07/15.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import "UIImage+Resizable.h"

@implementation UIImage (Resizable)

- (UIImage*)imageScaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext( newSize );
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
