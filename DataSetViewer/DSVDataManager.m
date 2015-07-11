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

#define kBaseUrl @"https://docs.google.com/spreadsheet/ccc?key=0Aqg9JQbnOwBwdEZFN2JKeldGZGFzUWVrNDBsczZxLUE&single=true&gid=0&output=csv"

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

    NSURL *url = [NSURL URLWithString:kBaseUrl];
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
    [self.dataCache removeAllObjects];
    NSArray *array = [csvString CSVComponents];
    
    NSUInteger idx = 0;
    for (NSArray *row in array) {
        if (idx > 0) {
            if (row.count == 3) {
                DSVDataSet *dataSet = [[DSVDataSet alloc] initWithTitle:[row objectAtIndex:0]
                                                               imageUrl:[row objectAtIndex:2]
                                                            description:[row objectAtIndex:1]];
                [self loadImageWithURL:dataSet.imageUrl sender:dataSet];
                
                [self.dataCache addObject:dataSet];
            }else{
                NSLog(@"Row at index %ld has more than 3 items",(unsigned long)idx);
            }
        }
        idx++;
    }
}

- (NSArray*)remoteData{
    return self.dataCache;
}

- (void)loadImageWithURL:(NSString*)imageUrl sender:(DSVDataSet*)sender{
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:imageUrl]];
    [urlRequest setCachePolicy: NSURLRequestReturnCacheDataElseLoad];
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    
    __weak __typeof(sender) weakSender = sender;
    __weak __typeof(self) weakSelf = self;
    
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        weakSender.image = responseObject;
        [weakSelf.delegate imageLoadedForDataSet:weakSender];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error loading image with URL: %@",imageUrl);
    }];
    [requestOperation start];
}

@end
