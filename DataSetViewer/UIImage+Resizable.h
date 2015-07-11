//
//  UIImage+Resizable.h
//  DataSetViewer
//
//  Created by Guillermo Zafra on 11/07/15.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resizable)

- (UIImage *)resizedImageWithWidth:(CGFloat)resizedWidth height:(CGFloat)resizedHeight;

@end
