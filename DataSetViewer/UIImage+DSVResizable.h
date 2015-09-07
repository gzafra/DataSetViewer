//
//  UIImage+Resizable.h
//  DataSetViewer
//
//  Created by Guillermo Zafra on 12/07/15.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DSVResizable)

- (UIImage*)imageScaledToSize:(CGSize)newSize;

@end
