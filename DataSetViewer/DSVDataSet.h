//
//  DSVDataSet.h
//  DataSetViewer
//
//  Created by Guillermo Zafra on 10/07/2015.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSVImageLoader.h"

@interface DSVDataSet : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *additionalDescription;
@property (nonatomic, strong) NSURL *imageUrl;
@property (nonatomic, strong) DSVImageLoader *imageLoader;


- (instancetype)initWithTitle:(NSString*)title imageUrl:(NSString*)url description:(NSString*)description;

/// Compares two DSVDataSet objects. Comparing by Title as there is no other safe id
- (BOOL)isEqual:(DSVDataSet*)data;

@end
