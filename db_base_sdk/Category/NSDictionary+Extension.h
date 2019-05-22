//
//  NSDictionary+Extension.h
//  db_base_sdk
//
//  Created by 管家人 on 2019/5/20.
//  Copyright © 2019 管家人. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Extension)

- (id)safeObjectForKey:(id)aKey;

@end

NS_ASSUME_NONNULL_END
