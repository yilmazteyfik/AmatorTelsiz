//
//  MainViewController.swift
//  AmatorTelsiz
//
//  Created by Teyfik Yılmaz on 27.04.2024.
//

import Foundation
import UIKit
struct CustomData {
    var title: String
    var backgroundImage: UIImage
}
class MainViewController: UIViewController {

  fileprivate let data = [
    CustomData(title: "The Islands!", backgroundImage: UIImage(named: "pembekare")!),
    CustomData(title: "Collection Views!", backgroundImage: UIImage(named: "pembekare 1")!),
    CustomData(title: "MapKit!", backgroundImage: UIImage(named: "pembekare")!),
  ]

  fileprivate let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let cv = UICollectionView(frame: CGRect(x: 40, y: 170, width: UIScreen.main.bounds.width, height: 150), collectionViewLayout: layout)
    cv.translatesAutoresizingMaskIntoConstraints = false
    cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
    return cv
  }()

  //MARK: - Properties
  let abButton = {
    let button = UIButton(frame: CGRect(x: 40, y: 70, width: 130, height: 40))
    button.setTitle("A/B", for: .normal)
    button.backgroundColor = .purple
    button.layer.cornerRadius = 20
    return button
  }()

  let cButton = {
    let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 170, y: 70, width: 130, height: 40))
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
        abButton.addTarget(self, action: #selector(abButtonTapped), for: .touchUpInside)
        view.addSubview(abButton)
        
        cButton.addTarget(self, action: #selector(cButtonTapped), for: .touchUpInside)
        view.addSubview(cButton)
        
        //MARK: - Collection View Style
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self



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
extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width*0.8, height: collectionView.frame.width * 0.8)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
           cell.data = self.data[indexPath.item]

           // Apply rounded corners and shadow
           cell.contentView.layer.cornerRadius = 15 // Set desired corner radius
           cell.contentView.layer.masksToBounds = true // Clip content to rounded corners

           cell.layer.shadowColor = UIColor.black.cgColor
           cell.layer.shadowOffset = CGSize(width: 0, height: 2) // Adjust shadow offset
           cell.layer.shadowOpacity = 0.25 // Adjust shadow opacity
        return cell
    }
    
}










