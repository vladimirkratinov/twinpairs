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
    
    var titleLabel: UILabel!
    var halloweenButton: UIButton!
    var pokemonButton: UIButton!
    var partyButton: UIButton!
    var otherButton: UIButton!
    
    var time1Button: UIButton!
    var time2Button: UIButton!
    
    var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView(frame: .zero)
        backgroundImageView.alpha = 0.2
        backgroundImageView.image = UIImage(named: "pumpkinLogo")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.systemPink
        view.insertSubview(backgroundImageView, at: 0)
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.text = "Match Pair Game"
        titleLabel.font = UIFont(name: "Futura-CondensedExtraBold", size: 40)
        view.addSubview(titleLabel)
                
        halloweenButton = UIButton()
        halloweenButton.translatesAutoresizingMaskIntoConstraints = false
        halloweenButton.setTitle("Halloween", for: .normal)
        halloweenButton.setTitleColor(UIColor.black, for: .normal)
        halloweenButton.titleLabel?.font = UIFont(name: "Baskerville-Bold", size: 28)
        halloweenButton.layer.borderWidth = 3
        halloweenButton.layer.cornerRadius = 10
        halloweenButton.layer.shadowColor = UIColor.black.cgColor
        halloweenButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        halloweenButton.layer.shadowRadius = 1
        halloweenButton.layer.shadowOpacity = 1.0
        halloweenButton.isUserInteractionEnabled = true
        halloweenButton.backgroundColor = UIColor.systemOrange
        halloweenButton.layer.shouldRasterize = true
        halloweenButton.layer.rasterizationScale = UIScreen.main.scale
        halloweenButton.addTarget(self, action: #selector(halloweenButtonTapped), for: .touchUpInside)
        view.addSubview(halloweenButton)
        
        pokemonButton = UIButton()
        pokemonButton.translatesAutoresizingMaskIntoConstraints = false
        pokemonButton.alpha = 0
        pokemonButton.setTitle("Pokemon", for: .normal)
        pokemonButton.setTitleColor(UIColor.black, for: .normal)
        pokemonButton.titleLabel?.font = UIFont(name: "Baskerville-Bold", size: 30)
        pokemonButton.layer.borderWidth = 3
        pokemonButton.layer.cornerRadius = 10
        pokemonButton.layer.shadowColor = UIColor.black.cgColor
        pokemonButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        pokemonButton.layer.shadowRadius = 1
        pokemonButton.layer.shadowOpacity = 1.0
        pokemonButton.isUserInteractionEnabled = true
        pokemonButton.backgroundColor = UIColor.gray
        pokemonButton.layer.shouldRasterize = true
        pokemonButton.layer.rasterizationScale = UIScreen.main.scale
        pokemonButton.isEnabled = false
        pokemonButton.addTarget(self, action: #selector(pokemonButtonTapped), for: .touchUpInside)
        view.addSubview(pokemonButton)
        
        partyButton = UIButton()
        partyButton.translatesAutoresizingMaskIntoConstraints = false
        partyButton.alpha = 0
        partyButton.setTitle("Party", for: .normal)
        partyButton.setTitleColor(UIColor.black, for: .normal)
        partyButton.titleLabel?.font = UIFont(name: "Baskerville-Bold", size: 30)
        partyButton.layer.borderWidth = 3
        partyButton.layer.cornerRadius = 10
        partyButton.layer.shadowColor = UIColor.black.cgColor
        partyButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        partyButton.layer.shadowRadius = 1
        partyButton.layer.shadowOpacity = 1.0
        partyButton.isUserInteractionEnabled = true
        partyButton.backgroundColor = UIColor.gray
        partyButton.layer.shouldRasterize = true
        partyButton.layer.rasterizationScale = UIScreen.main.scale
        partyButton.isEnabled = false
        partyButton.addTarget(self, action: #selector(pokemonButtonTapped), for: .touchUpInside)
        view.addSubview(partyButton)
        
        otherButton = UIButton()
        otherButton.translatesAutoresizingMaskIntoConstraints = false
        otherButton.alpha = 0
        otherButton.setTitle("Other", for: .normal)
        otherButton.setTitleColor(UIColor.black, for: .normal)
        otherButton.titleLabel?.font = UIFont(name: "Baskerville-Bold", size: 30)
        otherButton.layer.borderWidth = 3
        otherButton.layer.cornerRadius = 10
        otherButton.layer.shadowColor = UIColor.black.cgColor
        otherButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        otherButton.layer.shadowRadius = 1
        otherButton.layer.shadowOpacity = 1.0
        otherButton.isUserInteractionEnabled = true
        otherButton.backgroundColor = UIColor.gray
        otherButton.layer.shouldRasterize = true
        otherButton.layer.rasterizationScale = UIScreen.main.scale
        otherButton.isEnabled = false
        otherButton.addTarget(self, action: #selector(pokemonButtonTapped), for: .touchUpInside)
        view.addSubview(otherButton)
        
        time1Button = UIButton()
        time1Button.translatesAutoresizingMaskIntoConstraints = false
        time1Button.alpha = 0
        time1Button.setTitle("60", for: .normal)
        time1Button.setTitleColor(UIColor.black, for: .normal)
        time1Button.titleLabel?.font = UIFont(name: "Baskerville-Bold", size: 30)
        time1Button.layer.borderWidth = 3
        time1Button.layer.cornerRadius = 10
        time1Button.layer.shadowColor = UIColor.black.cgColor
        time1Button.layer.shadowOffset = CGSize(width: 5, height: 5)
        time1Button.layer.shadowRadius = 1
        time1Button.layer.shadowOpacity = 1.0
        time1Button.isUserInteractionEnabled = true
        time1Button.backgroundColor = UIColor.gray
        time1Button.layer.shouldRasterize = true
        time1Button.layer.rasterizationScale = UIScreen.main.scale
        time1Button.tag = 1
        time1Button.isEnabled = true
        time1Button.isHidden = true
        time1Button.addTarget(self, action: #selector(timeButtonTapped), for: .touchUpInside)
        view.addSubview(time1Button)
        
        time2Button = UIButton()
        time2Button.translatesAutoresizingMaskIntoConstraints = false
        time2Button.alpha = 0
        time2Button.setTitle("120", for: .normal)
        time2Button.setTitleColor(UIColor.black, for: .normal)
        time2Button.titleLabel?.font = UIFont(name: "Baskerville-Bold", size: 30)
        time2Button.layer.borderWidth = 3
        time2Button.layer.cornerRadius = 10
        time2Button.layer.shadowColor = UIColor.black.cgColor
        time2Button.layer.shadowOffset = CGSize(width: 5, height: 5)
        time2Button.layer.shadowRadius = 1
        time2Button.layer.shadowOpacity = 1.0
        time2Button.isUserInteractionEnabled = true
        time2Button.backgroundColor = UIColor.gray
        time2Button.layer.shouldRasterize = true
        time2Button.layer.rasterizationScale = UIScreen.main.scale
        time2Button.tag = 2
        time2Button.isEnabled = true
        time2Button.isHidden = true
        time2Button.addTarget(self, action: #selector(timeButtonTapped), for: .touchUpInside)
        view.addSubview(time2Button)
        
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            halloweenButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            halloweenButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            halloweenButton.heightAnchor.constraint(equalToConstant: 70),
            halloweenButton.widthAnchor.constraint(equalToConstant: 170),
            
            pokemonButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pokemonButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            pokemonButton.heightAnchor.constraint(equalToConstant: 70),
            pokemonButton.widthAnchor.constraint(equalToConstant: 170),
            
            partyButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            partyButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            partyButton.heightAnchor.constraint(equalToConstant: 70),
            partyButton.widthAnchor.constraint(equalToConstant: 170),
            
            otherButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
            otherButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            otherButton.heightAnchor.constraint(equalToConstant: 70),
            otherButton.widthAnchor.constraint(equalToConstant: 170),
            
            time1Button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -50),
            time1Button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 300),
            time1Button.widthAnchor.constraint(equalToConstant: 80),
            
            time2Button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 50),
            time2Button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 300),
            time2Button.widthAnchor.constraint(equalToConstant: 80),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
//        animationButton(halloweenButton)
        
        backgroundImageView.pulsateSlow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        backgroundImageView.pulsateSlow()
    }
    
    @objc func timeButtonTapped(_ sender: UIButton) {
//        let vc = ViewController()
//
//        switch sender.tag {
//        case 1:
//            vc.timeCounter = 60
//        case 2:
//            vc.timeCounter = 120
//        default:
//            vc.timeCounter = 30
//        }
//        print(sender.tag)
//        print(vc.timeCounter ?? "Nil")
    }
    
    @objc func halloweenButtonTapped(_ sender: UIButton) {
        
        sender.flash()
        
        try? audioFX.playFX(file: AudioFileKey.buttonPress.rawValue, type: "wav")

        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "Halloween") as? ViewController else { return }
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.pushViewController(vc, animated: false)
        }
        
    }
    
    @objc func pokemonButtonTapped(_ sender: UIButton) {
        
    }
}
