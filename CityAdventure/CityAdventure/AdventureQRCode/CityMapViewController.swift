//
//  CityMapViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 7. 9..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit
import MapKit

class CityMapViewController: BaseViewController {
    
    @IBOutlet weak var mapView: MKMapView!

    var location: (Float, Float)?
    let regionRadius: CLLocationDistance = 1000
    
    let locationManager = CLLocationManager()
    var cityname: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.delegate = self
        
        
        if let loc = location {
            setAnnotation(latitude: Double(loc.0), longitude: Double(loc.1), delta: 1, Title: "Map", subTitle: cityname)
        }
        
        
    }
    
   
    
    func myLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, delta: Double) -> CLLocationCoordinate2D{
        let coordinateLocation = CLLocationCoordinate2DMake(latitude, longitude)
        let spanValue = MKCoordinateSpanMake(delta, delta)
        let locationRegion = MKCoordinateRegionMake(coordinateLocation, spanValue)
        mapView.setRegion(locationRegion, animated: true)
        return coordinateLocation
        
    }
    
    @IBAction func backButton(_ sender: UIButton) { self.navigationController?.popViewController(animated: true)
    }
    
    func setAnnotation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, delta: Double, Title: String, subTitle: String){
        let annotation = MKPointAnnotation()
        annotation.coordinate = myLocation(latitude: latitude, longitude: longitude, delta: delta)
        annotation.title = title
        annotation.subtitle = subTitle
        mapView.addAnnotation(annotation)
    }
}


extension CityMapViewController: CLLocationManagerDelegate {
    
}
