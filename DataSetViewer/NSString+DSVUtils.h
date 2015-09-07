//
//  NSString+DSVUtils.h
//  DataSetViewer
//
//  Created by Guillermo Zafra on 11/07/15.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DSVUtils)

@property (nonatomic, readonly) NSString *stringByRemovingHtmlTags;
@property (nonatomic, readonly) NSString *stringByRemovingQuotes;

@end
