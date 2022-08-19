//
//  CollectionController.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/17.
//

import UIKit

class CollectionController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    private var collectionView: UICollectionView?
    var prop = Properties()
    
    var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView(frame: .zero)
        backgroundImageView.alpha = 0.2
        backgroundImageView.image = UIImage(named: "LaunchScreen1")
        backgroundImageView.contentMode = .scaleAspectFill
//        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
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
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
//        layout.itemSize = CGSize(width: (view.frame.size.width/2)-4, height: (view.frame.size.width/2)-4)
        layout.itemSize = CGSize(width: (view.safeAreaLayoutGuide.layoutFrame.size.width/2)-4, height: (view.safeAreaLayoutGuide.layoutFrame.size.height/4))
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else { return }
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
//        collectionView.backgroundView = backgroundImageView
        
        view.addSubview(collectionView)
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return prop.cardCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        
        let label = prop.cardCollection[indexPath.item][0]
        let image = UIImage(named: label)
        
        cell.configure(label: label, image: image!)
        
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

}
