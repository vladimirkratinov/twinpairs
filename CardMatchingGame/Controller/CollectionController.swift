//
//  CollectionController.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/17.
//

import UIKit
import Gemini
import ViewAnimator

class CollectionController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var collectionView: GeminiCollectionView?
    var activatedCells = [CollectionViewCell]()
    var prop = Properties()
    let palette = Palette()
    var contentLoader = ContentLoader()
    let audioFX = AudioFX()
    var temporaryIndexPath = Int()

    var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView(frame: .zero)
        backgroundImageView.alpha = 1
        backgroundImageView.image = UIImage(named: FigmaKey.backgroundMenu.rawValue)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()

    var coinLabel: UILabel = {
        let coinLabel = UILabel()
        coinLabel.translatesAutoresizingMaskIntoConstraints = false
        coinLabel.textColor = UIColor.black
        coinLabel.textAlignment = .left
        coinLabel.text = "🪙 \(Properties.coins)"
        coinLabel.font = UIFont(name: Properties.uiLabelsFont, size: Properties.uiLabelsSize)
        return coinLabel
    }()
    
    override func loadView() {
        super.loadView()
        //TESTING UI:

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 40, left: 5, bottom: 1, right: 5)
//        layout.itemSize = CGSize(width: (view.frame.width/2)-10, height: (view.frame.height/5)-4)           //x8 horisontal
//        layout.itemSize = CGSize(width: (view.frame.width/2)-10, height: (view.frame.height/4)+30)  //+15     //x6 horisontal
        
        
        layout.itemSize = CGSize(width: (view.frame.width/2)-10, height: (view.frame.height/3.6))  //+15     //x6 horisontal
        layout.minimumLineSpacing = 10           //default 5
        layout.minimumInteritemSpacing = 0       //default 0
        
//        horizontal x1
//        layout.itemSize = CGSize(width: (view.frame.size.width), height: (view.frame.size.height/2))
        
//        Horizontal x6
//        layout.itemSize = CGSize(width: (view.frame.size.width/2), height: (view.frame.size.height/4)-10)
        
//        layout.itemSize = CGSize(width: 150, height: 150)
        print("layout.itemSize: \(layout.itemSize)")

        collectionView = GeminiCollectionView(frame: .zero, collectionViewLayout: layout)

        guard let collectionView = collectionView else { return }
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        
        collectionView.isScrollEnabled = true
        collectionView.isUserInteractionEnabled = true
        collectionView.alwaysBounceHorizontal = true
//        collectionView.alwaysBounceVertical = true
        
        collectionView.backgroundColor = palette.imperialPrimer
        collectionView.backgroundView = backgroundImageView
        
        collectionView.frame = view.bounds
//        collectionView.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: view.bounds.height)
        
        //implement animations:
//        configureAnimation()
        
        view.addSubview(collectionView)
        view.addSubview(coinLabel)
        view.bringSubviewToFront(coinLabel)
        view.backgroundColor = palette.imperialPrimer
        
        NSLayoutConstraint.activate([
            coinLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            coinLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 5),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Gesture recognizer:
        navigationController?.interactivePopGestureRecognizer?.delegate = self

        //transparent NavigationBar:
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("\(view.bounds.width) x \(view.bounds.height)")

    }
    
    //MARK: - viewDidAppear:
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.toolbar.isHidden = true
//        navigationController?.setToolbarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //enable gestures:
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        navigationController?.toolbar.isHidden = true
//        navigationController?.setToolbarHidden(true, animated: false)
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        //load Locker Mechanism in CollectionView:
        LockerModel.loadLockerModel()
        print(Properties.unlockedList)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        navigationController?.setToolbarHidden(true, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    //MARK: - InfoTapped:
    
    @objc func infoTapped(_ sender: UIBarButtonItem) {
        let ac = AlertController.informationAC()
        present(ac, animated: true)
    }
    
    //MARK: - Configure Animations:
    
    // Gemini Animation:
    func configureAnimation() {
        //PERFECT FIT CARDS:
        collectionView!.gemini
            .circleRotationAnimation()
            .radius(860) // The radius of the circle
            .rotateDirection(.anticlockwise) // Direction of rotation.
            .itemRotationEnabled(true) // Whether the item rotates or not.
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
                
        cell.delegate = self    //Delegate (to be able to count button index depends on which cell is tapped)
        
        //updating UI Locking mechanism:
        LockerModel.updateUILockerButtons(cell: cell, index: indexPath.item)
        LockerModel.updateUISelectButtons(cell: cell, index: indexPath.item)
        
        //Load Label & Image:
        let name = Properties.listOfSets[indexPath.item]
        let label = Properties.cardCollection[indexPath.item][0]
//        let label = "label"

        if let imageString = UIImage(named: label) {
            let image = imageString
            cell.configure(label: name, image: image)
            cell.layoutSubviews()
        }
        
        self.collectionView?.animateCell(cell)
        return cell
    }

    //MARK: - DidSelectItemAt:
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected cell: \(indexPath)")
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.flip1.rawValue, isMuted: Properties.soundMutedSwitcher)
        
        Properties.selectedSetName = Properties.listOfSets[indexPath.item]
        
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CardListController") as? CardListController else { return }
        Properties.selectedCollection = Properties.cardCollection[indexPath.item]
        print("Selected Collection: \(Properties.selectedCollection.first ?? "None")")
        vc.temporaryIndexPath = indexPath.item
        
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
//MARK: - Delegate

extension CollectionController: CollectionViewCellDelegate {
    
    //MARK: - Unlock Button:
                                                                                    
    func touchUpInside(delegatedFrom cell: CollectionViewCell) {
        if let indexPath = collectionView!.indexPath(for: cell) {
            print("Button pressed in cell: \(indexPath.item)")
            
            //audioFX:
            let shiny = AudioFileKey.shiny.rawValue
            audioFX.playSoundFX(name: shiny, isMuted: Properties.soundMutedSwitcher)
            
            if indexPath.item == Properties.collectionOfLockedSets[indexPath.item].cellNumber {
                //if locked:
                if Properties.collectionOfLockedSets[indexPath.item].isLocked {
                    
                    let price = Properties.collectionOfLockedSets[indexPath.item].unlockPrice
                    
                    //YES button:
                    let confirm = UIAlertAction(title: "Open", style: .destructive) {_ in
                                                
                        //audioFX2:
                        let magic = AudioFileKey.magic.rawValue
                        self.audioFX.playAnotherSoundFX(name: magic, isMuted: Properties.soundMutedSwitcher)
                        
                        //Locker Model:
                        LockerModel.unlock(cell: cell, price: price, index: indexPath.item)
                        
                        //UPDATE UI:
                        self.coinLabel.text = "🪙 \(Properties.coins)"
                        
                        //UPDATING UI (!!!: TESTING)
                        var counter = 0
                        for case let item as CollectionViewCell in self.collectionView!.visibleCells {
                            
                            let loopPrice = Properties.collectionOfLockedSets[counter].unlockPrice
                            //price button color & mechanics:
                            if loopPrice > Properties.coins {
                                item.unlockButton.backgroundColor = .systemRed
                                item.unlockButton.alpha = 1
                                item.unlockButton.isEnabled = false
                            } else if loopPrice < Properties.coins {
                                item.unlockButton.backgroundColor = .green
                                item.unlockButton.alpha = 1
                                item.unlockButton.isEnabled = true
                            }
                            counter += 1
                        }
                    }
                    
                    let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                        Properties.collectionOfLockedSets[indexPath.item].isLocked = true
                    }
                    
                    let ac = AlertController.presentAC(confirm, cancel, price: price)
                    
                    self.present(ac, animated: true, completion: nil)
                }
            }
        }
    }
    
    //MARK: - selectButtonTapped:
    
    func selectButtonTapped(delegatedFrom cell: CollectionViewCell) {
        if let indexPath = collectionView!.indexPath(for: cell) {
            print("Button pressed in cell: \(indexPath.item)")
            
            //audioFX:
            let tinyButton = AudioFileKey.tinyButtonPress.rawValue
            audioFX.playSoundFX(name: tinyButton, isMuted: Properties.soundMutedSwitcher)
            
            if indexPath.item == Properties.collectionOfLockedSets[indexPath.item].cellNumber {
                
                //update UI:
                if !Properties.collectionOfLockedSets[indexPath.item].isSelected {
                    for case let item as CollectionViewCell in self.collectionView!.visibleCells {
                        UIView.animate(withDuration: 1.0, animations: {
                            item.selectButton.backgroundColor = self.palette.UIGreen
                            item.selectButton.setTitle("select", for: .normal)
                        })
                    }
                }
                
                //if Not locked:
                if !Properties.collectionOfLockedSets[indexPath.item].isLocked {
                    //select item:
                    LockerModel.select(cell: cell, index: indexPath.item)
                    
                    Properties.selectedSetName = Properties.listOfSets[indexPath.item]
                    Properties.selectedCollection = Properties.cardCollection[indexPath.item]
                    print("Selected Collection: \(Properties.selectedCollection.first ?? "None")")
                    temporaryIndexPath = indexPath.item
                    
                    if let safeString = Properties.selectedCollection.first {
                        Properties.selectedCardList = safeString
                        Properties.selectedCardListNumber = temporaryIndexPath
                        Properties.cardSetIsSelected = true
                    }
                }
            }
        }
    }
}
