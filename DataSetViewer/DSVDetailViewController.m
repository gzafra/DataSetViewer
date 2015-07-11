//
//  DSVDetailViewController.m
//  DataSetViewer
//
//  Created by Guillermo Zafra on 11/07/15.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import "DSVDetailViewController.h"

@interface DSVDetailViewController ()

@end

@implementation DSVDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = self.titleDetail;
    if (self.imageDetail) {
        self.imageView.image = self.imageDetail;
    }else{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"default" ofType:@"png"];
        [self.imageView setImage:[UIImage imageWithContentsOfFile:path]];
    }
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.textView.text = self.descriptionDetail;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
