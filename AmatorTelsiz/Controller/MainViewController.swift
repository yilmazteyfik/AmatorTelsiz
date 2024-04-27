//
//  MainViewController.swift
//  AmatorTelsiz
//
//  Created by Teyfik Yılmaz on 27.04.2024.
//

import Foundation
import UIKit

class MainViewController : UIViewController{
    let view1 = {
        let viewUI = UIView(frame: CGRect(x: 40, y: 110, width: 150, height: 120))
        viewUI.layer.cornerRadius = 15
        viewUI.backgroundColor = .blue
        return viewUI
        
    }()
    
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
        
        view.addSubview(view1)



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
