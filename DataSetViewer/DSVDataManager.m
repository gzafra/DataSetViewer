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
#import "Reachability.h"
#import "DSVDataParsingOptions.h"

#define kBaseUrl @"https://docs.google.com/spreadsheet/ccc?key=13gEAP1RIpspYY8qNRmS3W3ffdNrb-fueB-qjc2asRpo&single=true&gid=0&output=csv"
#define kCacheDurationInMinutes 60
#define kKeyLastUpdate @"lastUpdate"
#define kKeyStoredData @"storedData"

typedef enum : NSUInteger {
    DSVDataManagerCacheNone = 0,
    DSVDataManagerCacheOnlyImages,
    DSVDataManagerCacheAll,
} DSVDataManagerCacheMode;


typedef enum : NSUInteger {
    EUnreachable,
    EReachableWifi,
    EReachableWWAN,
} DSVReachabilityType;

@interface DSVDataManager()

@property (nonatomic, strong) NSMutableArray *dataCache;
@property (nonatomic, assign) DSVDataManagerCacheMode cacheMode;
@property (nonatomic, assign) NSTimeInterval lastTimeUpdated;
@property (nonatomic, assign) NSUInteger imagesToLoad;
@property (nonatomic) DSVReachabilityType reachability;

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
        _cacheMode = DSVDataManagerCacheOnlyImages; // Default cache mode
        
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if (status == AFNetworkReachabilityStatusNotReachable) {
                // Not reachable
                self.reachability = EUnreachable;
            } else {
                if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
                    // On wifi
                    self.reachability = EReachableWifi;
                }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
                    // On WWAN
                    self.reachability = EReachableWWAN;
                }else{
                    self.reachability = EUnreachable;
                }
            }
        }];
        
        [self loadData];
    }
    return self;
}

#pragma mark - Loading

- (void)loadRemoteData{
    if (self.cacheMode == DSVDataManagerCacheAll && [self shouldLoadFromCache]) {
        return;
    }
    
    NSURL *url = [NSURL URLWithString:kBaseUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    __weak typeof(self) weakSelf = self;
    [operation  setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        [weakSelf parseCSVDataFromString:operation.responseString];
        [weakSelf.delegate dataFinishedLoading:weakSelf.dataCache];
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"error: %@",  operation.responseString);
              // TODO: Send some info about why?
              [weakSelf.delegate dataFailedToLoad];
          }
     ];
    [operation start];
}

- (void)parseCSVDataFromString:(NSString*)csvString{
    NSArray *array = [csvString CSVComponents];
    
    [self.dataCache removeAllObjects];
    
    NSUInteger idx = 0;
    NSUInteger imagesNotFromCache = 0;
    for (NSArray *row in array) {
        if (idx > 0) {
            if (row.count == 3) {
                DSVDataSet *dataSet = [[DSVDataSet alloc] initWithTitle:[row objectAtIndex:0]
                                                               imageUrl:[row objectAtIndex:2]
                                                            description:[row objectAtIndex:1]];

                
                
                [self.dataCache addObject:dataSet];
            }else{
                NSLog(@"ERROR: Row at index %ld has more than 3 items. Skipping",(unsigned long)idx);
            }
        }
        idx++;
    }
    
    if (imagesNotFromCache > 0) {
        self.imagesToLoad = imagesNotFromCache;
    }else{
        // Everything already loaded, save data
        [self saveData];
    }
}

- (NSArray*)remoteData{
    return self.dataCache;
}



- (BOOL)shouldLoadFromCache{
    NSCalendar *c = [NSCalendar currentCalendar];
    NSDate *d1 = [NSDate date];
    
    CGFloat lastTimeStamp = [[[NSUserDefaults standardUserDefaults] objectForKey:kKeyLastUpdate] floatValue];
    NSDate *d2 = [NSDate dateWithTimeIntervalSince1970:lastTimeStamp];//2012-06-22
    NSDateComponents *components = [c components:NSCalendarUnitMinute fromDate:d2 toDate:d1 options:0];
    NSInteger diff = components.minute;
    
    if (diff>kCacheDurationInMinutes) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]] forKey:kKeyLastUpdate];
        [[NSUserDefaults standardUserDefaults]  synchronize];
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - Storage

- (void)setImagesToLoad:(NSUInteger)imagesToLoad{
    if (_imagesToLoad != imagesToLoad) {
        _imagesToLoad = imagesToLoad;
        if (imagesToLoad == 0) { // When all images have been loaded, save data to disk
            [self saveData];
        }
    }
}

- (void)saveData{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.dataCache];
    [prefs setObject:myEncodedObject forKey:kKeyStoredData];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)loadData{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSArray *loadedData = (NSArray*)[NSKeyedUnarchiver unarchiveObjectWithData:[prefs objectForKey:kKeyStoredData]];
    self.dataCache = [NSMutableArray arrayWithArray:loadedData];
}

#pragma mark - Reachability

- (void)setReachability:(DSVReachabilityType)reachability{
    if (_reachability != reachability) {
        
        _reachability = reachability;
        if (_reachability == EUnreachable) {
            [self.delegate notConnected];
        }
    }
}

@end
