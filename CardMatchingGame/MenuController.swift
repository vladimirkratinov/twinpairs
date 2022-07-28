//
//  MenuController.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/7/27.
//

import UIKit

class MenuController: UIViewController {
    
    var halloweenButton: UIButton!
    var pokemonButton: UIButton!
    
    var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView(frame: .zero)
        backgroundImageView.image = UIImage(named: "pig")
        backgroundImageView.contentMode = .scaleAspectFit
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.systemPink
        view.insertSubview(backgroundImageView, at: 0)
        
        halloweenButton = UIButton()
        halloweenButton.translatesAutoresizingMaskIntoConstraints = false
        halloweenButton.setTitle("Halloween", for: .normal)
        halloweenButton.titleLabel?.font = UIFont(name: "Baskerville-Bold", size: 30)
        halloweenButton.layer.cornerRadius = 10
        halloweenButton.layer.shadowColor = UIColor.black.cgColor
        halloweenButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        halloweenButton.layer.shadowRadius = 1
        halloweenButton.layer.shadowOpacity = 1.0
        halloweenButton.tintColor = UIColor.black
        halloweenButton.isUserInteractionEnabled = true
        halloweenButton.backgroundColor = UIColor.systemPink
        halloweenButton.layer.shouldRasterize = true
        halloweenButton.layer.rasterizationScale = UIScreen.main.scale
        halloweenButton.tag = 1
        halloweenButton.addTarget(self, action: #selector(halloweenButtonTapped), for: .touchUpInside)
        view.addSubview(halloweenButton)
        
        pokemonButton = UIButton()
        pokemonButton.translatesAutoresizingMaskIntoConstraints = false
        pokemonButton.setTitle("Pokemon", for: .normal)
        pokemonButton.titleLabel?.font = UIFont(name: "Baskerville-Bold", size: 30)
        pokemonButton.layer.cornerRadius = 10
        pokemonButton.layer.shadowColor = UIColor.black.cgColor
        pokemonButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        pokemonButton.layer.shadowRadius = 1
        pokemonButton.layer.shadowOpacity = 1.0
        pokemonButton.tintColor = UIColor.black
        pokemonButton.backgroundColor = UIColor.systemPink
        pokemonButton.layer.shouldRasterize = true
        pokemonButton.layer.rasterizationScale = UIScreen.main.scale
        pokemonButton.tag = 2
        pokemonButton.addTarget(self, action: #selector(pokemonButtonTapped), for: .touchUpInside)
        view.addSubview(pokemonButton)
        
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
//            halloweenButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            halloweenButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            halloweenButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            halloweenButton.heightAnchor.constraint(equalToConstant: 70),
            halloweenButton.widthAnchor.constraint(equalToConstant: 170),
            
//            pokemonButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            pokemonButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            pokemonButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            pokemonButton.heightAnchor.constraint(equalToConstant: 70),
            pokemonButton.widthAnchor.constraint(equalToConstant: 170),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        animationButton(halloweenButton)
    }
    
    @objc func halloweenButtonTapped(_ sender: UIButton) {
        print("tapped")
        guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "Halloween") as? ViewController else {
            print("Could not instantiate view controller with identifier of type SecondViewController")
            return
        }
        
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func pokemonButtonTapped(_ sender: UIButton) {
        
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
}
