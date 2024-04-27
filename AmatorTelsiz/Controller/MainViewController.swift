//
//  MainViewController.swift
//  AmatorTelsiz
//
//  Created by Teyfik Yılmaz on 27.04.2024.
//

import Foundation
import UIKit

class MainViewController : UIViewController {
  
    
    let views: [UIView] = [
            // Your existing view definitions here:
            {
                let viewUI = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0)) // Placeholder for view1
                viewUI.layer.cornerRadius = 15
                viewUI.backgroundColor = .blue
                return viewUI
            }(),
            {
                let viewUI = UIView(frame: CGRect.zero) // Placeholder for view2
                viewUI.layer.cornerRadius = 15
                viewUI.backgroundColor = .systemPink
                return viewUI
            }(),
            {
                let viewUI = UIView(frame: CGRect.zero) // Placeholder for view3
                viewUI.layer.cornerRadius = 15
                viewUI.backgroundColor = .systemRed
                return viewUI
            }()
        ]
    
    
    //MARK: - Properties
    let abButton = {
        let button = UIButton(frame: CGRect(x: 40, y: 50, width: 130, height: 40))
        button.setTitle("A/B", for: .normal)
        button.backgroundColor = .purple
        button.layer.cornerRadius = 20
        return button
    }()
   
    private var collectionView: UICollectionView!
    let cButton = {
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 170, y: 50, width: 130, height: 40))
        button.setTitle("C", for: .normal)
        button.backgroundColor = .purple
        button.layer.cornerRadius = 20
        return button
    }()
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        
    }
}

// MARK: - Helpers
extension  MainViewController{
    private func style(){
        view.backgroundColor = .gray
        abButton.addTarget(self, action: #selector(abButtonTapped), for: .touchUpInside)
        view.addSubview(abButton)
        
        cButton.addTarget(self, action: #selector(cButtonTapped), for: .touchUpInside)
        view.addSubview(cButton)
        
        //MARK: - Collection View Style
        
        let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .horizontal
                layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.width * 0.40)
                layout.minimumLineSpacing = 10 // Optional spacing between cells

                collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
                collectionView.backgroundColor = .clear // Optional background color for collection view
                collectionView.dataSource = self
                collectionView.delegate = self
                collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell") // Generic cell
                view.addSubview(collectionView)

                // Optional: Add constraints for the collection view (if needed)
                collectionView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    collectionView.topAnchor.constraint(equalTo: abButton.bottomAnchor, constant: 20),
                    collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
                    collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
                    collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])



    }
    
    
    private func layout(){

    }
}
//MARK: - Functions
extension MainViewController {
    @objc func abButtonTapped(){
        print("A/B button Tapped")
    }
    @objc func cButtonTapped(){
        print("C button Tapped")
    }
}
extension MainViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return views.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                cell.contentView.backgroundColor = views[indexPath.row].backgroundColor
                cell.contentView.layer.cornerRadius = 15
                return cell
    }
}
