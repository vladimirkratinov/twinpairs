//
//  DetailController.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/17.
//

import UIKit

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
        DispatchQueue.main.async {
            if let notEmptyString = self.selectedImage {
                self.detailInterface.detailImageView.image = UIImage(named: notEmptyString)
                self.detailInterface.backgroundImageView1.image = UIImage(named: notEmptyString)
                self.detailInterface.backgroundImageView2.image = UIImage(named: notEmptyString)
            }
        }
        navigationController?.navigationBar.isHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "◀ Back", style: .plain, target: self, action: #selector(backTapped))
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: false)
    }
}
