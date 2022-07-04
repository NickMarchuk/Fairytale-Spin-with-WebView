//
//  WebVC.swift
//  Fairytale Spin
//
//  Created by Nick M on 04.07.2022.
//

import UIKit
import WebKit
import Combine
import AppTrackingTransparency

class WebVC: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
// MARK: - CUSTOM PROPERTIES
    private var webView: WKWebView!
    private let networkManager = NetworkManager()
    private var subscribers = Set<AnyCancellable>()
    private var alert: UIAlertController!
    private let delegate = UIApplication.shared.delegate as? AppDelegate

// MARK: - VC LIFE CYCLE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.orientation = .all
        
        requestPermission()
        
// MARK: MAIN URL
        let urlStr = "http://youtube.com"
// MARK: TEST COOCKIE
//        let urlStr = "https://www.whatismybrowser.com/detect/are-cookies-enabled"
// MARK: TEST THIRD PARTY
//        let urlStr = "https://www.whatismybrowser.com/detect/are-third-party-cookies-enabled"
// MARK: TEST JAVASCRIPT
//        let urlStr = "https://www.enable-javascript.com"
        
        let myURL = URL(string: urlStr)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
// MARK: NEED TO TEST A REAL DIVICE!
        checkConnection()
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        
//        let webPreferences = WKWebpagePreferences()
        
// MARK: JavaScript is enabled in WKWebView by default
//        webPreferences.allowsContentJavaScript = true
        
// MARK: LocalStorage is enabled in WKWebView by default
//        webConfiguration.websiteDataStore = .default()
        
//        webConfiguration.defaultWebpagePreferences = webPreferences
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    
// MARK: - METHODS
    
    fileprivate func checkConnection() {
        networkManager.$isConnected.sink { isConnected in
            DispatchQueue.main.async {
                self.showAlert(isConnected)
            }
        }.store(in: &subscribers)
    }
    
    private func showAlert(_ isConnected: Bool){
        if !isConnected{
            if !UIApplication.topViewController()!.isKind(of: UIAlertController.self) {
                alert = UIAlertController(title: "You need to be connected to the Internet", message: "", preferredStyle: .alert)
                let goSetting = UIAlertAction(title: "Go Setting", style: .default) { (act) in
                    if let settingURL = URL(string: UIApplication.openSettingsURLString){
                        if UIApplication.shared.canOpenURL(settingURL){
                            UIApplication.shared.open(settingURL){ _ in }
                        }
                    }
                }
                alert.addAction(goSetting)
                present(alert, animated: true, completion: nil)
            }
        }else{
            if let alert = alert{
                alert.dismiss(animated: true)
                
// IF NEED BE...
//                DispatchQueue.main.async {
//                    self.webView.reload()
//                }
            }
        }
    }
    
    func requestPermission() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    print("Authorized")
//                    print(advertisingIdentifier)
                case .denied:
                    print("Denied")
                case .notDetermined:
                    print("Not Determined")
                case .restricted:
                    print("Restricted")
                @unknown default:
                    print("Unknown")
                }
            }
        }
    }
    
}

