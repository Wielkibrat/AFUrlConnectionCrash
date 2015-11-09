//
//  ViewController.m
//  AFUrlConnectionCrash
//
//  Created by Pawel Glen on 01/10/15.
//  Copyright © 2015 Pawel Glen. All rights reserved.
//

#import "ViewController.h"
#import "DataSource.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)fireTest:(id)sender{
    [[DataSource sharedInstance]downloadSeveralFiles];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
