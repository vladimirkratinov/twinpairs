//
//  CollectionController.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/17.
//

import UIKit
import Gemini
import ViewAnimator

class ShopController: UIViewController {
    
    let shopInterface = ShopInterface()
    let audioFX = AudioFX()
    let prop = Properties()
    
    override func loadView() {
        view = shopInterface.shopView
        view.insertSubview(shopInterface.backgroundImageView, at: 0)
                
        shopInterface.setupSubviews()
        shopInterface.setupConstraints()
        
        shopInterface.cardSet1ImageButton.addTarget(self, action: #selector(cardSet1ImageButtonTapped), for: .touchUpInside)
        shopInterface.cardSet2ImageButton.addTarget(self, action: #selector(cardSet2ImageButtonTapped), for: .touchUpInside)
        shopInterface.coverSet1ImageButton.addTarget(self, action: #selector(coverSet1ImageButtonTapped), for: .touchUpInside)
        shopInterface.coverSet2ImageButton.addTarget(self, action: #selector(coverSet2ImageButtonTapped), for: .touchUpInside)
        
        
        shopInterface.cardSet1UnlockButton.addTarget(self, action: #selector(cardSet1UnlockButtonTapped), for: .touchUpInside)
        shopInterface.cardSet2UnlockButton.addTarget(self, action: #selector(cardSet2UnlockButtonTapped), for: .touchUpInside)
        shopInterface.coverSet1UnlockButton.addTarget(self, action: #selector(coverSet1UnlockButtonTapped), for: .touchUpInside)
        shopInterface.coverSet2UnlockButton.addTarget(self, action: #selector(coverSet2UnlockButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    //MARK: - Images Button Tapped:
    
    @objc func cardSet1ImageButtonTapped(_ sender: UIButton) {
        //flip animation:
        if sender.imageView?.image != UIImage(named: "set6_Stamp1") {
            UIView.transition(with: sender, duration: prop.flipAnimationTime, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            sender.setImage(UIImage(named: "set6_Stamp1"), for: .normal)
        } else {
            UIView.transition(with: sender, duration: prop.flipAnimationTime, options: .transitionFlipFromRight, animations: nil, completion: nil)
            sender.setImage(UIImage(named: "stamp_back"), for: .normal)
        }
    }
    
    @objc func cardSet2ImageButtonTapped(_ sender: UIButton) {
        //flip animation:
        if sender.imageView?.image != UIImage(named: "set5_Stamp1") {
            UIView.transition(with: sender, duration: prop.flipAnimationTime, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            sender.setImage(UIImage(named: "set5_Stamp1"), for: .normal)
        } else {
            UIView.transition(with: sender, duration: prop.flipAnimationTime, options: .transitionFlipFromRight, animations: nil, completion: nil)
            sender.setImage(UIImage(named: "stamp_back"), for: .normal)
        }
    }
    
    @objc func coverSet1ImageButtonTapped(_ sender: UIButton) {
        //flip animation:
        if sender.imageView?.image != UIImage(named: FigmaKey.cardCover3.rawValue) {
            UIView.transition(with: sender, duration: prop.flipAnimationTime, options: .transitionFlipFromRight, animations: nil, completion: nil)
            sender.setImage(UIImage(named: FigmaKey.cardCover3.rawValue), for: .normal)
        } else {
            UIView.transition(with: sender, duration: prop.flipAnimationTime, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            sender.setImage(UIImage(named: "shop_cover_1"), for: .normal)
        }
        
    }
    
    @objc func coverSet2ImageButtonTapped(_ sender: UIButton) {
        //flip animation:
        if sender.imageView?.image != UIImage(named: FigmaKey.cardCover3.rawValue) {
            UIView.transition(with: sender, duration: prop.flipAnimationTime, options: .transitionFlipFromRight, animations: nil, completion: nil)
            sender.setImage(UIImage(named: FigmaKey.cardCover3.rawValue), for: .normal)
        } else {
            UIView.transition(with: sender, duration: prop.flipAnimationTime, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            sender.setImage(UIImage(named: "shop_cover_2"), for: .normal)
        }
    }
    
    //MARK: - Unlock Button Tapped:
    
    @objc func cardSet1UnlockButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
    }
    
    @objc func cardSet2UnlockButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        //transition:
    }
    
    @objc func coverSet1UnlockButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        //transition:
    }
    
    @objc func coverSet2UnlockButtonTapped(_ sender: UIButton) {
        //animation:
        sender.bounce(sender)
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.buttonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        //transition:
    }
    
}
