//
//  GyroscopeVC.swift
//  DemoFeb13
//
//  Created by Chandra Jayaswal on 2/27/21.
//

import UIKit
import CoreMotion

class GyroscopeVC: UIViewController {
    let motionManager = CMMotionManager()
    var timer: Timer!

    
    // MARK: -
    // MARK: Private Utility Methods
    
    @objc func update() {
        print("update method")
        if let accelerometerData = motionManager.accelerometerData {
            print("Accekerineter Data: \(accelerometerData)")
        }
        if let gyroData = motionManager.gyroData {
            print("Gyroscope Data: \(gyroData)")
            var gFroce = sqrt(gyroData.rotationRate.x * gyroData.rotationRate.x + gyroData.rotationRate.y * gyroData.rotationRate.y + gyroData.rotationRate.z * gyroData.rotationRate.z)
            
        }
        if let magnetometerData = motionManager.magnetometerData {
            print("Magnetometer Data: \(magnetometerData)")
        }
        if let deviceMotion = motionManager.deviceMotion {
            print("Device Motion Data: \(deviceMotion)")
        }
    }
    
    // MARK: -
    // MARK: Public Utility Methods


    // MARK: -
    // MARK: IBAction Methods Methods
    


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
        self.motionManager.startAccelerometerUpdates()
        self.motionManager.startGyroUpdates()
        self.motionManager.startMagnetometerUpdates()
        self.motionManager.startDeviceMotionUpdates()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(GyroscopeVC.update), userInfo: nil, repeats: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.timer.invalidate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

    // MARK: -
    // MARK: Delegate Methods
    
    
}
