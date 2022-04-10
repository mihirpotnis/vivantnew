//
//  ViewController.swift
//  vivantnew
//
//  Created by Mihir Potnis on 12/14/21.
//

import UIKit

class ViewController: UIViewController, webcallsDelegate {

    @IBOutlet var mySwitch1: UISwitch!
    
    
    @IBOutlet weak var vid_chat: UIButton!
    
    @IBOutlet weak var errorstat: UILabel!
    @IBOutlet var doorstat: UILabel!
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("made it")
        let w = webcalls()
        var components = URLComponents()
        components.scheme = "http"
        components.host = "vivant-db.com"
        components.path = "/sql.php"

        components.queryItems = [
            URLQueryItem(name: "password", value: "8Am5v9Ni"),
            URLQueryItem(name: "query", value: #"SELECT DoorStatus From LockLog WHERE DoorUUID = "134f2cd6-7548-41b7-bea8-2b4d840fe3ef" ORDER BY DateTime DESC LIMIT 1;"#)
        ]
        w.delegate=self;
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { _ in
            w.talk(_string: components.string!)
            })

        
    }


    @IBAction func trial(_ sender: Any) {
    }
    
    @IBAction func switchChange(_ sender: UISwitch){
        if sender.isOn{
            print("Swtich is on")
            let w = webcalls()
            var components = URLComponents()
            components.scheme = "http"
            components.host = "vivant-db.com"
            components.path = "/sql.php"

            components.queryItems = [
                URLQueryItem(name: "password", value: "8Am5v9Ni"),
                URLQueryItem(name: "query", value: #"INSERT INTO LockLog (DoorUUID, DoorStatus) VALUES ("134f2cd6-7548-41b7-bea8-2b4d840fe3ef", "UNLOCK");"#)
            ]
            w.talk(_string: components.string!)

        }
        else{
            print("Switch is off")
            print("Swtich is on")
            let w = webcalls()
            var components = URLComponents()
            components.scheme = "http"
            components.host = "vivant-db.com"
            components.path = "/sql.php"

            components.queryItems = [
                URLQueryItem(name: "password", value: "8Am5v9Ni"),
                URLQueryItem(name: "query", value: #"INSERT INTO LockLog (DoorUUID, DoorStatus) VALUES ("134f2cd6-7548-41b7-bea8-2b4d840fe3ef", "LOCK");"#)
            ]
            w.talk(_string: components.string!)

        }
    }
    
    @IBAction func ontouch(_ sender: Any) {
        print("Button Clicked!")
        let w = webcalls()
        w.talk(_string: "http://vivant-db.com/sql.php?password=8Am5v9Ni&query=SELECT%20*%20FROM%20Users")
    }
    
    @IBAction func onvidtouch(_ sender: Any) {
        UIApplication.shared.open(NSURL(string:"https://meet.jit.si/134f2cd6-7548-41b7-bea8-2b4d840fe3ef#config.startWithAudioMuted=false&config.startWithVideoMuted=false&config.prejoinPageEnabled=false&hideShareAudioHelper=true")! as URL)
    }
    func itemsdown(lol:[Any]){
        DispatchQueue.main.async {
            let ob=lol[0]
            let stringob = (ob as! [String:String])
            let str = stringob["DoorStatus"]
            if(str=="UNLOCK"){
                self.doorstat.text="Door is Unlocked"
            }
            if(str=="LOCK"){
                self.doorstat.text = "Door is Locked"
            }

        }
    }
    
    func errorrep(){
        errorstat.text="Error"
        
    }
}

