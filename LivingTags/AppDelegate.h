//
//  AppDelegate.h
//  LivingTags
//
//  Created by appsbeetech on 21/04/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ModelUser.h"
#import "ModelLivingTagsViewedAndCreated.h"
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(assign,nonatomic) BOOL isRechable;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(nonatomic,assign)BOOL isFacebook;

//location manager
@property (nonatomic,strong) CLLocationManager *locationManager ;
@property (nonatomic,strong) CLGeocoder *geoCoder;
@property (nonatomic,assign) CLLocationCoordinate2D center;
@property(nonatomic,strong)CLLocation *location;
@property(nonatomic,strong)CLPlacemark *placemark ;

//location manage
@property(nonatomic,strong)ModelUser *objUser;
@property(nonatomic,strong)ModelLivingTagsViewedAndCreated *objLivingTags;

@property(nonatomic,strong)NSMutableArray *arrStatus;

@property(nonatomic,strong)NSMutableArray *arrCreateTagsUploadImage;
@property(nonatomic,strong)NSData *dataVoice;

 
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

