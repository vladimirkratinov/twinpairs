////
////  SetupButtons.swift
////  CardMatchingGame
////
////  Created by Vladimir Kratinov on 2022/7/29.
////
//
//import UIKit

//        rowCounter = 4
//        columnCounter = 3
//        widthCounter = 130
//        heightCounter = 180
//
//        setupButtons(rowCounter: 2, columnCounter: 3, widthCounter: 130, heightCounter: 180)
//        setupButtons(rowCounter: 5, columnCounter: 4, widthCounter: 100, heightCounter: 140)
//
////MARK: - Setup Buttons:
//
//func setupButtons(rowCounter: Int, columnCounter: Int, widthCounter: Int, heightCounter: Int) {
//    buttonsView = UIView()
//    buttonsView.translatesAutoresizingMaskIntoConstraints = false
//    view.addSubview(buttonsView)
//
//    for row in 0..<rowCounter {
//        for column in 0..<columnCounter {
//            cardButton = UIButton(type: .system)
//            cardButton.setTitleColor(UIColor.clear, for: .normal)
//            cardButton.layer.borderWidth = 3
//            cardButton.layer.cornerRadius = 10
//            cardButton.layer.borderColor = UIColor.systemBrown.cgColor
//            cardButton.tintColor = UIColor.orange
//            cardButton.setImage(UIImage(named: "Spider"), for: .normal)
//            cardButton.backgroundColor = UIColor(patternImage: UIImage(named: "CardBack")!)
//            cardButton.addTarget(self, action: #selector(cardTapped), for: .touchUpInside)
//            let frame = CGRect(x: column * widthCounter, y: row * heightCounter, width: widthCounter, height: heightCounter)
//            cardButton.frame = frame
//
//            cardButtons.append(cardButton)
//            buttonsView.addSubview(cardButton)
//        }
//    }
//
//    NSLayoutConstraint.activate([
//        buttonsView.widthAnchor.constraint(equalToConstant: 400),
//        buttonsView.heightAnchor.constraint(equalToConstant: 800),
//        buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 3),
//        buttonsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
//        buttonsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20),
//        ])
//}
//
////MARK: - updateUI:
//
//func updateUI() {
//    DispatchQueue.main.async {
//        self.buttonsView.removeFromSuperview()
//        self.cardButton.removeFromSuperview()
//        self.setupButtons(rowCounter: 5, columnCounter: 4, widthCounter: 100, heightCounter: 140)
//    }
//}
