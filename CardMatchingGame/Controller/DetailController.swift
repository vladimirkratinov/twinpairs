//
//  DetailController.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/17.
//

import UIKit
import ViewAnimator

class DetailController: UIViewController {
    
    let detailInterface = DetailInterface()
    let audioFX = AudioFX()
    let palette = Palette()
    var prop = Properties()
    var isTapped = false
    var selectedImage: String?
    var gestureRecognizer: UITapGestureRecognizer?
    
    override func loadView() {
        view = detailInterface.detailView
        view.backgroundColor = palette.imperialPrimer
        
        detailInterface.setupSubviews()
        detailInterface.setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //gesture observer:
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(closeDetailView),
                                               name: NSNotification.Name("CloseDetailView"),
                                               object: nil)
        //gesture recognizer:
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeDetailView))
        view.addGestureRecognizer(gesture)
        self.gestureRecognizer = gesture
        
        detailInterface.detailImageButton.addTarget(self, action: #selector(cardTapped), for: .touchUpInside)

        if let notEmptyString = selectedImage {
            
            //SCALING IMAGE:
            let image = UIImage(named: notEmptyString)!
                .scaleImage(toSize: CGSize(width: 120, height: 150))
            
            detailInterface.detailImageButton.setImage(image, for: .normal)
            detailInterface.backgroundImageView.image = UIImage(named: ImageKey.envelope3.rawValue)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //animation:
        detailInterface.detailImageButton.pulsateSlow()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //MARK: - Card Tapped:
    
    @objc func cardTapped(_ sender: UIButton) {
        
        if !isTapped {
            //audioFX:
            audioFX.playSoundFX(name: AudioFileKey.flip1.rawValue, isMuted: Properties.soundMutedSwitcher)
            
            let image = UIImage(named: ImageKey.stampBackground.rawValue)?
                .scaleImage(toSize: CGSize(width: 120, height: 150))
            
            sender.setImage(image, for: .normal)
//            let imageOriginal = UIImage(named: ImageKey.envelope2.rawValue)?.withRenderingMode(.alwaysOriginal)

            //flip animation:
            UIView.transition(with: sender,
                              duration: prop.flipAnimationTime,
                              options: .transitionFlipFromRight,
                              animations: nil,
                              completion: nil)
            
            detailInterface.titleLabel.isHidden = false
            detailInterface.detailLabel.isHidden = false
            detailInterface.titleLabel.alpha = 0
            detailInterface.detailLabel.alpha = 0
            isTapped = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                UIView.animate(withDuration: 0.5, animations: {
                    self.detailInterface.titleLabel.alpha = 1
                    self.detailInterface.detailLabel.alpha = 1
                })
                self.detailInterface.detailImageButton.pulsateRemove()
            }
   
        } else {
            //audioFX
            audioFX.playSoundFX(name: AudioFileKey.flip2.rawValue, isMuted: Properties.soundMutedSwitcher)
            //pulsate:
            detailInterface.detailImageButton.pulsateSlow()
            
            //flip back:
            let image = UIImage(named: selectedImage!)!
                .scaleImage(toSize: CGSize(width: 120, height: 150))
//            let imageOriginal = UIImage(named: selectedImage!)?.withRenderingMode(.alwaysOriginal)
            
            sender.setImage(image, for: .normal)
            
            //flip back animation:
            UIView.transition(with: sender, duration: prop.flipAnimationTime, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            
            detailInterface.titleLabel.isHidden = true
            detailInterface.detailLabel.isHidden = true
            isTapped = false
        }
    }
    
    //MARK: - Dismiss Details View:
    
    @objc private func closeDetailView(_ tapGestureRecognizer: UITapGestureRecognizer) {
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.flip3.rawValue, isMuted: Properties.soundMutedSwitcher)
    
        // Remove the image view
        let location = tapGestureRecognizer.location(in: detailInterface.detailImageButton)
        guard detailInterface.detailImageButton.isHidden == false,
              !detailInterface.detailImageButton.bounds.contains(location) else {  //We need to have tapped outside of view 2
            return
        }
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
    
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.popViewController(animated: false)
        }
    }
}
