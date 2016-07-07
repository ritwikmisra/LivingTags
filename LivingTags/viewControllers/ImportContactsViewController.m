//
//  ImportContactsViewController.m
//  LivingTags
//
//  Created by appsbeetech on 04/05/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ImportContactsViewController.h"
#import <Contacts/Contacts.h>

@interface ImportContactsViewController ()
{
    
}
@end
@implementation ImportContactsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark
#pragma mark IBACTION
#pragma mark

-(IBAction)btnContactPressed:(id)sender
{
    //ios 9 or later
    [self contactScan];
}

#pragma mark
#pragma mark CONTACT FETCH
#pragma mark

-(void)contactScan
{
    if ([CNContactStore class])
    {
        //ios9 or later
        CNEntityType entityType = CNEntityTypeContacts;
        if( [CNContactStore authorizationStatusForEntityType:entityType] == CNAuthorizationStatusNotDetermined)
        {
            CNContactStore * contactStore = [[CNContactStore alloc] init];
            [contactStore requestAccessForEntityType:entityType completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if(granted){
                    [self getAllContact];
                }
            }];
        }
        else if( [CNContactStore authorizationStatusForEntityType:entityType]== CNAuthorizationStatusAuthorized)
        {
            [self getAllContact];
        }
    }
}

-(void)getAllContact
{
    if([CNContactStore class])
    {
        //iOS 9 or later
        NSError* contactError;
        CNContactStore* addressBook = [[CNContactStore alloc]init];
        [addressBook containersMatchingPredicate:[CNContainer predicateForContainersWithIdentifiers: @[addressBook.defaultContainerIdentifier]] error:&contactError];
        NSArray * keysToFetch =@[CNContactEmailAddressesKey, CNContactPhoneNumbersKey, CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPostalAddressesKey];
        CNContactFetchRequest * request = [[CNContactFetchRequest alloc]initWithKeysToFetch:keysToFetch];
        BOOL success = [addressBook enumerateContactsWithFetchRequest:request error:&contactError usingBlock:^(CNContact * __nonnull contact, BOOL * __nonnull stop){
            [self parseContactWithContact:contact];
        }];
    }
}

- (void)parseContactWithContact :(CNContact* )contact
{
    NSString * firstName =  contact.givenName;
    NSString * lastName =  contact.familyName;
    NSString *strContactID=contact.identifier;//the contact id which you want
    NSString * phone = [[contact.phoneNumbers valueForKey:@"value"] valueForKey:@"digits"];
    NSString * email = [contact.emailAddresses valueForKey:@"value"];
    NSArray * addrArr = [self parseAddressWithContac:contact];
    NSLog(@"FIRSTNAME=%@\nLASTNAME=%@\nPHONE=%@\nIDENTIFIER=%@",firstName,lastName,phone,strContactID);
}

-(NSMutableArray *)parseAddressWithContac: (CNContact *)contact
{
    NSMutableArray * addrArr = [[NSMutableArray alloc]init];
    CNPostalAddressFormatter * formatter = [[CNPostalAddressFormatter alloc]init];
    NSArray * addresses = (NSArray*)[contact.postalAddresses valueForKey:@"value"];
    if (addresses.count > 0)
    {
        for (CNPostalAddress* address in addresses)
        {
            [addrArr addObject:[formatter stringFromPostalAddress:address]];
        }
    }
    return addrArr;
}

@end
