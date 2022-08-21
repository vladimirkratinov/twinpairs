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
    
    var collectionView: GeminiCollectionView?
//    var prop = Properties()
    let audioFX = AudioFX()
    var prop = Properties()
    let palette = Palette()
    
//    var selectedList = [String]()
    var orderedNoDuplicates = [String]()
    var selectedSetName = String()
    
    var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView(frame: .zero)
        backgroundImageView.alpha = 0.1
        backgroundImageView.image = UIImage(named: "LaunchScreen2")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = Properties.selectedSetName
        
        
        print(name)
        
        title = "\(name)"
//        navigationController?.navigationBar.isHidden = false
//        navigationController?.isToolbarHidden = false
        
        var tabPanel = [UIBarButtonItem]()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let selectButton = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(selectTapped))
//        let selectButton = UIBarButtonItem(image: UIImage(named: "selectButton"),
//                                     style: .plain,
//                                     target: self,
//                                     action: #selector(selectTapped))
        tabPanel.append(space)
        tabPanel.append(selectButton)
        tabPanel.append(space)
        
        self.toolbarItems = tabPanel
        
        navigationController?.toolbar.tintColor = .brown
        navigationController?.toolbar.sizeThatFits(CGSize(width: 150, height: 220))
        
//        let backButton = UIBarButtonItem(image: UIImage(named: "backArrow"),
//                                         style: .plain,
//                                         target: self,
//                                         action: #selector(backTapped))
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backTapped))
        navigationItem.leftBarButtonItem = backButton
        
        //transparent NavigationBar:
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        //transparent NavigationBar:
        self.navigationController?.toolbar.setBackgroundImage(UIImage(), forToolbarPosition: .bottom, barMetrics: .default)
        self.navigationController?.toolbar.shadowImage(forToolbarPosition: .bottom)
        self.navigationController?.toolbar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        orderedNoDuplicates = NSOrderedSet(array: Properties.selectedCollection).map ({ $0 as! String})
        print(orderedNoDuplicates.count)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
//        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
//        layout.itemSize = CGSize(width: (view.frame.size.width/2)-4, height: (view.frame.size.height/4))
        layout.itemSize = CGSize(width: (view.safeAreaLayoutGuide.layoutFrame.size.width/2)-4, height: (view.safeAreaLayoutGuide.layoutFrame.size.height/4))
        
        collectionView = GeminiCollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else { return }
        
        collectionView.register(CardListViewCell.self, forCellWithReuseIdentifier: CardListViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
        collectionView.backgroundColor = UIColor.white
//        collectionView.backgroundView = backgroundImageView
        
        configureAnimation()
        
        view.addSubview(collectionView)
    }
    
    //MARK: - ViewDidAppear:
    
    //ViewAnimator:
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions(), animations: {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.navigationController?.setToolbarHidden(false, animated: true)
        }, completion: nil)
        
//        navigationController?.isToolbarHidden = false
        let fromAnimation = AnimationType.from(direction: .bottom, offset: 20)
        collectionView?.animate(animations: [fromAnimation], delay: 0, duration: 0.3)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //MARK: - SelectTapped:
    
    @objc func selectTapped() {
        if let safeString = Properties.selectedCollection.first {
            Properties.selectedCardList = safeString
            print("Selected as main: \(safeString)")
        }
    }
    
    //MARK: - BackTapped:
    
    @objc func backTapped(sender: UIBarButtonItem) {
        //audioFX:
        try? audioFX.playFX(file: AudioFileKey.tinyButtonPress.rawValue, type: AudioTypeKey.wav.rawValue)
        
        UIView.animate(withDuration: 1, animations:  {
            self.collectionView?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.collectionView?.transform = CGAffineTransform.identity
            self.collectionView?.alpha = 0
        })

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
                        
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orderedNoDuplicates.count
    }
    
    // Configure animation and properties
        func configureAnimation() {
            collectionView?.gemini
                .rollRotationAnimation()
                    .degree(45)
                    .rollEffect(.rollUp)
        }

        // Call animation function
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            collectionView?.animateVisibleCells()
        }

        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            if let cell = cell as? GeminiCell {
                self.collectionView?.animateCell(cell)
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardListViewCell.identifier, for: indexPath) as? CardListViewCell else {
            fatalError("Unable to dequeue CardListViewCell")
        }
        
        let label = orderedNoDuplicates[indexPath.item]
        if let imageString = UIImage(named: label) {
            let image = imageString
            cell.configure(label: label, image: image)
        }
        self.collectionView?.animateCell(cell)
        return cell
    }
    //MARK: - DidSelect:
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //audioFX:
        try? audioFX.playFX(file: AudioFileKey.flip2.rawValue, type: AudioTypeKey.wav.rawValue)
        
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

    if(velocity.y>0) {
        //Code will work without the animation block.I am using animation block incase if you want to set any delay to it.
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            self.navigationController?.setToolbarHidden(true, animated: true)
            print("Hide")
        }, completion: nil)

    } else {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.navigationController?.setToolbarHidden(false, animated: true)
            print("Unhide")
        }, completion: nil)
      }
   }
}
