//
//  DSVImageLoader.h
//  DataSetViewer
//
//  Created by Guillermo Zafra on 04/09/2015.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>
#import "DSVImageLoaderDelegate.h"

typedef enum : NSUInteger {
    DSVImageLoaderStateNotLoaded,
    DSVImageLoaderStateLoading,
    DSVImageLoaderStateLoaded,
} DSVImageLoaderStateType;

@interface DSVImageLoader : NSObject

@property (nonatomic, assign) DSVImageLoaderStateType state;
@property (nonatomic, strong) UIImage *cachedImage;

- (instancetype)initWithUrl:(NSURL*)imageUrl;
- (void)loadImageForSender:(id<DSVImageLoaderDelegate>)sender;
- (void)cancelRequest;

@end
