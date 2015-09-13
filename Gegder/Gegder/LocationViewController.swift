//
//  LocationViewController.swift
//  Gegder
//
//  Created by Benjamin Ang on 7/9/15.
//  Copyright (c) 2015 Genesys. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {
    
    @IBOutlet weak var LocationMapView: MKMapView!
    
    var displayLocation: CLLocation?
    var locationTitle: String!
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if displayLocation !=  nil {
        
            let annotation = MKPointAnnotation()
            annotation.coordinate = displayLocation!.coordinate
            annotation.title = locationTitle
            LocationMapView.addAnnotation(annotation)
            
            centerMapOnLocation(displayLocation!)
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        
        LocationMapView.setRegion(coordinateRegion, animated: true)
    }
}