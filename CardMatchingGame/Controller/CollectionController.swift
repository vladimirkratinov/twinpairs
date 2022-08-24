//
//  CollectionController.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/17.
//

import UIKit
import Gemini
import ViewAnimator

class CollectionController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CollectionViewCellDelegate {

    var collectionView: GeminiCollectionView?
    var prop = Properties()
    let palette = Palette()
    var contentLoader = ContentLoader()
    let audioFX = AudioFX()
    
    var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView(frame: .zero)
        backgroundImageView.alpha = 1
        backgroundImageView.image = UIImage(named: ImageKey.CollectionBackground.rawValue)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()
    
    var coinLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Collections"
        
        loadLockerModel()

        //Large Title:
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        //Gesture recognizer:
        navigationController?.interactivePopGestureRecognizer?.delegate = self
                
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backTapped))
        let rightItem = UIBarButtonItem(image: UIImage(systemName: "questionmark.circle.fill"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(infoTapped))
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = rightItem
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.layer.borderColor = UIColor.black.cgColor
        
        //transparent NavigationBar:
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 1
//        layout.itemSize = CGSize(width: (view.frame.size.width/2), height: (view.frame.size.width/2))
        
        //changing size of collection:
        layout.itemSize = CGSize(width: (view.frame.size.width/2), height: (view.frame.size.height/4)-10)
        
        collectionView = GeminiCollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else { return }
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
        collectionView.backgroundColor = palette.imperialPrimer
        collectionView.backgroundView = backgroundImageView
        collectionView.isPagingEnabled = true               //stop scrolling

        view.addSubview(collectionView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //MARK: - CoinsTapped:
    
    @objc func infoTapped(_ sender: UIBarButtonItem) {
        
        let titleAttributes = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 25)!,
            NSAttributedString.Key.foregroundColor: UIColor.black,
        ]
        
          let titleString = NSAttributedString(string: "Information", attributes: titleAttributes)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let messageText = NSAttributedString(
            string: Properties.infoMessage,
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.foregroundColor : UIColor.black,
                NSAttributedString.Key.font : UIFont(name: "Helvetica", size: 13)!,
            ]
        )
        
        let ac = UIAlertController(title: "", message: "", preferredStyle: .alert)
        ac.setValue(titleString, forKey: "attributedTitle")
        ac.setValue(messageText, forKey: "attributedMessage")
        
        let cancel = UIAlertAction(title: "Ok", style: .cancel)
        ac.addAction(cancel)
        
        present(ac, animated: true)
    }
    
    //MARK: - BackTapped:
    
    @objc func backTapped(_ sender: UIBarButtonItem) {
        //audioFX:
        try? audioFX.playFX(file: AudioFileKey.tinyButtonPress.rawValue, type: AudioTypeKey.wav.rawValue)
        
//        UIView.animate(withDuration: 1, animations:  {
//            self.collectionView?.isPagingEnabled = false
//            self.collectionView?.transform = CGAffineTransform.identity
//            self.collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0),
//                                              at: .left,
//                                              animated: true)
//            self.collectionView?.layoutIfNeeded()               //remove white flashing when animated
//
//        })

        let transition = CATransition()
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    //MARK: - Configure Animations:
    
    // Gemini Animation:
    func configureAnimation() {
        collectionView!.gemini
            .cubeAnimation()
                .cubeDegree(90)
    }
    
    // Call animation function
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.collectionView?.animateVisibleCells()
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? CollectionViewCell {
            self.collectionView?.animateCell(cell)
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Properties.listOfSets.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        
        cell.delegate = self                                                //DELEGATE!!!
        
        //updating UI Locking mechanism:
        if Properties.collectionOfLockedSets[indexPath.item].isLocked {
            //price:
            let price = Properties.collectionOfLockedSets[indexPath.item].unlockPrice

            cell.lockerImageView.isHidden = false
            cell.unlockButton.setTitle("🪙 \(price)", for: .normal)
            cell.myLabel.isHidden = true
            cell.myImageView.alpha = 0.5
        }
        else {
            cell.lockerImageView.isHidden = true
            cell.unlockButton.isHidden = true
        }
    
        //Load Label & Image:
        let name = Properties.listOfSets[indexPath.item]
        let label = Properties.cardCollection[indexPath.item][0]

        if let imageString = UIImage(named: label) {
            let image = imageString
            cell.configure(label: name, image: image)
            cell.layoutSubviews()
        }
        
        self.collectionView?.animateCell(cell)
        return cell
    }
    
    //MARK: - Unlock Button:
                                                                                    //DELEGATE PATTERN
    func touchUpInside(delegatedFrom cell: CollectionViewCell) {
        if let indexPath = collectionView!.indexPath(for: cell) {
            print("Button pressed in cell: \(indexPath.item)")
            
            if indexPath.item == Properties.collectionOfLockedSets[indexPath.item].cellNumber {
                if Properties.collectionOfLockedSets[indexPath.item].isLocked {
                    let price = Properties.collectionOfLockedSets[indexPath.item].unlockPrice
                    let ac = UIAlertController(title: "Unlock New Card Set", message: "Are you sure you want to open it for \(price)  coins?", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
                        cell.lockerImageView.isHidden = true
                        cell.unlockButton.isHidden = true
                        cell.myLabel.isHidden = false
                        cell.myImageView.alpha = 1
                        //change property in Locker Class:
                        Properties.collectionOfLockedSets[indexPath.item].isLocked = false
                    }
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                        Properties.collectionOfLockedSets[indexPath.item].isLocked = true
                    }
                    ac.addAction(defaultAction)
                    ac.addAction(cancelAction)
                    
                    present(ac, animated: true, completion: nil)
                }
                
                print("Locker Number: \(Properties.collectionOfLockedSets[indexPath.item].cellNumber), isLocked: \(Properties.collectionOfLockedSets[indexPath.item].isLocked)")
            }
        }
    }

    //MARK: - DidSelectItemAt:
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected cell: \(indexPath)")
        //audioFX:
        try? audioFX.playFX(file: AudioFileKey.flip1.rawValue, type: AudioTypeKey.wav.rawValue)
        Properties.selectedSetName = Properties.listOfSets[indexPath.item]
        
        guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "CardListController") as? CardListController else { return }
        Properties.selectedCollection = Properties.cardCollection[indexPath.item]
        print("Selected Collection: \(Properties.selectedCollection.first ?? "None")")
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    //disable UICollectionViewCell User Interaction:
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if Properties.collectionOfLockedSets[indexPath.item].isLocked {
            return false
        } else {
            return true
        }
   }
    
    //MARK: - loadLockerModel:
    
    func loadLockerModel() {
        var price = 0
        
        for i in 0..<Properties.listOfSets.count {
            price += 5
            let lockerModel = LockerModel(cellNumber: i, isLocked: true, unlockPrice: price)
            if Properties.collectionOfLockedSets.count < Properties.listOfSets.count {
                Properties.collectionOfLockedSets.append(lockerModel)
                print(i)
            }
        }
        print("Loading Locker Model: \(Properties.collectionOfLockedSets)")
    }
}

