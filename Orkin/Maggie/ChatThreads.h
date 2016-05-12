//
//  ChatThreads.h
//  Maggie
//
//  Created by Apple on 04/05/2016.
//  Copyright © 2016 Hannan Khan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatThreads : NSObject
@property (strong, nonatomic) NSString *message_text;
@property (strong, nonatomic) NSString *sent_by;
@property (strong, nonatomic) NSString *date_time;
@end
