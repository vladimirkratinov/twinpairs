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
    var prop = Properties()
       
    var selectedList = [String]()
    var orderedNoDuplicates = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "◀ Back", style: .plain, target: self, action: #selector(backTapped))
        
        orderedNoDuplicates = NSOrderedSet(array: selectedList).map ({ $0 as! String})
        
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
        
        configureAnimation()
        
        view.addSubview(collectionView)
    }
    
    //ViewAnimator:
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let fromAnimation = AnimationType.from(direction: .top, offset: 100)
        collectionView?.animate(animations: [fromAnimation], delay: 0, duration: 0.3)
        
//        let fromAnimation = AnimationType.from(direction: .top, offset: 300)
//        let zoomAnimation = AnimationType.zoom(scale: 0.5)
//        let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
//        collectionView?.animate(animations: [fromAnimation, zoomAnimation])
        
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        UIView.animate(withDuration: 1, animations:  {
            self.collectionView?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.collectionView?.transform = CGAffineTransform.identity
//            self.collectionView!.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
            self.collectionView?.alpha = 0
        })
        
//        let zoomAnimation = AnimationType.vector()
//        detailInterface.detailImageView.animate(animations: [zoomAnimation], duration: 0.7)
        
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
        let image = UIImage(named: label)!
        
        self.collectionView?.animateCell(cell)
        cell.configure(label: label, image: image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "DetailController") as? DetailController else { return }
        
        vc.selectedImage = orderedNoDuplicates[indexPath.item]
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
