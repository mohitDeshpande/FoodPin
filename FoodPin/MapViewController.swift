//
//  MapViewController.swift
//  FoodPin
//
//  Created by Mohit Deshpande on 08/02/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self;
        
        setupLocationManager()
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location, completionHandler: { placemarks, error in
            if error != nil {
                print(error!)
                return
            }
            self.setupRouteAndAnnotations(placemarks: placemarks!)
        })
    }
    
    func setupRouteAndAnnotations(placemarks: [CLPlacemark]) {
        if placemarks.count > 0 {
            let restaurantPlacemark = MKPlacemark(coordinate: (placemarks[0].location?.coordinate)!, addressDictionary: nil)
            let userLocationPlacemark = MKPlacemark(coordinate: (self.locationManager.location?.coordinate)!, addressDictionary: nil)
            
            let restaurantAnnotation = self.createRestaurantAnnotation(restaurantPlacemark: restaurantPlacemark)
            self.mapView.showAnnotations([restaurantAnnotation, self.createUserLocationAnnotation(userPlacemark: userLocationPlacemark)], animated: true)
            self.mapView.selectAnnotation(restaurantAnnotation, animated: true)
            let directions = self.makeRouteDirections(sourcePlacemark: userLocationPlacemark, destinationPlacemark: restaurantPlacemark)
            self.drawRoute(directions: directions)
        }
    }
    func createUserLocationAnnotation(userPlacemark: MKPlacemark) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "Your current location"
        annotation.subtitle = "Route is built starting from this point"
        annotation.coordinate = (userPlacemark.location?.coordinate)!
        return annotation
    }
    
    func createRestaurantAnnotation(restaurantPlacemark: MKPlacemark) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = self.restaurant.name
        annotation.subtitle = self.restaurant.type
        annotation.coordinate = (restaurantPlacemark.location?.coordinate)!
        return annotation
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        if #available(iOS 9.0, *) {
            locationManager.requestLocation()
        } else {
            // Fallback on earlier versions
        }
    }
    
    func makeRouteDirections(sourcePlacemark : MKPlacemark, destinationPlacemark: MKPlacemark) -> MKDirections {
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        return directions
    }
    
    func drawRoute(directions: MKDirections) {
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }
            
            let route = response.routes[0]
            self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
        
        leftIconView.image = UIImage(named: restaurant.image)
        annotationView?.leftCalloutAccessoryView = leftIconView
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 4.0
        return renderer
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension MapViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            if #available(iOS 9.0, *) {
                manager.requestLocation()
            } else {
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.first != nil {
            print("location:: (location)")
        }
    }
}
