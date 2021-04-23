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


class MapVC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var sliderGForce: UISlider!
    @IBOutlet weak var lblGForceMin: UILabel!
    @IBOutlet weak var lblGForceCurrent: UILabel!
    @IBOutlet weak var lblGForceMax: UILabel!
    
    
    
    let motionManager = CMMotionManager()
    var locationManager = CLLocationManager()

    var timer: Timer!

    //Destination is considered as Singha Durbar
    var destinationLat = 27.6980136
    var destinationLon = 85.3238935
    
    //Current Location Test Data
    //Gokarneshwor  27.7639386, 85.347967
    //Koteshwor 27.677179, 85.326812
    //Baneshwor 27.6946835, 85.322308

    var thtresholdGForce: Double = 0.5
    var thresholdAcceleration: Double = 60.0
    
    
    
    // MARK: -
    // MARK: Private Utility Methods

     func loadMapView() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        self.mapView.showsUserLocation = true
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.startUpdatingLocation() // start location manager
        }
    }
    
    func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {

            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil))
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
            request.requestsAlternateRoutes = true
            request.transportType = .automobile

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
        self.loadMapView()
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
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("MapVC(viewWillDisappear)")
        self.timer.invalidate()
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
//        let location = locations[0]
//        print("locations = \(location.coordinate.latitude) \(location.coordinate.longitude)")
//        self.mapView.centerToLocation(location)
        /**
         
         */
        
        let currentLocation:CLLocationCoordinate2D = manager.location!.coordinate
        print("Current locations = \(currentLocation.latitude) \(currentLocation.longitude)")
        let destintionLocation:CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: destinationLat, longitude: destinationLon)
        self.showRouteOnMap(pickupCoordinate: currentLocation, destinationCoordinate: destintionLocation)
        
        
        
        self.mapView.mapType = MKMapType.standard
        let latDelta: CLLocationDegrees = 0.05
        let lonDelta: CLLocationDegrees = 0.05
        let span = MKCoordinateSpan.init(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let region = MKCoordinateRegion(center: currentLocation, span: span)
        self.mapView.setRegion(region, animated: true)

    }
}
