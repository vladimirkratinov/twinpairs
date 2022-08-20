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

//MARK: - UIImageView:

extension UIImageView {
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
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

extension UserDefaults {
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
