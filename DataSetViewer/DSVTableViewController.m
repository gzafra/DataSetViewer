//
//  DSVTableViewController.m
//  DataSetViewer
//
//  Created by Guillermo Zafra on 10/07/2015.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import "DSVTableViewController.h"
#import "DSVTableViewCell.h"

@interface DSVTableViewController ()

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

//@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, weak) DSVDataManager *dataManager;

@end

@implementation DSVTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DSVTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DataSetCell"];
    
    self.dataManager = [DSVDataManager sharedManager];
    self.dataManager.delegate = self;
    [self.dataManager loadRemoteData];

    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor grayColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(loadRemoteData)
                  forControlEvents:UIControlEventValueChanged];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self showLoadingWithMessage:NSLocalizedString(@"LoadingData", @"Loading data remotely...")];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadRemoteData{
    [self.dataManager loadRemoteData];
}

- (void)showLoadingWithMessage:(NSString*)messageString{
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIView *loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    loadingView.backgroundColor = [UIColor lightGrayColor];
    [loadingView addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake(loadingView.frame.size.width*0.2f, loadingView.frame.size.height/2);
    
    UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(loadingView.frame.size.width*0.3f,
                                                                loadingView.frame.size.height*0.3f,
                                                                loadingView.frame.size.width * 0.7f,
                                                                20)];
    UIFont *font = label.font;
    label.font = [UIFont fontWithName:font.fontName size:14.0f];
    label.text = messageString;
    label.textColor = [UIColor whiteColor];
    [loadingView addSubview:label];
    
    self.tableView.tableHeaderView = loadingView;
    [self.activityIndicator startAnimating];
}

- (void)hideLoadingView{
    [self.activityIndicator stopAnimating];
    [self.activityIndicator removeFromSuperview];
    self.tableView.tableHeaderView = nil;
}

- (void)showErrorViewWithMessage:(NSString*)messageString{
    UIView *errorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    errorView.backgroundColor = [UIColor colorWithRed:1.0f green:0.2f blue:0.0f alpha:1.0f];

    UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(0,
                                                                errorView.frame.size.height*0.3f,
                                                                errorView.frame.size.width,
                                                                20)];
    label.textAlignment = NSTextAlignmentCenter;
    UIFont *font = label.font;
    label.font = [UIFont fontWithName:font.fontName size:14.0f];
    label.text = messageString;
    label.textColor = [UIColor whiteColor];
    [errorView addSubview:label];
    
    self.tableView.tableHeaderView = errorView;
    UIView *tableHeader = self.tableView.tableHeaderView;
    tableHeader.center = CGPointMake(tableHeader.center.x,-50);
    tableHeader.alpha = 0.0f;
    
    // Show animated
    [UIView animateWithDuration:0.5f delay:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        tableHeader.center = CGPointMake(tableHeader.center.x,50);
        tableHeader.alpha = 1.0f;
    } completion:^(BOOL finished) {}];
    
    // Hide animated after delay
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5f animations:^{
            tableHeader.center = CGPointMake(tableHeader.center.x, -50);
            tableHeader.alpha = 0.0f;
        } completion:^(BOOL finished) {
            self.tableView.tableHeaderView =  nil;
        }];
    });
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"DataSetCell";
    
    DSVDataSet *dataSet = [self.dataSource objectAtIndex:indexPath.row];
    
    DSVTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
       cell = [[DSVTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.myTextLabel.text = dataSet.title;
    
    // Update image if already loaded in the model object
    if (dataSet.image) {
       [cell updateWithImage:(UIImage*)dataSet.image];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - DSVDataManagerDelegate

- (void)dataFinishedLoading:(NSArray*)dataLoaded{
    [self.refreshControl endRefreshing];
    [self hideLoadingView];
    
    self.dataSource = dataLoaded;
    [self.tableView reloadData];
}

- (void)imageLoadedForDataSet:(DSVDataSet*)dataSet{
    // Update images from cells that are visible
    
    NSArray *cells = [self.tableView visibleCells];
    NSUInteger dsIndex = [self.dataSource indexOfObject:dataSet];
    for (DSVTableViewCell *cell in cells) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        if (dsIndex == indexPath.row) {
            [cell updateWithImage:(UIImage*)dataSet.image];
        }
    }
}

- (void)dataFailedToLoad{
    [self showErrorViewWithMessage:NSLocalizedString(@"LoadFailed", @"Data failed to load")];
}

@end
