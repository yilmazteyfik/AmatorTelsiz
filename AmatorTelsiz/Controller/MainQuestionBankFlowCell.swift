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

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = .white
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

  private func configureCell() {
    contentView.addSubview(imageView)
    contentView.addSubview(titleLabel)

    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
    ])

    contentView.layer.cornerRadius = 15 // Set corner radius here
    contentView.layer.masksToBounds = true // Clip content to rounded corners

    // Add shadow
    contentView.layer.shadowRadius = 3.0
    contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
    contentView.layer.shadowOpacity = 0.25

  }
}
