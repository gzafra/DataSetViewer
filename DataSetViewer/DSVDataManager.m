//
//  DSVDataManager.m
//  DataSetViewer
//
//  Created by Guillermo Zafra on 10/07/2015.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import "DSVDataManager.h"
#import "AFNetworking.h"
#import "CHCSVParser.h"

@interface DSVDataManager()

@property (nonatomic, strong) NSMutableArray *dataCache;

@end

@implementation DSVDataManager

#pragma mark - LifeCycle

+ (instancetype)sharedManager {
    static DSVDataManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc]init];
    });
    
    return _sharedManager;
}

- (instancetype)init{
    if (self = [super init]) {
        _dataCache = [NSMutableArray new];
    }
    return self;
}

#pragma mark - Loading

- (void)loadRemoteData{

    NSURL *url = [NSURL URLWithString:@"https://docs.google.com/spreadsheets/d/13gEAP1RIpspYY8qNRmS3W3ffdNrb-fueB-qjc2asRpo/export?format=csv&id=KEY&gid=0"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    __weak typeof(self) weakSelf = self;
    [operation  setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"success: %@", operation.responseString);
        [weakSelf parseCSVDataFromString:operation.responseString];
        [self.delegate dataFinishedLoading:weakSelf.dataCache];
        
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"error: %@",  operation.responseString);
              
          }
     ];
    [operation start];
    
}

- (void)parseCSVDataFromString:(NSString*)csvString{
    NSArray *array = [csvString CSVComponents];
    
    for (NSArray *row in array) {
#warning TODO: Log if row has a different number of items, corrupt register
        if (row.count == 3) {
            DSVDataSet *dataSet = [[DSVDataSet alloc] initWithTitle:[row objectAtIndex:0]
                                                           imageUrl:[row objectAtIndex:1]
                                                        description:[row objectAtIndex:2]];
            [self.dataCache addObject:dataSet];
        }
    }
}

- (NSArray*)remoteData{
    return self.dataCache;
}

@end
