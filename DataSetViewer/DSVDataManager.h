//
//  DSVDataManager.h
//  DataSetViewer
//
//  Created by Guillermo Zafra on 10/07/2015.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSVDataSet.h"

@protocol DSVDataManagerDelegate <NSObject>

- (void)dataFinishedLoading:(NSArray*)dataLoaded;

@end

@interface DSVDataManager : NSObject

+ (instancetype)sharedManager;

- (void)loadRemoteData;

@property (nonatomic, readonly) NSArray *remoteData;
@property (nonatomic, weak) id<DSVDataManagerDelegate> delegate;

@end
