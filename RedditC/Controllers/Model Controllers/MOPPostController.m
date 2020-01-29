//
//  MOPPostController.m
//  RedditC
//
//  Created by Maxwell Poffenbarger on 1/29/20.
//  Copyright © 2020 Maxwell Poffenbarger. All rights reserved.
//

#import "MOPPostController.h"

static NSString * const baseURL = @"https://www.reddit.com";
static NSString * const rComponentString = @"r";
static NSString * const funnyComponent = @"funny";
static NSString * const JSONExtension = @"json";

@implementation MOPPostController

+ (instancetype)sharedInstance
{
    static MOPPostController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MOPPostController alloc] init];
    });
    return sharedInstance;
}

- (void)fetchPosts:(void (^)(BOOL))completion
{
    NSURL * url = [NSURL URLWithString:baseURL];
    NSURL * rURL = [url URLByAppendingPathComponent:rComponentString];
    NSURL * funnyURL = [rURL URLByAppendingPathComponent:funnyComponent];
    NSURL * finalURL = [funnyURL URLByAppendingPathExtension:JSONExtension];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(false);
            return;
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (!data)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(false);
            return;
        }
        
        NSDictionary * TopLevelJSON = [NSJSONSerialization JSONObjectWithData: data options: 2 error: &error];
        
        if (!TopLevelJSON)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(false);
            return;
        }
        
        NSDictionary * secondLevelJSON = TopLevelJSON[@"data"];
        NSArray<NSDictionary *> * thirdLevelJSON = secondLevelJSON[@"children"];
        NSMutableArray * arrayOfPosts = [[NSMutableArray alloc] init];
        
        for (NSDictionary * currentDictionary in thirdLevelJSON)
        {
            NSDictionary * postDictionary = currentDictionary[@"data"];
            MOPPost * post = [[MOPPost alloc] initWithDictionary:postDictionary];
            [arrayOfPosts addObject:post];
        }
        
        if (arrayOfPosts.count !=0)
        {
            MOPPostController.sharedInstance.posts = arrayOfPosts;
            completion(true);
        } else
        {
            completion(false);
        }
    }] resume];
}

- (void)fetchImageForPost:(MOPPost *)post completion:(void (^)(UIImage * _Nullable))completion
{
    NSURL * imageURL = [NSURL URLWithString:post.thumbnail];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(false);
            return;
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (data)
        {
            UIImage * image = [UIImage imageWithData:data];
            completion(image);
        }
    }] resume];
}

@end
