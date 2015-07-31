//
//  ViewController.m
//  ChaseChallenge
//
//  Created by ANTHONY O. on 7/30/15.
//  Copyright (c) 2015 ANTHONY O. All rights reserved.
//

#import "ViewController.h"
#import "LocationData.h"
#import "DetailViewController.h"
#import "MapAnnotationView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    } else {
        [self.locationManager startUpdatingLocation];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if(status == kCLAuthorizationStatusAuthorizedWhenInUse){
        [self.locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    
    CLLocation *location = [locations objectAtIndex:0];
    
    
    
    [self.mapView setRegion:MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.04, 0.04))];

    
    
    NSString *downloadURL = [NSString stringWithFormat:@"https://m.chase.com/PSRWeb/location/list.action?lat=%f&lng=%f",location.coordinate.latitude, location.coordinate.longitude];
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:downloadURL]];
    
    NSError *error = nil;
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if(!error){
        NSArray *arr = [dataDictionary objectForKey:@"locations"];
        if(arr.count == 0){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Locations" message:@"There is nothing around you" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        } else {
            NSMutableArray *objects = [[NSMutableArray alloc] init];
            for(NSDictionary *locObject in arr) {
                LocationData *data = [[LocationData alloc] init];
                data.lat = [[locObject objectForKey:@"lat"] floatValue];
                data.lng = [[locObject objectForKey:@"lng"] floatValue];
                data.distance = [[locObject objectForKey:@"distance"] floatValue];
                data.name = [locObject objectForKey:@"name"];
                data.address = [locObject objectForKey:@"address"];
                data.locType = [locObject objectForKey:@"locType"];
                [objects addObject:data];
            }
            [self drawOnMapWithData:objects];
        }
        
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There was an error with JSON" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
    
    [self.locationManager stopUpdatingLocation];

}

-(void) drawOnMapWithData:(NSArray *) arrayLocations {
    
    for(LocationData *data in arrayLocations){
        MapAnnotation *ann = [[MapAnnotation alloc] init];
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(data.lat, data.lng);
        ann.coordinate = coord;
        ann.title = data.name;
        ann.subtitle = data.address;
        ann.theDataObject = data;
        [self.mapView addAnnotation:ann];
    }

    
    
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
    MapAnnotationView *view = [[MapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
    
    return view;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Detail"];
    MapAnnotation *mAnn = (MapAnnotation *)view.annotation;
    LocationData *dataObjectToPass = mAnn.theDataObject;
    vc.obj = dataObjectToPass;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}



@end
