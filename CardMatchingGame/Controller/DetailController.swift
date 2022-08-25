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
    var selectedImage: String?
    
    override func loadView() {
        view = detailInterface.detailView
        view.backgroundColor = palette.imperialPrimer
        detailInterface.backgroundImageView1.contentMode = .scaleAspectFit
        detailInterface.setupSubviews()
        detailInterface.setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let notEmptyString = selectedImage {
            detailInterface.detailImageView.image = UIImage(named: notEmptyString)
            detailInterface.backgroundImageView1.image = UIImage(named: notEmptyString)
            title = ""
//            detailInterface.backgroundImageView1.addBlurEffect()
        }
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backTapped))
//        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backTapped))
//        let backButton = UIBarButtonItem(image: UIImage(named: "backArrow"), style: .plain, target: self, action: #selector(backTapped))
        navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        navigationController?.isToolbarHidden = true
//        let zoomAnimation = AnimationType.zoom(scale: 0.2)
//        detailInterface.detailImageView.animate(animations: [zoomAnimation], duration: 0.5)
        detailInterface.detailImageView.pulsateSlow()
        
//        self.detailInterface.detailImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
//        self.detailInterface.detailImageView.transform = CGAffineTransform(rotationAngle: .infinity)
//        self.detailInterface.detailImageView.alpha = 1
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animate(withDuration: 0.2, animations:  {
//            self.detailInterface.detailImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
//            self.detailInterface.detailImageView.transform = CGAffineTransform(rotationAngle: .pi/2)
//            self.detailInterface.detailImageView.alpha = 0
            
//            self.detailInterface.detailImageView.layoutIfNeeded()  //remove white flashing when animated
        })
        
        UIView.animate(withDuration: 2, animations: {
            
        })
    }
    
    //MARK: - BackTapped:
    
    @objc func backTapped(sender: UIBarButtonItem) {
        //audioFX:
        try? audioFX.playFX(file: AudioFileKey.tinyButtonPress.rawValue, type: AudioTypeKey.wav.rawValue)
        
        UIView.animate(withDuration: 0.5, animations:  {
            self.detailInterface.detailImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.detailInterface.detailImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
            self.detailInterface.detailImageView.alpha = 0
            self.detailInterface.detailImageView.layoutIfNeeded()  //remove white flashing when animated
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.navigationController?.popViewController(animated: false)
        }
    }
}
