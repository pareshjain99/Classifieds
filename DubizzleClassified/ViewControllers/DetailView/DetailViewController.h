//
//  DetailViewController.h
//  DubizzleClassified
//
//  Created by PareshJain on 12/20/19.
//  Copyright © 2019 dubizzle. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ClassifiedDataModel;

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *fullImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property ClassifiedDataModel *selectedClassifiedModel;

@end

NS_ASSUME_NONNULL_END
