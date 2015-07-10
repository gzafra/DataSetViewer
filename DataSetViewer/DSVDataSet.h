//
//  DSVDataSet.h
//  DataSetViewer
//
//  Created by Guillermo Zafra on 10/07/2015.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSVDataSet : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *additionalDescription;

- (instancetype)initWithTitle:(NSString*)title imageUrl:(NSString*)url description:(NSString*)description;

@end
