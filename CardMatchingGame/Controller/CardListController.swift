//
//  CardListController.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/18.
//

import UIKit
import Gemini
import ViewAnimator

class CardListController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var collectionView: GeminiCollectionView!
    let audioFX = AudioFX()
    var prop = Properties()
    let palette = Palette()
    var selectButton = UIBarButtonItem()
    var observer: NSKeyValueObservation?
    var animationHasBeenShown = false

    static var selectedString: String = "Select" {
        didSet {
            if Properties.cardSetIsSelected {
                selectedString = "Selected"
            } else {
                selectedString = "Select"
            }
        }
    }
    
//    var selectedList = [String]()
    var orderedNoDuplicates = [String]()
    var selectedSetName = String()
    
    var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView(frame: .zero)
        backgroundImageView.alpha = 0.8
//        backgroundImageView.layer.zPosition = -1
        backgroundImageView.image = UIImage(named: ImageKey.envelope3.rawValue)
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = palette.imperialPrimer
//        let name = Properties.selectedSetName
//        title = "\(name)"
//
        
        navigationController?.toolbar.tintColor = .black
        navigationController?.toolbar.barTintColor = palette.wildCarribeanGrean
        navigationController?.toolbar.layer.zPosition = 1
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
//        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = -20
        layout.minimumInteritemSpacing = -20
        
        //vertical View x6:
        layout.itemSize = CGSize(width: (view.safeAreaLayoutGuide.layoutFrame.size.width/2)-4, height: (view.safeAreaLayoutGuide.layoutFrame.size.height/4))
        
        //horisontal View x6:
//        layout.itemSize = CGSize(width: (view.safeAreaLayoutGuide.layoutFrame.size.width/2)-4, height: (view.safeAreaLayoutGuide.layoutFrame.size.height/2.5))
        
        //horisontal View x4:
//        layout.itemSize = CGSize(width: (view.safeAreaLayoutGuide.layoutFrame.size.width/2)-4, height: (view.safeAreaLayoutGuide.layoutFrame.size.height/3)-4)
        
        collectionView = GeminiCollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else { return }
        
        collectionView.register(CardListViewCell.self, forCellWithReuseIdentifier: CardListViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = false                      //stop scrollable
        collectionView.backgroundColor = .clear
        collectionView.layer.zPosition = 0
//        collectionView.backgroundView = backgroundImageView
        
        configureAnimation()
//        backgroundImageView.addBlurEffect()
        
        var tabPanel = [UIBarButtonItem]()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        //image:
//        selectButton = UIBarButtonItem(image: UIImage(named: ImageKey.selectButton.rawValue), style: .plain, target: self, action: #selector(selectTapped))
        
        //title:
        selectButton = UIBarButtonItem(title: CardListController.selectedString, style: .plain, target: self, action: #selector(selectTapped))
        
        tabPanel.append(space)
        tabPanel.append(selectButton)
        tabPanel.append(space)
        
        toolbarItems = tabPanel
    
        
                
//        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backTapped))
////        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
////                                         style: .plain,
////                                         target: self,
////                                         action: #selector(backTapped))
//
//        navigationItem.leftBarButtonItem = backButton
        
        //transparent NavigationBar:
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = .clear
        
        //transparent Toolbar:
//        self.navigationController?.toolbar.setBackgroundImage(UIImage(), forToolbarPosition: .bottom, barMetrics: .default)
//        self.navigationController?.toolbar.shadowImage(forToolbarPosition: .bottom)
//        self.navigationController?.toolbar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = .clear
        
        orderedNoDuplicates = NSOrderedSet(array: Properties.selectedCollection).map ({ $0 as! String})
        print(orderedNoDuplicates.count)
        
        view.addSubview(backgroundImageView)
        view.addSubview(collectionView)
//        view.bringSubviewToFront(collectionView)
//        view.sendSubviewToBack(backgroundImageView)
        
//        navigationController?.toolbar.layer.zPosition = 1
//        navigationController?.toolbar.alpha = 1
//        navigationController?.toolbar.isTranslucent = false
        
//        view.bringSubviewToFront(collectionView)
//        view.sendSubviewToBack(backgroundImageView)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
//            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
//            backgroundImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
//            backgroundImageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
//            backgroundImageView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
//            backgroundImageView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
            
            
//            backgroundImageView.widthAnchor.constraint(equalToConstant: 150),
//            backgroundImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    //MARK: - ViewDidAppear:
    
    //ViewAnimator:
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.setToolbarHidden(false, animated: false)
        
        //slide animation only after CollectionView:
        if !animationHasBeenShown {
            let fromAnimation = AnimationType.from(direction: .bottom, offset: 40)
//            collectionView?.backgroundView!.animate(animations: [fromAnimation], delay: 0, duration: 0.5)
            collectionView?.animate(animations: [fromAnimation], delay: 0, duration: 0.5)
            animationHasBeenShown = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: false)

        collectionView?.animateVisibleCells()
        
        UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions(), animations: {
//            self.navigationController?.setNavigationBarHidden(false, animated: true)                      //NAV BAR HERE:
//            self.navigationController?.setToolbarHidden(false, animated: true)
        }, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //DON'T TOUCH THIS!:
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //MARK: - SelectTapped:
    
    @objc func selectTapped() {
        if let safeString = Properties.selectedCollection.first {
            Properties.selectedCardList = safeString
            print("Selected as main: \(safeString)")
            navigationController?.toolbar.barTintColor = palette.fuelTown
            selectButton.title = "Selected!"
            Properties.cardSetIsSelected = true
            print(Properties.cardSetIsSelected)
        }
    }
    
    //MARK: - BackTapped:
    
    @objc func backTapped(sender: UIBarButtonItem) {
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.tinyButtonPress.rawValue, isMuted: Properties.soundMutedSwitcher)
        
        UIView.animate(withDuration: 1, animations:  {
            self.collectionView?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.collectionView?.transform = CGAffineTransform.identity
            self.collectionView?.alpha = 0
            self.collectionView?.layoutIfNeeded()   //remove white flashing when animated
        })
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.navigationController?.view.layer.add(transition, forKey: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orderedNoDuplicates.count
    }
    
    //MARK: - Configure Animations Gemini:
    
    // Configure animation and properties
        func configureAnimation() {
//            collectionView?.gemini
//                .rollRotationAnimation()
//                    .degree(45)
//                    .rollEffect(.rollUp)
            
            //that's nice:
            collectionView?.gemini
                .yawRotationAnimation()
//                .degree(180)
                .yawEffect(.yawDown)
            
//            collectionView.gemini
//                .circleRotationAnimation()
//                .radius(800)
//                .rotateDirection(.anticlockwise)
//                .itemRotationEnabled(true)
        }

        // Call animation function
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            collectionView?.animateVisibleCells()
            
            //Hide small title when scroll down:
//            let heightForCollapsedNav = UINavigationController().navigationBar.frame.size.height
//            let navHeight = navigationController?.navigationBar.frame.size.height
//            let name = Properties.selectedSetName
//            navigationController?.navigationBar.topItem?.title = navHeight ?? 44 <= heightForCollapsedNav  ? "" : "\(name)"
        }
            
    //adapt animation Immediately
        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            if let cell = cell as? CardListViewCell {
                self.collectionView?.animateCell(cell)
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardListViewCell.identifier, for: indexPath) as? CardListViewCell else { fatalError("Unable to dequeue CardListViewCell") }
        let label = orderedNoDuplicates[indexPath.item]
        if let imageString = UIImage(named: label) {
            let image = imageString
            let cleanName = label
                .deletingSuffix(".png")
                .deletingPrefix("set")
            let dropNumber = cleanName.dropFirst()
            let dropLine = dropNumber.dropFirst()
            let replaceLinesWithSpaces = dropLine.replacingOccurrences(of: "_", with: " ")
            let cleanString = replaceLinesWithSpaces
                
            cell.configure(label: cleanString, image: image)
        }
        
        //adapt animation immediately
        self.collectionView?.animateCell(cell)
        return cell
    }
    //MARK: - DidSelect:
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //audioFX:
        audioFX.playSoundFX(name: AudioFileKey.flip2.rawValue, isMuted: Properties.soundMutedSwitcher)
        
        guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "DetailController") as? DetailController else { return }
        
        vc.selectedImage = orderedNoDuplicates[indexPath.item]
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(vc, animated: false)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

    if(velocity.y > 0) {
        //Code will work without the animation block.I am using animation block incase if you want to set any delay to it.
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: {
//            self.navigationController?.setNavigationBarHidden(true, animated: true)                       //NAV BAR HERE:
            self.navigationController?.setToolbarHidden(true, animated: true)
            print("Hide")
        }, completion: nil)

    } else {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: {
//            self.navigationController?.setNavigationBarHidden(false, animated: true)                      //NAV BAR HERE:
            self.navigationController?.setToolbarHidden(false, animated: true)
            print("Unhide")
        }, completion: nil)
      }
   }
}
