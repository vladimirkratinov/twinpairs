//
//  CollectionController.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/17.
//

import UIKit
import Gemini

class CollectionController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var collectionView: GeminiCollectionView?
    var activatedCells = [CollectionViewCell]()
    var prop = Properties()
    let palette = Palette()
    var contentLoader = ContentLoader()
    let audioFX = AudioFX()
    var temporaryIndexPath = Int()
    
    var collectionContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var hub: UIView = {
        let hub = UIView()
        hub.backgroundColor = UIColor(red: 1.00, green: 0.37, blue: 0.25, alpha: 0.5)
        hub.translatesAutoresizingMaskIntoConstraints = false
        hub.layer.borderWidth = 10
        hub.alpha = 1
        return hub
    }()

    var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView(frame: .zero)
        backgroundImageView.alpha = 1
        backgroundImageView.image = UIImage(named: FigmaKey.backgroundCardList2.rawValue)
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
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 1, right: 5)
        layout.itemSize = CGSize(width: (view.frame.width/2)-15, height: (view.frame.height/3.6))  //+15     //x6 horisontal
        layout.minimumLineSpacing = 10         //default 5
        layout.minimumInteritemSpacing = 0       //default 0

        print("layout.itemSize: \(layout.itemSize)")

        collectionView = GeminiCollectionView(frame: .zero, collectionViewLayout: layout)

        guard let collectionView = collectionView else { return }
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        collectionView.isUserInteractionEnabled = true
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .clear
//        collectionView.backgroundView = backgroundImageView
//        collectionView.frame = view.frame
        
        //implement animations:
//        configureAnimation()
        
        view.addSubview(collectionContainerView)
        collectionContainerView.addSubview(backgroundImageView)
        collectionContainerView.addSubview(collectionView)
        
//        collectionContainerView.addSubview(hub)
//        collectionContainerView.addSubview(coinLabel)
//        collectionContainerView.bringSubviewToFront(hub)
//        collectionContainerView.bringSubviewToFront(coinLabel)

        NSLayoutConstraint.activate([
            collectionContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
//            hub.leadingAnchor.constraint(equalTo: collectionContainerView.leadingAnchor),
//            hub.trailingAnchor.constraint(equalTo: collectionContainerView.trailingAnchor),
//            hub.topAnchor.constraint(equalTo: collectionContainerView.safeAreaLayoutGuide.topAnchor, constant: 0),
//            hub.widthAnchor.constraint(equalTo: collectionContainerView.widthAnchor),
//
//            coinLabel.topAnchor.constraint(equalTo: hub.topAnchor, constant: 12),
//            coinLabel.leadingAnchor.constraint(equalTo: hub.leadingAnchor, constant: 11),
            
//            collectionView.topAnchor.constraint(equalTo: hub.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: collectionContainerView.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: collectionContainerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: collectionContainerView.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: collectionContainerView.safeAreaLayoutGuide.trailingAnchor, constant: -5),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Gesture recognizer:
        navigationController?.interactivePopGestureRecognizer?.delegate = self

        //transparent NavigationBar:
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.isHidden = false
        navigationController?.isToolbarHidden = true
        navigationController?.view.backgroundColor = .clear
        navigationController?.toolbar.tintColor = .black
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        print("\(view.bounds.width) x \(view.bounds.height)")
//    }
    
    //MARK: - viewDidAppear:
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        title = ""
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isHidden = false
        navigationController?.toolbar.isHidden = true
        navigationController?.navigationBar.backItem?.backButtonTitle = ""
        
        //load Locker Mechanism in CollectionView:
        LockerModel.loadLockerModel()
        print(Properties.unlockedList)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
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
        return Properties.listOfSets.count - 2
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
        audioFX.playFirstSoundFX(name: AudioFileKey.flip1.rawValue, isMuted: Properties.soundMutedSwitcher)
        
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
            audioFX.playFirstSoundFX(name: shiny, isMuted: Properties.soundMutedSwitcher)
            
            if indexPath.item == Properties.collectionOfLockedSets[indexPath.item].cellNumber {
                //if locked:
                if Properties.collectionOfLockedSets[indexPath.item].isLocked {
                    
                    let price = Properties.collectionOfLockedSets[indexPath.item].unlockPrice
                    
                    //YES button:
                    let confirm = UIAlertAction(title: "Yes", style: .default) {_ in
                        
                        //audioFX2:
                        let magic = AudioFileKey.magic.rawValue
                        self.audioFX.playSecondSoundFX(name: magic, isMuted: Properties.soundMutedSwitcher)
                        
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
            audioFX.playFirstSoundFX(name: tinyButton, isMuted: Properties.soundMutedSwitcher)
            
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
                    
                    //update select buttons from the Shop view:
                    Properties.cardSet1isSelected = false
                    Properties.cardSet2isSelected = false
                }
            }
        }
    }
}
