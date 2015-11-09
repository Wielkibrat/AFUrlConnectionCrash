//
//  DataSource.m
//  AFUrlConnectionCrash
//
//  Created by Pawel Glen on 01/10/15.
//  Copyright © 2015 Pawel Glen. All rights reserved.
//

#import "DataSource.h"
#import <AFNetworking/AFNetworking.h>

@interface DataSource()

@property(strong) AFHTTPRequestOperationManager *httpRequestManager;

@end

@implementation DataSource

+ (instancetype)sharedInstance {
    static DataSource *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (instancetype)init {
    if ((self = [super init])) {
        self.httpRequestManager = [AFHTTPRequestOperationManager manager];
        
        
        //comment this line out -> no crash
        self.httpRequestManager.operationQueue.maxConcurrentOperationCount = 3;
    }
    return self;
}

-(void)downloadSeveralFiles{
    __block int finishedRequests = 0;
    for(int i=0;i<40;i++){
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://cullicottsciencedhs.weebly.com/index.html"]];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id response) {
            finishedRequests++;
            NSLog(@"request %d finished",finishedRequests);
            if(finishedRequests%5==0){
                [self pauseAllDownloads];
                [self resumeAllDownloads];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            ;
        }];
        
        [self.httpRequestManager.operationQueue addOperation:operation];
    }
}

-(void)pauseAllDownloads{
    NSLog(@"all %d calls paused..",(int)[self.httpRequestManager.operationQueue.operations count]);
    for(AFHTTPRequestOperation *req in self.httpRequestManager.operationQueue.operations){
        [req pause];
    }
}

-(void)resumeAllDownloads{
    NSLog(@"all calls resumed..");
    for(AFHTTPRequestOperation *req in self.httpRequestManager.operationQueue.operations){
        [req resume];
    }
}

@end
