//
//  webviewcontroller.swift
//  vivantnew
//
//  Created by Mihir Potnis on 12/29/21.
//


import UIKit
import WebKit

class webviewcontroller: UIViewController {
    
    let webView: WKWebView = {
        let prefren = WKWebpagePreferences()
        prefren.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefren
        let webView = WKWebView(frame: .zero,
                                configuration: config)
        return webView
    }()
    override func loadView() {

           let userScriptURL = Bundle.main.url(forResource: "Userscript", withExtension: "js")!

           let userScriptCode = try! String(contentsOf: userScriptURL)

           let userScript = WKUserScript(source: userScriptCode, injectionTime: .atDocumentStart, forMainFrameOnly: false)

           let webConfiguration = WKWebViewConfiguration()

           webConfiguration.userContentController.addUserScript(userScript)
   }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)

        guard let url = URL(string:"https://meet.jit.si/134f2cd6-7548-41b7-bea8-2b4d840fe3ef#config.startWithAudioMuted=false&config.startWithVideoMuted=false&config.prejoinPageEnabled=false&hideShareAudioHelper=true")else{
            return
        }
        webView.load(URLRequest(url:url))
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
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


    


