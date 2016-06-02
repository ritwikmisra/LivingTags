//
//  TMAnnotationView.h
//  CustomCallout
//
//  Created by Tarapada.


#import <MapKit/MapKit.h>

@protocol TMAnnotationViewDelegate;

@interface TMAnnotationView : MKAnnotationView

@property(nonatomic, strong) UIView *pinView;
@property(nonatomic, strong) UIView *calloutView;

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation
                   reuseIdentifier:(NSString *)reuseIdentifier
                           pinView:(UIImageView *)pinView;


@property(weak,nonatomic) id<TMAnnotationViewDelegate>delegate;

@end





@protocol TMAnnotationViewDelegate <NSObject>


@end
