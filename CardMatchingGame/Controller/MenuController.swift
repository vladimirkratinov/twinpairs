//
//  MenuController.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/7/27.
//

import UIKit
import AVFoundation

class MenuController: UIViewController {
    
    var prop = Properties()
    var audioFX = AudioFX()
    let menuInterface = MenuInterface()
    var contentLoader = ContentLoader()
    
    override func loadView() {
        view = menuInterface.menuView
        view.insertSubview(menuInterface.backgroundImageView, at: 0)
        
        menuInterface.setupSubviews()
        menuInterface.setupConstraints()
        
        menuInterface.playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        menuInterface.otherButton.addTarget(self, action: #selector(otherButtonTapped), for: .touchUpInside)
        menuInterface.collectionButton.addTarget(self, action: #selector(collectionButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        navigationController?.isToolbarHidden = true
        
        UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions(), animations: {
            self.navigationController?.setToolbarHidden(true, animated: true)
        }, completion: nil)
        
        //loadFiles:
        contentLoader.loadSet(setNumber: 1)
        contentLoader.loadSet(setNumber: 2)
        contentLoader.loadSet(setNumber: 3)
        
//        //Background AudioFX:
        let randomNumber = Int.random(in: 1...2)
        switch randomNumber {
        case 1: try? self.audioFX.playBackgroundMusic(file: AudioFileKey.Snowfall.rawValue, type: AudioTypeKey.mp3.rawValue)
        case 2: try? self.audioFX.playBackgroundMusic(file: AudioFileKey.Ceremonial.rawValue, type: AudioTypeKey.mp3.rawValue)
        default: return
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //background:
        menuInterface.setGradientBackground()
        //animation:
        menuInterface.backgroundImageView.pulsateSlow()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Background AudioFX:
        
        //Keep Playing AudioFX:
        if AudioFX.backgroundMusic != nil {
            AudioFX.backgroundMusic?.play()
            print("audio is playing")
        }    
    }
    
    @objc func playButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        try? audioFX.playFX(file: AudioFileKey.buttonPress.rawValue, type: "wav")

        let transition = CATransition()
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "GameController") as? GameController else { return }
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @objc func collectionButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        try? audioFX.playFX(file: AudioFileKey.buttonPress.rawValue, type: "wav")
        
        guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "CollectionController") as? CollectionController else { return }
        
        let transition = CATransition()
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @objc func otherButtonTapped(_ sender: UIButton) {
        //animation:
        sender.flash()
        //audioFX:
        try? audioFX.playFX(file: AudioFileKey.buttonPress.rawValue, type: "wav")
        //reset Defaults:
        resetStatisticsUserDefaults()
    }
    
    fileprivate func resetStatisticsUserDefaults() {
        let defaults = UserDefaults.standard
        defaults.set(gameInterface.timeCounter, forKey: StatisticsKey.time.rawValue)
        defaults.set(gameInterface.pairsCounter, forKey: StatisticsKey.pairs.rawValue)
        defaults.set(gameInterface.flipsCounter, forKey: StatisticsKey.flips.rawValue)
        
        print("defaults RESET!")
        print("default time: \(defaults.integer(forKey: StatisticsKey.time.rawValue))")
        print("default pairs: \(defaults.integer(forKey: StatisticsKey.pairs.rawValue))")
        print("default flips: \(defaults.integer(forKey: StatisticsKey.flips.rawValue))")
    }
}
