//
//  TutorialController.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022-10-28.
//

import UIKit
import Gemini

class TutorialController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate {

    var collectionView: GeminiCollectionView?
    var activatedCells = [TutorialViewCell]()
    var prop = Properties()
    let palette = Palette()
    var contentManager = ContentManager()
    let audioManager = AudioManager()
    var temporaryIndexPath = Int()
    
    var collectionContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func loadView() {
        super.loadView()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: (view.frame.width), height: (view.frame.height))
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        print("layout.itemSize: \(layout.itemSize)")

        collectionView = GeminiCollectionView(frame: .zero, collectionViewLayout: layout)

        guard let collectionView = collectionView else { return }
        collectionView.register(TutorialViewCell.self, forCellWithReuseIdentifier: TutorialViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delaysContentTouches = false
        collectionView.backgroundColor = .clear
        
        //implement animations:
        configureAnimation()
        
        view.addSubview(collectionContainerView)
        collectionContainerView.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: collectionContainerView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: collectionContainerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: collectionContainerView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: collectionContainerView.trailingAnchor),
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
        navigationController?.toolbar.isHidden = true
        navigationController?.view.backgroundColor = .clear
        navigationController?.toolbar.tintColor = .black
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("\(view.bounds.width) x \(view.bounds.height)")
    }
    
    //MARK: - viewDidAppear:
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = ""
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isHidden = false
        navigationController?.toolbar.isHidden = true
        navigationController?.navigationBar.backItem?.backButtonTitle = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
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
        self.collectionView?.animateVisibleCells()
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? CollectionViewCell {
            self.collectionView?.animateCell(cell)
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Properties.tutorialList.count
    }
    
    //MARK: - cellForItemAt
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TutorialViewCell.identifier, for: indexPath) as! TutorialViewCell
        //Load Label & Image:
        let name = Properties.tutorialList[indexPath.item]

        if let imageString = UIImage(named: name) {
            let image = imageString
            cell.configure(label: name, image: image)
            cell.layoutSubviews()
        }
        
        self.collectionView?.animateCell(cell)
        return cell
    }    
}


