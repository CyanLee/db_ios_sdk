//
//  NSDictionary+Extension.m
//  db_base_sdk
//
//  Created by 管家人 on 2019/5/20.
//  Copyright © 2019 管家人. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

- (id)safeObjectForKey:(id)aKey
{
    id result = [self objectForKey:aKey];
    if ([result isKindOfClass:[NSNull class]])
    {
        result = nil;
    }
    return result;
}

@end
