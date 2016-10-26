//
//  AddLocationCell.h
//  LivingTags
//
//  Created by appsbeetech on 13/10/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface AddLocationCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UIButton *btnMap;
@property(nonatomic,strong)IBOutlet MKMapView *mapTagLocation;

@property(nonatomic,strong)IBOutlet UIButton *btnCross;
@end
