//
//  CardListController.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/18.
//

import UIKit

class CardListController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView: UICollectionView?
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
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else { return }
        
        collectionView.register(CardListViewCell.self, forCellWithReuseIdentifier: CardListViewCell.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
        
        view.addSubview(collectionView)
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orderedNoDuplicates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardListViewCell.identifier, for: indexPath) as? CardListViewCell else {
            fatalError("Unable to dequeue CardListViewCell")
        }
        
        let label = orderedNoDuplicates[indexPath.item]
        let image = UIImage(named: label)!

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
