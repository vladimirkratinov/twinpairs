//
//  MenuController.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/7/27.
//

import UIKit
import AVFoundation

class MenuController: UIViewController {
    
    var audioFX = AudioFX()
    let MI = MenuInterface()
    
    override func loadView() {
        view = MI.menuView
        view.backgroundColor = UIColor.systemPink
        view.insertSubview(MI.backgroundImageView, at: 0)
        
        MI.setupSubviews()
        MI.setupConstraints()
        
        MI.playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        MI.otherButton.addTarget(self, action: #selector(otherButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        //animation:
        MI.backgroundImageView.pulsateSlow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //animation:
        MI.backgroundImageView.pulsateSlow()
    }
    
    @objc func playButtonTapped(_ sender: UIButton) {
        //animation:
        sender.flash()
        
        //audioFX:
        try? audioFX.playFX(file: AudioFileKey.buttonPress.rawValue, type: "wav")

        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "Halloween") as? ViewController else { return }
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @objc func otherButtonTapped(_ sender: UIButton) {
        //animation:
        sender.flash()
        
        //audioFX:
        try? audioFX.playFX(file: AudioFileKey.buttonPress.rawValue, type: "wav")
    }
}
