//
//  LoginVC.swift
//  DemoFeb13
//
//  Created by Chandra Jayaswal on 2/13/21.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblPassword: UILabel!
    
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    // MARK: -
    // MARK: Private Utility Methods


    fileprivate func configureView(){

    }

    private func showLoading(view:UIView, text:String){
    
    }

    private func stopLoading(fromView:UIView){

    }

    // MARK: -
    // MARK: Public Utility Methods


    // MARK: -
    // MARK: IBAction Methods Methods

    @IBAction func touchDown(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func btnRegisterAction(_ sender: Any) {
        print("Not registered!")
        let singUpVC = UIStoryboard.init(name: StoryboardName.MAIN, bundle: nil).instantiateViewController(withIdentifier: StoryboardId.SIGNUP_VC) as! SignUpVC
        self.navigationController?.pushViewController(singUpVC, animated: false)

        
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
        self.txtEmail.text = "chandra.ets@gmail.com"
        self.txtPassword.text = "chandra"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

    // MARK: -
    // MARK: Delegate Methods

    
    @IBAction func btnLoginAction(_ sender: Any) {
        let email = self.txtEmail.text!
        let password = self.txtPassword.text!
        let user = User.init(email: email, password: password)
        let validation = user.validate()
        
        if validation.status {
            print("Move to home screen")
            let demoTabbarController = UIStoryboard.init(name: StoryboardName.HOME, bundle: nil).instantiateViewController(withIdentifier: StoryboardId.DEMO_TAB_BAR) as!
            DemoTabbarController
            self.navigationController?.pushViewController(demoTabbarController, animated: false)
        } else {
            print("Validateion Fail: \(validation.message)")
            
            let alert = UIAlertController(title: "Alert", message: "\(validation.message)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
}
