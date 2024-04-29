//
//  CustomCellBottom.swift
//  AmatorTelsiz
//
//  Created by Teyfik Yılmaz on 29.04.2024.
//
//


import Foundation
import UIKit



class CustomCellBottom: UICollectionViewCell {

  var data: CustomData! {
    didSet {
      // Update cell content based on data
      imageView.image = data.backgroundImage
      titleLabel.text = data.title
    }
  }

  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true // Clip content to rounded corners
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
    private let startSembol : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .purple
        return view
    }()
    

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textColor = .black
      
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureCell()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    override func layoutSubviews() {
            super.layoutSubviews()

            // Content view'un kenar boşluklarını ayarlama
        contentView.frame = CGRect(x: 10, y: 30, width: frame.width - 10 , height: frame.height * 0.75)
    }

  private func configureCell() {
    contentView.addSubview(imageView)
    contentView.addSubview(titleLabel)
      titleLabel.textColor = .black
      
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),

      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      
    ])

    contentView.layer.cornerRadius = 15 // Set corner radius here
    contentView.layer.masksToBounds = true // Clip content to rounded corners
      contentView.backgroundColor = .white
    // Add shadow
    contentView.layer.shadowRadius = 3.0
    contentView.layer.shadowOffset = CGSize(width: 2, height: 2)
    contentView.layer.shadowOpacity = 1

  }
}
