//
//  MKMapView+Extension.swift
//  DemoFeb13
//
//  Created by Chandra Jayaswal on 3/20/21.
//

import Foundation
import MapKit

extension MKMapView {
    func centerToLocation(_ location: CLLocation,regionRadius:  CLLocationDistance = 1000
      ) {
        let coordinateRegion = MKCoordinateRegion(
          center: location.coordinate,
          latitudinalMeters: regionRadius,
          longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
      }
    
}
