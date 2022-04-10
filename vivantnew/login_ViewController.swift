//
//  login_ViewController.swift
//  vivantnew
//
//  Created by Mihir Potnis on 12/23/21.
//
import LocalAuthentication
import UIKit

class login_ViewController: UIViewController, webcallsDelegate {
    
    var username_text=""
    var password_text=""
    var login_true=false
    func itemsdown(lol: [Any]) {
        
        for i in 0...(lol.endIndex-1){
            let ob=lol[i]
            let stringob = (ob as! [String:String])
            let user = stringob["Username"]
            let pass = stringob["Password"]
            
            if user==username_text && pass==password_text{
                login_true=true
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name:"Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "mainpage")
                    
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    
    func errorrep() {
        
    }
    
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var facialrecog: UIButton!
    @IBOutlet weak var password: UITextField!
   
    @IBOutlet weak var login: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onlogin(_ sender: Any) {
        username_text = username.text!
        password_text = password.text!
        let w = webcalls()
        var components = URLComponents()
        components.scheme = "http"
        components.host = "vivant-db.com"
        components.path = "/sql.php"

        components.queryItems = [
            URLQueryItem(name: "password", value: "8Am5v9Ni"),
            URLQueryItem(name: "query", value: "SELECT * FROM Users")
        ]
        w.delegate=self
        w.talk(_string: components.string!)
        
    }
    @IBAction func ontap(_ sender: Any) {
        let cont = LAContext()
        var error: NSError? = nil
        if cont.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "Didnt work"
            cont.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {[weak self] success, error in
                DispatchQueue.main.async{
                guard success, error==nil else{
                    return
                }
                    let storyboard = UIStoryboard(name:"Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "mainpage")
                    
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true, completion: nil)
                    
                }
        }
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
    
}
