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
    
    var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView(frame: .zero)
        backgroundImageView.alpha = 0.2
        backgroundImageView.image = UIImage(named: "LaunchScreen2")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CollectionController"
        prop.cardCollection.append(prop.cardList)
        prop.cardCollection.append(prop.cardList1)
        prop.cardCollection.append(prop.cardList2)
        
        print("CardCollection Items: \(prop.cardCollection.count)")
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "◀ Back", style: .plain, target: self, action: #selector(backTapped))
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.size.width/1.2), height: (view.frame.size.width))
//        layout.itemSize = CGSize(width: (view.safeAreaLayoutGuide.layoutFrame.size.width/2)-4, height: (view.safeAreaLayoutGuide.layoutFrame.size.height/4))
        
        collectionView = GeminiCollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else { return }
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
        
        collectionView.backgroundColor = palette.wildCarribeanGrean
        collectionView.backgroundView = backgroundImageView
        
        configureAnimation()
        
        view.addSubview(collectionView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: false)
    }
    
    // Configure animation and properties
    func configureAnimation() {
        collectionView?.gemini
//            .circleRotationAnimation()
//            .radius(400)
//            .rotateDirection(.clockwise)
//            .itemRotationEnabled(true)
        
//            .rollRotationAnimation()
//                .degree(90)
//                .rollEffect(.sineWave)
        
            .cubeAnimation()
                .cubeDegree(90)
        
//            .yawRotationAnimation()
//            .yawEffect(.yawUp)
        
//            .circleRotationAnimation()
//                .radius(30) // The radius of the circle
//                .rotateDirection(.anticlockwise) // Direction of rotation.
//                .itemRotationEnabled(true) // Whether the item rotates or not.
    }
    
    // Call animation function
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView?.animateVisibleCells()
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.collectionView?.animateCell(cell)
//
//            let fromAnimation = AnimationType.from(direction: .bottom, offset: 100)
//            cell.animate(animations: [fromAnimation], delay: 0, duration: 0.3)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return prop.cardCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        
        let label = prop.cardCollection[indexPath.item][0]
        let image = UIImage(named: label)
        
        cell.configure(label: label, image: image!)
        self.collectionView?.animateCell(cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "CardListController") as? CardListController else { return }
        
        vc.selectedList = prop.cardCollection[indexPath.item]
        
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
    
    func setGradientBackground() {
        let palette = Palette()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = collectionView!.bounds
        gradientLayer.colors = [
            palette.wildCarribeanGrean.cgColor,
            palette.darkMountainMeadow.cgColor,
            palette.fuelTown.cgColor,
        ]
        collectionView?.layer.insertSublayer(gradientLayer, at: 0)
    }
}
