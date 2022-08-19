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
    var selectedImage: String?
    
    override func loadView() {
        view = detailInterface.detailView
        view.backgroundColor = UIColor.white
        detailInterface.setupSubviews()
        detailInterface.setupConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let notEmptyString = selectedImage {
            detailInterface.detailImageView.image = UIImage(named: notEmptyString)
            detailInterface.backgroundImageView1.image = UIImage(named: notEmptyString)
            detailInterface.backgroundImageView2.image = UIImage(named: notEmptyString)
        }
            
        navigationController?.navigationBar.isHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "◀ Back", style: .plain, target: self, action: #selector(backTapped))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let zoomAnimation = AnimationType.zoom(scale: 0.2)
        detailInterface.detailImageView.animate(animations: [zoomAnimation], duration: 0.5)
        detailInterface.detailImageView.pulsateSlow()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        UIView.animate(withDuration: 0.5, animations:  {
            self.detailInterface.detailImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.detailInterface.detailImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
            self.detailInterface.detailImageView.alpha = 0
        })
        
//        let zoomAnimation = AnimationType.vector()
//        detailInterface.detailImageView.animate(animations: [zoomAnimation], duration: 0.7)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.navigationController?.popViewController(animated: false)
        }
    }
}
