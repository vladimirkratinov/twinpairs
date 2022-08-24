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
        backgroundImageView.image = UIImage(named: ImageKey.LaunchScreen3.rawValue)
        backgroundImageView.addBlurEffect()
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()
    
    var coinLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Collections"

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
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 1
        
        //horizontal x1
//        layout.itemSize = CGSize(width: (view.frame.size.width), height: (view.frame.size.height/2))
        
        //Horizontal x6
        layout.itemSize = CGSize(width: (view.frame.size.width/2), height: (view.frame.size.height/4)-10)
        print(layout.itemSize)
        
        collectionView = GeminiCollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else { return }
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
        collectionView.backgroundColor = palette.imperialPrimer
        collectionView.backgroundView = backgroundImageView
        collectionView.isPagingEnabled = true               //stop scrolling
//

//        configureAnimation()
        
        view.addSubview(collectionView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("\(view.bounds.width) x \(view.bounds.height)")
 
    }
    
    //MARK: - viewDidAppear:
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.toolbar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //load Locker Mechanism in CollectionView:
        LockerModel.loadLockerModel()
        
        print(Properties.unlockedList)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    //MARK: - InfoTapped:
    
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
    
    //MARK: - cellForItemAt
    
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
        } else {
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
//                print("inside function")
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
                        
                        
//                        Properties.unlockedList[indexPath.item] = false
                        
                        
                        //UserDefaults 2 version:
                        let defaults = UserDefaults.standard
                        Properties.unlockedList[indexPath.item] = Properties.collectionOfLockedSets[indexPath.item].isLocked
                        print("Unlocked List Index: \(indexPath.item) \(Properties.unlockedList[indexPath.item]) = \(Properties.collectionOfLockedSets[indexPath.item].cellNumber) is \(Properties.collectionOfLockedSets[indexPath.item].isLocked) ")
                        
                        defaults.set(Properties.unlockedList, forKey: "unlockedList")
                        print(defaults.array(forKey: "unlockedList") as Any)
                        print(Properties.unlockedList)
                        
                        
                        
                        
                        //UserDefaults 1 version:
//                        LockerModel.saveData(index: indexPath.item)
//                        print(Properties.collectionOfLockedSets[indexPath.item])
                        
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
    
}

