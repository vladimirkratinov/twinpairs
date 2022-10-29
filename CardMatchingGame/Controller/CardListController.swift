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
    var temporaryIndexPath = Int()

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
        backgroundImageView.alpha = 1
        backgroundImageView.image = UIImage(named: FigmaKey.backgroundCardList1.rawValue)
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Gesture recognizer:
        navigationController?.interactivePopGestureRecognizer?.delegate = self

        //transparent NavigationBar:
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.isToolbarHidden = false
        navigationController?.view.backgroundColor = .clear
        navigationController?.toolbar.tintColor = .black

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        layout.itemSize = CGSize(width: (view.frame.width/3), height: (view.frame.height/4.2))

        collectionView = GeminiCollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else { return }
        
        collectionView.register(CardListViewCell.self, forCellWithReuseIdentifier: CardListViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = true                      //stop scrollable
        collectionView.backgroundColor = .clear
        collectionView.layer.zPosition = 0
        
        configureAnimation()

        orderedNoDuplicates = NSOrderedSet(array: Properties.selectedCollection).map ({ $0 as! String})
        print(orderedNoDuplicates.count)
        
        view.addSubview(backgroundImageView)
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    //MARK: - ViewDidAppear:
    
    //ViewAnimator:
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //slide animation only after CollectionView:
        if !animationHasBeenShown {
            let fromAnimation = AnimationType.from(direction: .bottom, offset: 40)
            collectionView?.animate(animations: [fromAnimation], delay: 0, duration: 0.5)
            animationHasBeenShown = true
        }
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        title = ""
//        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        navigationController?.toolbar.isHidden = true
        navigationController?.navigationBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.animateVisibleCells()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    //MARK: - SelectTapped:
    
    @objc func selectTapped() {
        if let safeString = Properties.selectedCollection.first {
            print(safeString)
            Properties.selectedCardList = safeString
            print("Selected as main: \(safeString)")
            
            Properties.selectedCardListNumber = temporaryIndexPath
            
            print("SELECTED INDEXPATH.ITEM: \(Properties.selectedCardListNumber)")
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
            collectionView?.gemini
                .rollRotationAnimation()
                    .degree(45)
                    .rollEffect(.rollUp)
            
            //that's nice:
//            collectionView?.gemini
//                .yawRotationAnimation()
//                .yawEffect(.yawDown)
            
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
//
//    if(velocity.y > 0) {
//        //Code will work without the animation block.I am using animation block incase if you want to set any delay to it.
//        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: {
////            self.navigationController?.setNavigationBarHidden(true, animated: true)                       //NAV BAR HERE:
//            self.navigationController?.setToolbarHidden(true, animated: true)
//            print("Hide")
//        }, completion: nil)
//
//    } else {
//        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: {
////            self.navigationController?.setNavigationBarHidden(false, animated: true)                      //NAV BAR HERE:
//            self.navigationController?.setToolbarHidden(false, animated: true)
//            print("Unhide")
//        }, completion: nil)
//      }
   }
}
