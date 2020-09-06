//
//  MapVC.swift
//  MediaFinder
//
//  Created by a on 5/30/20.
//  Copyright © 2020 a. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation
import Foundation

protocol AddressDelegate {
    func sendAddress (address: String)
}

class MapVC: UIViewController, CLLocationManagerDelegate ,UISearchBarDelegate {
    
    var delegate: AddressDelegate?
    
    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var dirLabel: UILabel!
    @IBOutlet weak var searchTF: UITextField!
    
    var locationManager = CLLocationManager()
    let SignUp = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MapView.showsBuildings = true
        
        if CLLocationManager.locationServicesEnabled() == true {
            if CLLocationManager.authorizationStatus() == .restricted
                || CLLocationManager.authorizationStatus() == .denied
                || CLLocationManager.authorizationStatus() == .notDetermined
            {
                locationManager.requestWhenInUseAuthorization()
            }
            
            locationManager.desiredAccuracy = 1.0
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            
        }else {
            print("error 2000")
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        self.MapView.setRegion(region, animated: true)   //  change map view
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func getCenterLocation (mapView :MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    
    
    @IBAction func updateLocation(_ sender: Any) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(searchTF.text!){placeMarks,Error in
            guard let placeMarks = placeMarks, let location = placeMarks.first?.location else {
                self.dirLabel.text = ""
                return }
            
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
            
            self.MapView.setRegion(region, animated: true)
            self.dirLabel.text = "\(placeMarks.first?.administrativeArea ?? ""),\(placeMarks.first?.country ?? "") "
        }
    }
    
    @IBAction func setThisLocation(_ sender: Any) {
        let geoCoder = CLGeocoder()
        let region = getCenterLocation(mapView: MapView)
        geoCoder.reverseGeocodeLocation(region, completionHandler: {placeMarks,Error in
            guard let placeMarks = placeMarks, let location = placeMarks.first?.location else { return }
            
            self.dirLabel.text = "\(placeMarks.first?.administrativeArea ?? ""),\(placeMarks.first?.country ?? "")"
            
           
            let region1 = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            
            self.MapView.setRegion(region1, animated: true)
            
            self.delegate?.sendAddress(address: self.dirLabel.text ?? "")
            
          //  print (self.dirLabel ?? "error")
            
           // self.SignUp.address = "\(placeMarks.first?.administrativeArea ?? ""),\(placeMarks.first?.country ?? "")"
            self.navigationController?.popViewController(animated: true) 
        }
        )
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

