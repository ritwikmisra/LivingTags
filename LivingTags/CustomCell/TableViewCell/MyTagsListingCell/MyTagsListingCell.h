//
//  MyTagsListingCell.h
//  LivingTags
//
//  Created by appsbeetech on 05/11/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>
static CGFloat const kBounceValue = 10.0f;

@protocol DeleteTagsProtocol <NSObject>

-(void)deleteTags:(id)sender;
-(void)viewQRCode:(id)sender;

@end

@interface MyTagsListingCell : UITableViewCell<UIGestureRecognizerDelegate>

@property(nonatomic,strong)IBOutlet UILabel *lblName;
@property(nonatomic,strong)IBOutlet UILabel *lblTiming;
@property(nonatomic,strong)IBOutlet UILabel *lblTagType;
@property(nonatomic,strong)IBOutlet UILabel *lblTagViews;
@property(nonatomic,strong)IBOutlet UILabel *lblTagComments;
@property(nonatomic,strong)IBOutlet UILabel *lblDiskSpace;


@property(nonatomic,strong)IBOutlet UIImageView *imgPerson;
@property(nonatomic,strong)IBOutlet UIImageView *imgTagType;
@property(nonatomic,strong)IBOutlet UIImageView *imgBottom;
@property(nonatomic,strong)IBOutlet UIButton *btnPreviewOnImage;
@property(nonatomic,strong)IBOutlet UIButton *btnPreviewOnName;
@property(nonatomic,strong)IBOutlet UIActivityIndicatorView *actMyTags;
@property (nonatomic, weak) id <DeleteTagsProtocol> delegate;


@property(nonatomic,strong)IBOutlet UIButton *btnEdit;

@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic, assign) CGPoint panStartPoint;
@property (nonatomic, assign) CGFloat startingRightLayoutConstraintConstant;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *contentViewRightConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *contentViewLeftConstraint;
@property (nonatomic, strong) IBOutlet UIView *myForegroundContentView;

@property (nonatomic, weak) IBOutlet UIButton *deleteTextBtn;
@property(nonatomic,strong)IBOutlet UIView *vwDeleteButton;


@end
