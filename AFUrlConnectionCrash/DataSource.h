//
//  DataSource.h
//  AFUrlConnectionCrash
//
//  Created by Pawel Glen on 01/10/15.
//  Copyright © 2015 Pawel Glen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSource : NSObject

+ (instancetype)sharedInstance;

-(void)downloadSeveralFiles;


@end
