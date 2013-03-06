//
//  MenuViewController.m
//  MyWays-iOS
//
//  Created by Mathieu Cordebard on 27/12/12.
//  Copyright (c) 2012 Mathieu Cordebard. All rights reserved.
//

#import "MenuViewController.h"
#import "MapViewController.h"
#import "Utils.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (weak, nonatomic) IBOutlet UIView* headerView;
@property (strong, nonatomic) MapViewController* mapViewController;

@end

@implementation MenuViewController

- (void) viewDidLoad {
    // Configure headerView background
    self.headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navBar_background_dark.png"]];
    
}

- (void) didReceiveMemoryWarning {
    
}

#pragma mark - tableViewDatasource implementation
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MENUCELL"];
    
    cell.backgroundView = [[UIView alloc]initWithFrame:cell.bounds];
    cell.backgroundView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"menuCell_background.png"]];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:15];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    NSInteger row = indexPath.row;
    
        switch (row) {
            case 0:
                cell.textLabel.text = @"Create a new way";
                break;
        }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //self.mapViewController = [[MapViewController alloc] init];
    //[self presentViewController:self.mapViewController];
}


@end
