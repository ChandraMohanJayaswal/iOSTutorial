//
//  GeophysicsVC.swift
//  DemoFeb13
//
//  Created by Chandra Jayaswal on 2/27/21.
//

import UIKit
import CoreMotion

class GeophysicsVC: UIViewController {
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

    
    func showShakeAlert(){
        let alert = UIAlertController(title: "Alert", message: "Shake was detected.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
            switch alertAction.style{
                case .default:
                    print("default")
                
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                @unknown default:
                    print("unknown")
            }
        }))
        self.present(alert, animated: true) {
            //If anything need to do after presenting alert view then do here otherwise just ignore it.
        }
    }

    // MARK: -
    // MARK: IBAction Methods Methods
    
    @IBAction func btnLogoutAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    @IBAction func btnCameraAction(_ sender: Any) {
        //Create the UIImage
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //Save it to the camera roll
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
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
        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(GeophysicsVC.update), userInfo: nil, repeats: true)
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
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        //
        print(motion)
        if motion == .motionShake {
           print("Shake was detected")
            self.showShakeAlert()
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        //  \
    }

    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        //
    }
    // MARK: -
    // MARK: Delegate Methods
    
    
}
