//
//  ViewController.swift
//  MapKit demo
//
//  Created by Mindscape on 6/29/16.
//  Copyright © 2016 Webterminal Inc. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController {

    var _mapView:MKMapView!
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        //create mapview object and add it to the main view
        _mapView = MKMapView(frame: self.view.bounds)
        _mapView.delegate = self
        _mapView.showsCompass = true
        _mapView.showsTraffic = true
        _mapView.showsBuildings = true
        self.view.addSubview(_mapView)
        
        //
        checkLocationAuthorizationStatus()
        
        //create annotation objects which will be displayed on mapview
        let location1 : Annotation = Annotation(title: "Bangalore", subtitle: "31°C, Wind W at 23 km/h, 52% Humidity", aCoordinate: CLLocationCoordinate2DMake(12.9716, 77.5946))
        location1.imageName = "bangalore"
        
        let location2 : Annotation = Annotation(title: "Kolkata", subtitle: "26°C, Wind SE at 10 km/h, 100% Humidity", aCoordinate: CLLocationCoordinate2DMake(22.5726, 88.3639))
        location2.imageName = "kolkata"

        let location3 : Annotation = Annotation(title: "Mumbai", subtitle: "32°C, Wind SW at 14 km/h, 66% Humidity", aCoordinate: CLLocationCoordinate2DMake(19.0760, 72.8777))
        location3.imageName = "mumbai"

        let location4 : Annotation = Annotation(title: "Hyderabad", subtitle: "30°C, Wind N at 27 km/h, 66% Humidity", aCoordinate: CLLocationCoordinate2DMake(17.3850, 78.4867))
        location4.imageName = "hyd"


        //add all annotation to the mapview
        _mapView.addAnnotations([location1,location2,location3,location4])
        
        
        //specifys the zoom level of perticular location area
        _mapView.setRegion(MKCoordinateRegionMake(location4.coordinate, MKCoordinateSpanMake(12, 12)), animated: true)
        
        
        //to change map type
        let segment = UISegmentedControl(items: ["Standard","Satellite","Hybrid"])
        segment.frame = CGRectMake(20, 40, 200, 30)
        segment.selectedSegmentIndex = 0
        segment.tintColor = UIColor.whiteColor()
        segment.addTarget(self, action: #selector(ViewController.changeMapType(_:)), forControlEvents: .ValueChanged)
        self.view.addSubview(segment)
    }

    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            _mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func changeMapType(segment:UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 1:
            _mapView.mapType = .Satellite
            break
        case 2:
            _mapView.mapType = .Hybrid
            break
        default:
            _mapView.mapType = .Standard
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension ViewController:MKMapViewDelegate{
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        var button : AAButton
        var iconView : UIImageView
        if let annotation = annotation as? Annotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView {
                //reused view
                view = dequeuedView
            } else { //very first time
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                //add annotation to the view
                view.annotation = annotation
                
                //right view
                button = AAButton(type: .DetailDisclosure)
                view.rightCalloutAccessoryView = button;
                
                
                //left view
                iconView = UIImageView(frame: CGRectMake(0, 0, 40, 40))
                iconView.contentMode = .ScaleAspectFill;
                view.leftCalloutAccessoryView = iconView;
            }
            
            //custom pin image
            view.image = UIImage(named: "pin")
            
            //right view action
            button = view.rightCalloutAccessoryView as! AAButton
            button.annotation = annotation
            button.addTarget(self, action: #selector(ViewController.showDetailLocation(_:)), forControlEvents: .TouchUpInside)
            
            
            //left view content
            iconView = view.leftCalloutAccessoryView as! UIImageView
            iconView.image = UIImage(named: annotation.imageName!)

            
            return view
        }
        return nil
    }
    
    func showDetailLocation(button:AAButton) {
        print("tapped location \(button.annotation?.title!)")
    }
}
