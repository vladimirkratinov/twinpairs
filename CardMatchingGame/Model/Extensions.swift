//
//  UIButtonExtensions.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/7/26.
//

import UIKit

//MARK: - UIButton:

extension UIButton {
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.98
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
    
    func pulsateSlow() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 4
        pulse.fromValue = 1.01
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 1
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
    
    func pulsateRemove() {
        layer.removeAllAnimations()
    }
    
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.15
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 1
        layer.add(flash, forKey: nil)
    }
    
    func spring(_ sender: UIButton) {
        sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 1.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.3),
                       initialSpringVelocity: CGFloat(0.3),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
            sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
    }
    
    func bounce(_ sender: UIButton) {

        sender.transform = CGAffineTransform(scaleX: 0.94, y: 0.94)

        UIView.animate(withDuration: 0.3,
                                   delay: 0,
                                   usingSpringWithDamping: CGFloat(0.20),
                                   initialSpringVelocity: CGFloat(6.0),
                                   options: UIView.AnimationOptions.allowUserInteraction,
                                   animations: {
                                    sender.transform = CGAffineTransform.identity
            },
                                   completion: { Void in()  }
        )
    }
}

//MARK: - UILabel:

extension UILabel {
    
    func update(completion: (UILabel) -> Void) {
            completion(self)
        }
    
    func spring(_ sender: UILabel) {
        sender.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        UIView.animate(withDuration: 1.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.3),
                       initialSpringVelocity: CGFloat(0.3),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
            sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
    }
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.98
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
    
    func spring(label: UILabel) {
        label.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 1.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.3),
                       initialSpringVelocity: CGFloat(0.3),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
            label.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
    }
}

//MARK: - UITabBar:

extension UITabBar {
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 150
        return sizeThatFits
    }
}

//MARK: - UIImage:

extension UIImage {
    func scaleImage(toSize newSize: CGSize) -> UIImage? {
        var newImage: UIImage?
        let newRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height).integral
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        if let context = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage {
            context.interpolationQuality = .high
            let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: newSize.height)
            context.concatenate(flipVertical)
            context.draw(cgImage, in: newRect)
            if let img = context.makeImage() {
                newImage = UIImage(cgImage: img)
            }
            UIGraphicsEndImageContext()
        }
        return newImage
    }
}

//MARK: - UIImageView:

extension UIImageView {
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
    
    func shake() {
            let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            animation.duration = 0.4
            animation.values = [-10.0, 10.0, -10.0, 10.0, -5.0, 5.0, -1.0, 1.0, 0.0 ]
            layer.add(animation, forKey: "shake")
        }
    
    func rotate(angle: CGFloat) {
            let radians = angle / 180.0 * CGFloat.pi
            let rotation = self.transform.rotated(by: radians);
            self.transform = rotation
        }
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.98
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
    
    func pulsateSlow() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 4
        pulse.fromValue = 1.01
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 1
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
}

func animationButton(_ sender: UIButton) {
    sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    UIView.animate(withDuration: 2.0,
                   delay: 0,
                   usingSpringWithDamping: CGFloat(0.5),
                   initialSpringVelocity: CGFloat(0.5),
                   options: UIView.AnimationOptions.allowUserInteraction,
                   animations: {
        sender.transform = CGAffineTransform.identity
    },
                   completion: { Void in()  }
    )
}

//MARK: - UserDefaults

extension UserDefaults {
    
    enum Keys: String, CaseIterable {
        //muted buttons
        case musicIsMuted = "musicIsMuted"
        case soundIsMuted = "soundIsMuted"
        case vibrationIsMuted = "vibrationIsMuted"
        //volume level
        case musicVolumeLevel = "musicVolumeLevel"
        case soundVolumeLevel = "soundVolumeLevel"
        //colors
        case musicButton = "musicButton"
        case soundButton = "soundButton"
        case vibrationButton = "vibrationButton"
    }
    
    //preferred reset:
    static func resetDefaults() {
            if let bundleID = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: bundleID)
            }
        }
    
    func reset() {
        Keys.allCases.forEach { removeObject(forKey: $0.rawValue) }
    }
    
    enum ErrorType: Error {
        case unarchiveBug
        case archiveBug
    }
    
    func colorForKey(key: String) -> UIColor? {
        var color: UIColor?
        if let colorData = data(forKey: key) {
            do {
                color = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor
                throw ErrorType.unarchiveBug
            } catch {
                
            }
        }
        return color
    }
    
    func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
            do {
                colorData = try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) as NSData?
                throw ErrorType.archiveBug
            } catch {
                
            }
        }
        set(colorData, forKey: key)
    }
}

//MARK: - String:

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
    
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
    
    func stringToImage(_ handler: @escaping ((UIImage?)->())) {
        if let url = URL(string: self) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let image = UIImage(data: data)
                    handler(image)
                }
            }.resume()
        }
    }
}

//MARK: - INT:

extension Int {
    func times(_ f: () -> ()) {
        if self > 0 {
            for _ in 0..<self {
                f()
            }
        }
    }
    
    func times(_ f: @autoclosure () -> ()) {
        if self > 0 {
            for _ in 0..<self {
                f()
            }
        }
    }
}

extension CardListController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

extension CollectionController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        navigationController?.navigationBar.isHidden = false
        return true
    }
}
