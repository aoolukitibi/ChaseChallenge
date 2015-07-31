//
//  DetailViewController.m
//  ChaseChallenge
//
//  Created by ANTHONY O. on 7/31/15.
//  Copyright (c) 2015 ANTHONY O. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *bankName;
@property (weak, nonatomic) IBOutlet UILabel *bankAddress;
@property (weak, nonatomic) IBOutlet UILabel *locationType;
@property (weak, nonatomic) IBOutlet UILabel *bankDistance;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   self.bankName.text = self.obj.name;
   self.bankAddress.text = self.obj.address;
   NSString *distance = [NSString stringWithFormat:@"%f Miles", self.obj.distance];
   self.bankDistance.text = distance;
   self.locationType.text = self.obj.locType;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
