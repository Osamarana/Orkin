//
//  MessageHistory.h
//  Maggie
//
//  Created by Apple on 04/05/2016.
//  Copyright © 2016 Hannan Khan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageHistory : NSObject
@property (strong, nonatomic) NSString *message_id;
@property (strong, nonatomic) NSString *message_text;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *schedule_datetime;
@property (strong, nonatomic) NSMutableArray *chat_messages;

@end
