//
//  LocationVC.swift
//  MainApp
//
//  Created by Anmol Chauhan on 14/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit
import MapKit

class LocationVC: UIViewController , MKMapViewDelegate , CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    
    let locationManager : CLLocationManager = {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func stUpTheMapView(){
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.isZoomEnabled = true
        mapView.showsCompass = true
        mapView.mapType = .standard
        self.userCurrentLocation()
    }
    
    func userCurrentLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 10.0, *){
            locationManager.showsBackgroundLocationIndicator = true
        }
        locationManager.startUpdatingLocation()
        
    }
    
    //MARK: CLLocationManager Delegatyes
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        let currentLocation = location.coordinate
        self.addAnnotationsOnMapView(cordinates: currentLocation)
        let coordinateRegion = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status)
    }
    
    // adding annotations
    func addAnnotationsOnMapView(cordinates: CLLocationCoordinate2D) {
           let annotaion = MKPointAnnotation()
           annotaion.title = "Noida"
           annotaion.subtitle = "Nids City Center"
           annotaion.coordinate = cordinates
           mapView.addAnnotation(annotaion)
       }
       
    //MARK: MapView Delegates
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        mapView.delegate = self
        guard annotation is MKPointAnnotation else { return nil }
        let identifier = "CurrentLocation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }

}
