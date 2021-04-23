//
//  MapVC.swift
//  DemoFeb13
//
//  Created by Chandra Jayaswal on 2/27/21.
//

import UIKit
import MapKit
import CoreLocation
import CoreMotion


class MapVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var sliderGForce: UISlider!
    @IBOutlet weak var lblGForceMin: UILabel!
    @IBOutlet weak var lblGForceCurrent: UILabel!
    @IBOutlet weak var lblGForceMax: UILabel!
    
    
    
    let motionManager = CMMotionManager()
    var locationManager: CLLocationManager? = nil
    var currentLocation:CLLocationCoordinate2D? = nil
    
    var timer: Timer!
    
    //Destination is considered as Singha Durbar
    var destinationLat = 27.697330
    var destinationLon = 85.326515
    
    //Current Location Test Data
    //Gokarneshwor  27.7639386, 85.347967
    //Koteshwor 27.677179, 85.326812
    //Baneshwor 27.6946835, 85.322308
    
    var thtresholdGForce: Double = 0.5
    var thresholdAcceleration: Double = 60.0
    
    
    
    // MARK: -
    // MARK: Private Utility Methods
    
    func loadMapView() {
        self.locationManager = CLLocationManager()
        self.locationManager!.requestWhenInUseAuthorization()
        self.locationManager!.requestWhenInUseAuthorization()
        self.mapView.showsUserLocation = true
        self.mapView.delegate = self
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager!.delegate = self
            locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager!.startUpdatingLocation() // start location manager
        }
    }
    
    func stopUpdatingMapLocation(){
        self.locationManager!.stopUpdatingLocation()
    }
    
    func drawRoute(destinationCoordinate: CLLocationCoordinate2D){
        /* First we need to create MKDirections */
        /* request object and then we modify it */
        /* by giving the location coordinates */
        /* from source to destination. */
        
        let request = MKDirections.Request()
//        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude:30.711378, longitude:76.688981), addressDictionary: nil))
//
//        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 30.710653, longitude: 76.694814), addressDictionary: nil))
        
        request.source = MKMapItem.forCurrentLocation()
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
        /* Then we need to specify the transport */
        /* type which is either .automobile .walking */
        /* transit any Default any */
        
        request.transportType = .any
        
        /* There may be different route from the */
        /* source to destination. So if we want to */
        /* display multiple routes then we need to */
        /* set the requestsAlternateRoutes to true. */
        /* By default is no */
        
        request.requestsAlternateRoutes = true
        
        /* Then we need to create MKDirections */
        /* object by passing the request as parameter. */
        /* This object is used to calculate resonable */
        /* route(s) from starting point to end point */
        
        let directions = MKDirections(request: request)
        
        directions.calculate { (response, error) in
            if error != nil {
                print("Error: \(error)")
                return
            }
            
            /* If there is no error then we need to */
            /* check the response for the route values */
            
            guard let routeData = response else { return }
            
            /* Here I have sort the routes by distance */
            /* in assending order if there are multiple route */
            
            let sortedRoutes = routeData.routes.sorted(by: { $0.distance > $1.distance })
            
            /* Then we loop through the sorted route and */
            /* add the polyline property to the MkRoute object */
            
            var index = 0
            for route in sortedRoutes {
                
                if index == sortedRoutes.count-1{
                    route.polyline.title = "shortest"
                }
                index += 1
                self.mapView.addOverlay(route.polyline)
//                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    
    func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
        
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        print("Source: \(request.source)")
        print("Destination: \(request.destination)")
        
        let directions = MKDirections(request: request)
        
        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            //for getting just one route
            if let route = unwrappedResponse.routes.first {
                //show on map
                self.mapView.addOverlay(route.polyline)
                //set the map area to show the route
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0), animated: true)
            }
            
            //if you want to show multiple routes then you can get all routes in a loop in the following statement
            //for route in unwrappedResponse.routes {}
        }
    }
    
    @objc func update() {
        print("Calling update method")
        if let gyroData = motionManager.gyroData {
            print("Gyroscope Data: \(gyroData)")
            var currentGForce = sqrt(gyroData.rotationRate.x * gyroData.rotationRate.x + gyroData.rotationRate.y * gyroData.rotationRate.y + gyroData.rotationRate.z * gyroData.rotationRate.z)
            
            if currentGForce > self.thtresholdGForce {
                //Show alert message -- UIAlertView
            }
        }
        
        
        if let accelerometerData = motionManager.accelerometerData {
            print("Accekerineter Data: \(accelerometerData)")
            
        }
        
        if self.currentLocation != nil {
            let destintionLocation:CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: destinationLat, longitude: destinationLon)
            //            self.showRouteOnMap(pickupCoordinate: self.currentLocation!, destinationCoordinate: destintionLocation)
            self.drawRoute(destinationCoordinate: destintionLocation)
            
        }
    }
    
    // MARK: -
    // MARK: Public Utility Methods
    
    
    // MARK: -
    // MARK: IBAction Methods Methods
    
    @IBAction func sliderGForceValueChanged(_ sender: Any) {
        self.lblGForceMin.text = "\(self.sliderGForce.minimumValue)"
        self.lblGForceCurrent.text = "\(self.sliderGForce.value)"
        self.lblGForceMax.text = "\(self.sliderGForce.maximumValue)"
        self.thtresholdGForce = Double(self.sliderGForce.value)
        
    }
    
    
    // MARK: -
    // MARK: Object Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapVC(viewDidLoad)")
        self.motionManager.startGyroUpdates()
        self.motionManager.startAccelerometerUpdates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("MapVC(viewWillAppear)")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        print("MapVC(viewDidAppear)")
        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(MapVC.update), userInfo: nil, repeats: true)
        self.loadMapView()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("MapVC(viewWillDisappear)")
        self.timer.invalidate()
        self.stopUpdatingMapLocation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("MapVC(viewDidDisappear)")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    // MARK: -
    // MARK: Delegate Methods
    
    // MARK: -
    // MARK: CLLocationManagerDelegate Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Updating location")
        let location = locations[0]
        print("locations = \(location.coordinate.latitude) \(location.coordinate.longitude)")
        //        self.mapView.centerToLocation(location)
        
        
        self.currentLocation = manager.location!.coordinate
        print("Current locations = \(currentLocation!.latitude) \(currentLocation!.longitude)")
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error\(error)")
    }
    
    // MARK: -
    // MARK: MKMapViewDelegate Methods
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 5.0
        return renderer
    }
}
