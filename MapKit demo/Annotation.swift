//
//  Annotation.swift
//  MapKit demo
//
//  Created by Mindscape on 6/29/16.
//  Copyright © 2016 Webterminal Inc. All rights reserved.
//

import UIKit
import MapKit


class Annotation: NSObject,MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D

    
    
    //to customize my collout
    var imageName : String?
    
    
    init(title aTitle:String, subtitle aSubTitle:String, aCoordinate:CLLocationCoordinate2D){
        self.coordinate = aCoordinate
        self.title  = aTitle
        self.subtitle = aSubTitle
        super.init()
    }
    
}
