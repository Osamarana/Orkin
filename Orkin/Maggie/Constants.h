//
//  Constants.h
//  HydePark
//
//  Created by Ahmed Sadiq on 14/05/2015.
//  Copyright (c) 2015 TxLabz. All rights reserved.
//

#ifndef HydePark_Constants_h
#define HydePark_Constants_h

#pragma mark-
#pragma mark Server Calling Constants
#define SERVER_URL @"http://orkinlb.witsapplication.com/functions/api/page.php"


#define METHOD_SIGN_UP @"register_login"
#define METHOD_EDIT_PROFILE @"editProfile"
#define METHOD_HISTORY @"getScheduleHistory"
#define METHOD_SUBMIT @"submitApplication"
#define METHOD_SUBMIT_MESSAGE @"submitMessage"
#define METHOD_SUBMIT_ACTION @"logUserAction"
#define METHOD_SEND_CHAT_MESSAGE @"sendChatMessage"
#define METHOD_ADDNOTIFICATION_KEY @"addNotificationKey"
#pragma mark-
#pragma mark Server Response
#define SUCCESS 1

#pragma mark-
#pragma mark Screen Sizes
#define IS_IPHONE_6 ([[UIScreen mainScreen] bounds].size.height == 667)
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height == 568)
#define IS_IPHONE_4 ([[UIScreen mainScreen] bounds].size.height == 480)
#define IS_IPAD ([[UIScreen mainScreen] bounds].size.height == 1024)
#define IS_IPHONE_6Plus ([[UIScreen mainScreen] bounds].size.height == 736)

#endif
