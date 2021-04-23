//
//  HomeVC.swift
//  DemoFeb13
//
//  Created by Chandra Jayaswal on 2/27/21.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var sllider: UISlider!
    @IBOutlet weak var lblSliderValue: UILabel!
    @IBOutlet weak var viewDraw: UIView!
    
    
    // MARK: -
    // MARK: Private Utility Methods

    // MARK: -
    // MARK: Public Utility Methods


    // MARK: -
    // MARK: IBAction Methods Methods
    
    @IBAction func btnMenuAction(_ sender: Any) {
        let menuVC = UIStoryboard.init(name: StoryboardName.HOME, bundle: nil).instantiateViewController(withIdentifier: StoryboardId.MENU_VC) as!
        MenuVC
        menuVC.modalTransitionStyle = .crossDissolve
        menuVC.modalPresentationStyle = .fullScreen
        self.present(menuVC, animated: false) {
            print("MenuVC displayed")
        }
        
    }
    @IBAction func btnLogoutAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        self.lblSliderValue.text = "\(self.sllider.value)"
    }
    
    @IBAction func btnScreenShotAction(_ sender: Any) {
        
    }
    
    @IBAction func longPressInDrawArea(_ sender: Any) {
//        self.viewDraw.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
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
        print("HomeVC(viewDidLoad)")
        self.lblSliderValue.text = "\(self.sllider.value)"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("HomeVC(viewWillAppear)")

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        print("HomeVC(viewDidAppear)")

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("HomeVC(viewWillDisappear)")

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("HomeVC(viewDidDisappear)")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

    // MARK: -
    // MARK: Delegate Methods
    
    
}
