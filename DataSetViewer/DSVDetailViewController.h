//
//  DSVDetailViewController.h
//  DataSetViewer
//
//  Created by Guillermo Zafra on 11/07/15.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSVDetailViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UITextView *textView;

@property (nonatomic, strong) NSString *titleDetail;
@property (nonatomic, strong) NSString *descriptionDetail;
@property (nonatomic, strong) UIImage *imageDetail;

@end
