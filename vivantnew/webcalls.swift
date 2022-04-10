//
//  webcalls.swift
//  vivant
//
//  Created by Mihir Potnis on 11/30/21.
//

import UIKit

protocol webcallsDelegate{
    func itemsdown(lol:[Any])
    func errorrep()
}

class webcalls: NSObject { 
    
    var delegate:webcallsDelegate?
    func talk(_string:String){
        
        //_string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
       // let url = URL(string: srurl)
       
        let url = URL(string: _string)
        print(_string)
        let sess=URLSession(configuration: .default);
        let task = sess.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if error == nil {
                self.parseJson(data!)
               // return fullarr
                print("success")
            }
            else{
                print("fail")
                self.delegate?.errorrep()
            }
            
        })
        task.resume();
        print("Hello Swift")
        
        
    }
    
    func parseJson(_ data:Data){
       
        //var locarray = [String:String]()
        var fullarr = [Any]()
        do{
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            //var i=0
            
                fullarr = jsonArray
               // fullarr = jsonArray[i] as! [String : String]
                //print(locArray)
           
            
        }
        catch{
            print("error")
           
        }
        delegate?.itemsdown(lol: fullarr)
    }
}
