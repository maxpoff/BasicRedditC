//
//  MOPPostController.h
//  RedditC
//
//  Created by Maxwell Poffenbarger on 1/29/20.
//  Copyright © 2020 Maxwell Poffenbarger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MOPPost.h"
#import "UIKit/UIKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface MOPPostController : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, copy) NSArray<MOPPost *> *posts;

- (void)fetchPosts: (void(^)(BOOL))completion;

- (void)fetchImageForPost: (MOPPost *)post completion:(void(^) (UIImage * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
