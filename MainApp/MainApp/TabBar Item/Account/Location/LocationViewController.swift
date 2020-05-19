//
//  LocationVC.swift
//  MainApp
//
//  Created by Anmol Chauhan on 14/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit
import GoogleMaps

class LocationViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = true
        mapView.settings.allowScrollGesturesDuringRotateOrZoom = true
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let localValue : CLLocationCoordinate2D = manager.location?.coordinate else {
            return
        }
        
        guard let location = locations.last else {
            return
        }
        print("location = \(localValue.latitude) \(localValue.longitude)")
        
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 10, bearing: 0, viewingAngle: 0)
        
        locationManager.stopUpdatingLocation()
    }
    
    
    
}
