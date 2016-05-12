//
//  HistoryModel.h
//  Maggie
//
//  Created by Ahmed Sadiq on 14/03/2016.
//  Copyright © 2016 Hannan Khan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryModel : NSObject
@property (strong, nonatomic) NSString *schedule_id;
@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *service_location;
@property (strong, nonatomic) NSString *premises_type;
@property (strong, nonatomic) NSString *schedule_title;
@property (strong, nonatomic) NSString *customer_name;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *phone_no;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *area;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *more_detail;
@property (strong, nonatomic) NSString *schedule_datetime;
@property (strong, nonatomic) NSString *schedule_type;
@property (strong, nonatomic) NSString *specific_problem;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *surface_area;
@end
