//
//  DSVImageLoaderDelegate.h
//  DataSetViewer
//
//  Created by Guillermo Zafra on 07/09/15.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DSVImageLoaderDelegate <NSObject>

- (void)updateWithImage:(UIImage*)image;

@end
