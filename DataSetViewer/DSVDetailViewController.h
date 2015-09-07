//
//  DSVDetailViewController.h
//  DataSetViewer
//
//  Created by Guillermo Zafra on 11/07/15.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSVDataSet.h"
#import "DSVImageLoaderDelegate.h"

@interface DSVDetailViewController : UIViewController <DSVImageLoaderDelegate>

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UITextView *textView;

@property (nonatomic, weak) DSVDataSet *dataset;

@end
