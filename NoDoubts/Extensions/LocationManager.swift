//
//  LocationManager.swift
//  NoDoubts
//
//  Created by Qazi on 25/10/2021.
//

import Foundation
import MapKit
import SwiftUI
import GoogleMaps

struct GoogleMapsView2: UIViewRepresentable {
  
    @State var longitudeTest: Double = 74.329376
    @State var latitudeTest: Double = 31.582045
    let marker : GMSMarker = GMSMarker()
    
     var latitude: Double
    var longitude: Double
    var address : String
    
    //@EnvironmentObject var locationM : DataStore
    var geoCoder: CLGeocoder = CLGeocoder()
    
    private let zoom: Float = 15.0
   
    
   
    
    func makeCoordinator() -> MapCoordinator2 {
        return MapCoordinator2(
            parent: self,
            latitude: $latitudeTest,
            longitude: $longitudeTest)
    }
    
    func makeUIView(context: Self.Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoom)
        
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        mapView.delegate = context.coordinator
        //marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
      
        
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: UIViewRepresentableContext<GoogleMapsView2>) {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoom)
            mapView.camera = camera
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        
        marker.snippet = address
        marker.map = mapView
        
        //mapView.animate(toLocation: CLLocationCoordinate2D(latitude: locationManager.lastLocation?.coordinate.latitude ?? 0, longitude: locationManager.lastLocation?.coordinate.longitude ?? 0))
        //getAddress(latitude: latitudeTest, longitude: longitudeTest)
        //print(locationM.longitude)
//        mapView.myLocation
        
        
        
            
      
        
        
//        if isFocused {
//            mapView.animate(toLocation: CLLocationCoordinate2D(latitude: latitudeTest, longitude: longitudeTest))
//        }
        
//        if requestSearch {
//            DispatchQueue.main.async {
//                getLatLongFromAddress(address: searchAddress) { (result) in
//                    if result {
//                        selectedMarker!.position = CLLocationCoordinate2D(latitude: latitudeTest, longitude: longitudeTest)
//                        selectedMarker!.snippet = streetLocation
//                        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: latitudeTest, longitude: longitudeTest))
//                    } else {
//                        print("no location found")
//                    }
//                }
//            }
//        }
    }
    
    func getAddress(latitude: Double, longitude: Double){
        
        let geocoder = GMSGeocoder()
        let coordinate = CLLocationCoordinate2DMake(Double(latitude), Double(longitude))
        
       
    }
    
//    func getLatLongFromAddress(address: String, completion: @escaping((Bool) -> ())) {
//        let geoCoder = CLGeocoder()
//        geoCoder.geocodeAddressString(address) {
//            placemarks, error in
//
//            if placemarks != nil {
//                let placemark = placemarks?.first
//                latitudeTest = (placemark?.location?.coordinate.latitude)!
//                longitudeTest = (placemark?.location?.coordinate.longitude)!
//                completion(true)
//                // Use your location
//            } else {
//                print("no location found")
//                completion(false)
//            }
//        }
//    }
    
    func searchAddress(latitude: Double, longitude: Double){
        
        let geocoder = GMSGeocoder()
        let coordinate = CLLocationCoordinate2DMake(Double(latitude), Double(longitude))
        
    }
}

class MapCoordinator2: NSObject, GMSMapViewDelegate , ObservableObject {
    // 1.
    let parent: GoogleMapsView2       // access to owner view members,
  
    @Binding var latitude: Double
    @Binding var longitude: Double
  
    var geoCoder: CLGeocoder = CLGeocoder()
    init(parent: GoogleMapsView2, latitude: Binding<Double>, longitude: Binding<Double>) {
        self.parent = parent
        _latitude = latitude
        _longitude = longitude
        
        print("init called")
    }
    
    deinit {
        print("deinit: MapCoordinator2")
    }
    
    //    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
    //
    //        print("A marker has been touched
    //        return true
    //
    //    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        longitude = coordinate.longitude
        latitude = coordinate.latitude
    }
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        print(true)
    }
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let lat = position.target.latitude
        let lng = position.target.longitude
        
        
        
        // Create Location
        
       // parent.getAddress(latitude: lat, longitude: lng)
            

            
        
        
    }
//    func mapView(mapView: GMSMapView, didEndDraggingMarker marker: GMSMarker)
//    {
//        if marker.userData as! String == "changedestination"
//        {
//            let destinationLocation = CLLocation(latitude: marker.position.latitude, longitude: marker.position.longitude)
//            let destinationCoordinate = destinationLocation.coordinate
//            //getAddressFromLatLong(destinationCoordinate)
//        }
//    }
//    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading)
//            {
//                let  heading:Double = newHeading.trueHeading;
//                selectedMarker?.groundAnchor = CGPoint(x: 0.5, y: 0.5)
//        selectedMarker?.rotation = heading
//        //selectedMarker.map = mapView;
//                print(selectedMarker?.rotation)
//            }
    
   
    
}

struct AnnotatedItem: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

