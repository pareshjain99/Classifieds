//
//  DetailViewController.m
//  DubizzleClassified
//
//  Created by PareshJain on 12/20/19.
//  Copyright © 2019 dubizzle. All rights reserved.
//

#import "DetailViewController.h"
#import <SDWebImage/SDWebImage.h>
#import <DubizzleClassified-Swift.h>

@interface DetailViewController ()

@end

@implementation DetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _nameLabel.text = _selectedClassifiedModel.name;
    _priceLabel.text = _selectedClassifiedModel.price;
    _timeLabel.text = _selectedClassifiedModel.created_at;
    [_fullImageView sd_setImageWithURL:[NSURL URLWithString:_selectedClassifiedModel.image_urls]
    placeholderImage:[UIImage imageNamed:@"item_placeholder.jpg"]];

    [self customizeNavigationBar];
}


- (void) customizeNavigationBar {
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = _selectedClassifiedModel.name;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:167/255 green:40/255 blue:51/255 alpha:1.0];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
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
