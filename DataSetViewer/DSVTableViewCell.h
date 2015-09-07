//
//  DSVTableViewCell.h
//  DataSetViewer
//
//  Created by Guillermo Zafra on 10/07/2015.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSVImageLoaderDelegate.h"

@interface DSVTableViewCell : UITableViewCell <DSVImageLoaderDelegate>

@property (nonatomic, strong) UILabel *myTextLabel;
@property (nonatomic, weak) IBOutlet UIImageView *myImageView;
@property (nonatomic, strong) NSString *myCellId;



@end
