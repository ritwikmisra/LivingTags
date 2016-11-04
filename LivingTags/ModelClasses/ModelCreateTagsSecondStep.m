//
//  ModelCreateTagsSecondStep.m
//  LivingTags
//
//  Created by appsbeetech on 19/07/16.
//  Copyright © 2016 appsbeetech. All rights reserved.
//

#import "ModelCreateTagsSecondStep.h"

@implementation ModelCreateTagsSecondStep

-(id)initWithDictionary:(NSDictionary *)dict
{
    if (self=[super init])
    {
        if ([dict objectForKey:@"id"] && ![[dict objectForKey:@"id"] isKindOfClass:[NSNull class]])//
        {
            self.strID=[dict objectForKey:@"id"];
        }
        else
        {
            self.strID=@"";
        }
        
        if ([dict objectForKey:@"tkey"] && ![[dict objectForKey:@"tkey"] isKindOfClass:[NSNull class]])//
        {
            self.strtKey=[dict objectForKey:@"tkey"];
        }
        else
        {
            self.strtKey=@"";
        }

        if ([dict objectForKey:@"account_id"] && ![[dict objectForKey:@"account_id"] isKindOfClass:[NSNull class]])//
        {
            self.strAccountID=[dict objectForKey:@"account_id"];
        }
        else
        {
            self.strAccountID=@"";
        }
        if ([dict objectForKey:@"template_id"] && ![[dict objectForKey:@"template_id"] isKindOfClass:[NSNull class]])//
        {
            self.strTemplateID=[dict objectForKey:@"template_id"];
        }
        else
        {
            self.strTemplateID=@"";
        }
        if ([dict objectForKey:@"tcover"] && ![[dict objectForKey:@"tcover"] isKindOfClass:[NSNull class]])//
        {
            self.strCoverURI=[dict objectForKey:@"tcover"] ;
        }
        else
        {
            self.strCoverURI=@"";
        }
        if ([dict objectForKey:@"tphoto"] && ![[dict objectForKey:@"tphoto"] isKindOfClass:[NSNull class]])//
        {
            self.strUserPicURI=[dict objectForKey:@"tphoto"];
        }
        else
        {
            self.strUserPicURI=@"";
        }
        NSLog(@"%@",dict);
        if ([dict objectForKey:@"tname"] && ![[dict objectForKey:@"tname"] isKindOfClass:[NSNull class]])//
        {
            self.strtname=[dict objectForKey:@"tname"];
        }
        else
        {
            self.strtname=@"";
        }
        if ([dict objectForKey:@"tborn"] && ![[dict objectForKey:@"tborn"] isKindOfClass:[NSNull class]])//
        {
            self.strtborn=[dict objectForKey:@"tborn"];
        }
        else
        {
            self.strtborn=@"";
        }
        if ([dict objectForKey:@"tdied"] && ![[dict objectForKey:@"tdied"] isKindOfClass:[NSNull class]])//
        {
            self.strtdied=[dict objectForKey:@"tdied"];
        }
        else
        {
            self.strtdied=@"";
        }
        if ([dict objectForKey:@"tlat1"] && ![[dict objectForKey:@"tlat1"] isKindOfClass:[NSNull class]])//
        {
            self.strtlat1=[dict objectForKey:@"tlat1"] ;
        }
        else
        {
            self.strtlat1=@"";
        }
        if ([dict objectForKey:@"tlong1"] && ![[dict objectForKey:@"tlong1"] isKindOfClass:[NSNull class]])//
        {
            self.strtlong1=[dict objectForKey:@"tlong1"];
        }
        else
        {
            self.strtlong1=@"";
        }
        if ([dict objectForKey:@"tdetail"] && ![[dict objectForKey:@"tdetail"] isKindOfClass:[NSNull class]])//
        {
            self.strMemorialQuote=[dict objectForKey:@"tdetail"] ;
        }
        else
        {
            self.strMemorialQuote=@"";
        }
       if ([dict objectForKey:@"tgender"] && ![[dict objectForKey:@"tgender"] isKindOfClass:[NSNull class]])//
        {
            self.strtgender=[dict objectForKey:@"tgender"];
        }
        else
        {
            self.strtgender=@"";
        }
        /////
        if ([dict objectForKey:@"taddress1"] && ![[dict objectForKey:@"taddress1"] isKindOfClass:[NSNull class]])//
        {
            self.strtaddress1=[dict objectForKey:@"taddress1"];
        }
        else
        {
            self.strtaddress1=@"";
        }
        /////******tslogan
        if ([dict objectForKey:@"tslogan"] && ![[dict objectForKey:@"tslogan"] isKindOfClass:[NSNull class]])//
        {
            self.strSlogan=[dict objectForKey:@"tslogan"];
        }
        else
        {
            self.strSlogan=@"";
        }
        /////
        if ([dict objectForKey:@"tcname"] && ![[dict objectForKey:@"tcname"] isKindOfClass:[NSNull class]])//
        {
            self.strTcname=[dict objectForKey:@"tcname"];
        }
        else
        {
            self.strTcname=@"";
        }
        /////tphone
        if ([dict objectForKey:@"tphone"] && ![[dict objectForKey:@"tphone"] isKindOfClass:[NSNull class]])//
        {
            self.strTphone=[dict objectForKey:@"tphone"];
        }
        else
        {
            self.strTphone=@"";
        }
        
        /////tfax
        if ([dict objectForKey:@"tfax"] && ![[dict objectForKey:@"tfax"] isKindOfClass:[NSNull class]])//
        {
            self.strTfax=[dict objectForKey:@"tfax"];
        }
        else
        {
            self.strTfax=@"";
        }
        /////tcategories
        if ([dict objectForKey:@"tcategories"] && ![[dict objectForKey:@"tcategories"] isKindOfClass:[NSNull class]])//
        {
            self.strTcategories=[dict objectForKey:@"tcategories"];
        }
        else
        {
            self.strTcategories=@"";
        }
        
        //// taddress2
        if ([dict objectForKey:@"taddress2"] && ![[dict objectForKey:@"taddress2"] isKindOfClass:[NSNull class]])//
        {
            self.strAddress2=[dict objectForKey:@"taddress2"];
        }
        else
        {
            self.strAddress2=@"";
        }

        ////tlat2
        if ([dict objectForKey:@"tlat2"] && ![[dict objectForKey:@"tlat2"] isKindOfClass:[NSNull class]])//
        {
            self.strLat2=[dict objectForKey:@"tlat2"];
        }
        else
        {
            self.strLat2=@"";
        }

        ///tlong2
        if ([dict objectForKey:@"tlong2"] && ![[dict objectForKey:@"tlong2"] isKindOfClass:[NSNull class]])//
        {
            self.strlong2=[dict objectForKey:@"tlong2"];
        }
        else
        {
            self.strlong2=@"";
        }

        ////tmobile
        if ([dict objectForKey:@"tmobile"] && ![[dict objectForKey:@"tmobile"] isKindOfClass:[NSNull class]])//
        {
            self.strMobile=[dict objectForKey:@"tmobile"];
        }
        else
        {
            self.strMobile=@"";
        }

        ///twebsite
        if ([dict objectForKey:@"twebsite"] && ![[dict objectForKey:@"twebsite"] isKindOfClass:[NSNull class]])//
        {
            self.strWebsite=[dict objectForKey:@"twebsite"];
        }
        else
        {
            self.strWebsite=@"";
        }
        //temail
        if ([dict objectForKey:@"temail"] && ![[dict objectForKey:@"temail"] isKindOfClass:[NSNull class]])//
        {
            self.strEmail=[dict objectForKey:@"temail"];
        }
        else
        {
            self.strEmail=@"";
        }

    }
    return self;
}

@end
