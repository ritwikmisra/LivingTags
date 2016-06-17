//
//  SidePanelCell.h
//  LivingTags
//
//  Created by appsbeetech on 12/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SidePanelCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UILabel *lbl;

/////first cell
@property(nonatomic,strong)IBOutlet UIButton *btnLogout;
@property(nonatomic,strong)IBOutlet UILabel *lblName;
@property(nonatomic,strong)IBOutlet UILabel *lblEmail;
@property(nonatomic,strong)IBOutlet UIActivityIndicatorView *actIndicatorSidePanel;
@property(nonatomic,strong)IBOutlet UIImageView *imgSidePanelProfile;

//////other cells

@property(nonatomic,strong)IBOutlet UIImageView *imgSidePanel;
@property(nonatomic,strong)IBOutlet UILabel *lblSidePanel;

@end
