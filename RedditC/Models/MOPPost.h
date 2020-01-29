//
//  MOPPost.h
//  RedditC
//
//  Created by Maxwell Poffenbarger on 1/29/20.
//  Copyright © 2020 Maxwell Poffenbarger. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MOPPost : NSObject

@property (nonatomic, copy, readonly, nonnull)NSString *title;
@property (nonatomic, copy, readonly, nullable)NSString *thumbnail;

- (MOPPost *)initWithTitle:(NSString *)title
                    thumbnail:(NSString *)thumbnail;

@end

@interface MOPPost (JSONConvertable)

- (MOPPost*)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
