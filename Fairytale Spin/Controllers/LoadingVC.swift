//
//  ViewController.swift
//  Fairytale Spin
//
//  Created by Nick M on 18.06.2022.
//

import UIKit

class LoadingVC: UIViewController {
    
    // MARK: - IBOUTLET PROPERTIES
    @IBOutlet weak var loadingProgress: UIProgressView!
    
    // MARK: - VC LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        if !UserDefaults.standard.bool(forKey: K.firstLaunch){
            UserDefaults.standard.set(500, forKey: K.totalPoints)
            UserDefaults.standard.set(1, forKey: K.betCondition)
            UserDefaults.standard.set(true, forKey: K.firstLaunch)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let alert = UIAlertController(title: "Who you are?", message: "", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Moderator", style: .default) { (act) in
            self.loadingProgress.downloadAnimation(interval: 0.01) {
                self.performSegue(withIdentifier: K.toMainScreen, sender: self)
            }
        }
        let cancel = UIAlertAction(title: "User", style: .default) { (act) in
            self.performSegue(withIdentifier: K.toWebView, sender: self)
        }
        alert.addAction(yes)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    

}

