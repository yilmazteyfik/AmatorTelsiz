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
    label.font = UIFont.boldSystemFont(ofSize: 16 )
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
    override func prepareForReuse() {
            super.prepareForReuse()

            // Restart pulse animation for the image view
        startPulseAnimation()
        }
    internal func startPulseAnimation() {
           let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
           pulseAnimation.duration = 1.5 // Animation duration
           pulseAnimation.autoreverses = true // Animate back and forth
           pulseAnimation.repeatCount = .infinity // Repeat indefinitely
           pulseAnimation.fromValue = 1.0 // Start scale value
           pulseAnimation.toValue = 1.1 // End scale value (slightly larger)
           imageView.layer.add(pulseAnimation, forKey: "pulseAnimation")
       }
    
    

    private func configureCell() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        titleLabel.textColor = .black

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -60),

            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])

        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white

        // Add shadow
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 3.0
        contentView.layer.shadowOffset = CGSize(width: 2, height: 2)
        contentView.layer.shadowOpacity = 0 // Initial opacity set to 0

        // Animate shadow opacity
        let shadowAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.shadowOpacity))
        shadowAnimation.fromValue = 0 // Start with shadow hidden
        shadowAnimation.toValue = 1 // Shadow fully visible
        shadowAnimation.duration = 1.5 // Animation duration
        shadowAnimation.autoreverses = true // Animate back and forth
        shadowAnimation.repeatCount = .infinity // Repeat indefinitely
        contentView.layer.add(shadowAnimation, forKey: "shadowOpacityAnimation")

        // Add pulse effect to the image
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 1.5 // Animation duration
        pulseAnimation.autoreverses = true // Animate back and forth
        pulseAnimation.repeatCount = .infinity // Repeat indefinitely
        pulseAnimation.fromValue = 1.0 // Start scale value
        pulseAnimation.toValue = 1.1 // End scale value (slightly larger)
        imageView.layer.add(pulseAnimation, forKey: "pulseAnimation")
    }
    }

