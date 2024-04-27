//
//  MainQuestionBankFlowCell.swift
//  AmatorTelsiz
//
//  Created by Teyfik Yılmaz on 27.04.2024.
//

import Foundation
import UIKit



class CustomCell: UICollectionViewCell {

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
    label.font = UIFont.systemFont(ofSize: 16)
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
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
    }

  private func configureCell() {
    contentView.addSubview(imageView)
    contentView.addSubview(titleLabel)
      titleLabel.textColor = .black

    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100),

      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -60),
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
