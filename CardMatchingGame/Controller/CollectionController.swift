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

    private var collectionView: GeminiCollectionView?
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Collections"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        
        //blur background image:
//        backgroundImageView.addBlurEffect()
        
//        let backButton = UIBarButtonItem(image: UIImage(named: "backArrow")?.imageFlippedForRightToLeftLayoutDirection(),
//                                         style: .plain,
//                                         target: self,
//                                         action: #selector(backTapped))
        
//        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backTapped))
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backTapped))
        navigationItem.leftBarButtonItem = backButton
        
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.layer.borderColor = UIColor.black.cgColor
        
        //transparent NavigationBar:
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: (view.frame.size.width), height: (view.frame.size.width))
        
        collectionView = GeminiCollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else { return }
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
        collectionView.backgroundColor = palette.imperialPrimer
        collectionView.backgroundView = backgroundImageView
        collectionView.isPagingEnabled = true   //stop scrolling
                
        configureAnimation()
        view.addSubview(collectionView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.isToolbarHidden = true
    }
    
    //MARK: - BackTapped:
    
    @objc func backTapped(_ sender: UIBarButtonItem) {
        
        //audioFX:
        try? audioFX.playFX(file: AudioFileKey.tinyButtonPress.rawValue, type: AudioTypeKey.wav.rawValue)
        
        UIView.animate(withDuration: 5, animations:  {
            self.collectionView?.isPagingEnabled = false
            self.collectionView?.transform = CGAffineTransform.identity
            self.configureAnimation()
            self.collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0),
                                              at: .left,
                                              animated: true)
            self.collectionView?.layoutIfNeeded()               //remove white flashing when animated
            
        })

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let transition = CATransition()
            transition.duration = 0.2
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    
    //MARK: - Configure Animations:
    
    // Gemini Animation:
    func configureAnimation() {
        collectionView?.gemini
            .cubeAnimation()
                .cubeDegree(90)
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Properties.cardCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        
        //Load Label & Image:
        let name = Properties.listOfSets[indexPath.item]
        let label = Properties.cardCollection[indexPath.item][0]
        print(label)
        if let imageString = UIImage(named: label) {
            let image = imageString
            cell.configure(label: name, image: image)
        }
        self.collectionView?.animateCell(cell)
        return cell
    }
    
    //MARK: - DidSelect:
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //audioFX:
        try? audioFX.playFX(file: AudioFileKey.flip1.rawValue, type: AudioTypeKey.wav.rawValue)
        print(indexPath.item)
        Properties.selectedSetName = Properties.listOfSets[indexPath.item]
        
        guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "CardListController") as? CardListController else { return }
        
//        vc.selectedList = Properties.cardCollection[indexPath.item]
        Properties.selectedCollection = Properties.cardCollection[indexPath.item]
        
        print("Selected Collection: \(Properties.selectedCollection.first ?? "None")")
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
   }
}
