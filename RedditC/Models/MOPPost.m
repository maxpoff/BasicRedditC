//
//  MOPPost.m
//  RedditC
//
//  Created by Maxwell Poffenbarger on 1/29/20.
//  Copyright © 2020 Maxwell Poffenbarger. All rights reserved.
//

#import "MOPPost.h"

static NSString * const titleKey = @"title";
static NSString * const thumbnailKey = @"thumbnail";

@implementation MOPPost

- (instancetype)initWithTitle:(NSString *)title thumbnail:(NSString *)thumbnail
{
    self = [super init];
    if (self)
    {
        _title = title;
        _thumbnail = thumbnail;
    }
    return self;
}
@end


@implementation MOPPost (JSONConvertable)

- (MOPPost *)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString * title = dictionary[titleKey];
    NSString * thumbnail = dictionary[thumbnailKey];
    
    return [self initWithTitle:title thumbnail:thumbnail];
}

@end
