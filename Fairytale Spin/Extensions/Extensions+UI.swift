//
//  Extensions+UI.swift
//  Fairytale Spin
//
//  Created by Nick M on 18.06.2022.
//

import UIKit

extension UIApplication {
    public class func topViewController(_ base: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }   
}

extension UIView {
    func roundCorners(_ cornerRadius:CGFloat,_ clipsToBounds:Bool,_ maskedCorners:CACornerMask){
        self.clipsToBounds = clipsToBounds
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = maskedCorners
    }
    
    func setGradientLeftToRigth(_ startColor: UIColor, _ endColor: UIColor, to `where`: UIView){
        let gradient = CAGradientLayer()
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.frame = `where`.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
}

extension UIImageView {
    func rotate(duration: CGFloat){
        self.transform = CGAffineTransform.identity
        UIView.animate(withDuration: duration) {
            self.transform = CGAffineTransform(rotationAngle: Double.pi)
        }
    }
}

extension UIColor{
    static var inactiveButtonColor: UIColor?{
        self.init(named: K.inactive_button_color)
    }
    static var underLineColor: UIColor?{
        self.init(named: K.under_line_color)
    }
    class var totalPointsStartColor: UIColor{
        self.init(named: K.total_points_start_color) ?? UIColor.white
    }
    class var totalPointsEndColor: UIColor{
        self.init(named: K.total_points_end_color)  ?? UIColor.white
    }
}

extension UIProgressView {
    func downloadAnimation(interval:CGFloat, _ handler: @escaping () -> Void){
        var count:Float = 0.01
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            if count < 1.0{
                count += 0.01
            }else{
                timer.invalidate()
                handler()
            }
            self.progress = count
        }
    }
}

