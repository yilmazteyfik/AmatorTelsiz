//
//  QuestionCardViewCell.swift
//  AmatorTelsiz
//
//  Created by Melik Bilyay on 30.04.2024.
//

import Foundation
import UIKit

class QuestionCardViewCell: UIView {
    // UI Elements
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let questionNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 188/255, green: 23/255, blue: 49/255, alpha: 1.0)
        label.textAlignment = .left
        return label
    }()
    
    // Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // Setup UI
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
        addSubview(questionNumberLabel)
        addSubview(questionLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        questionNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionNumberLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            questionNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5)
        ])
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: questionNumberLabel.bottomAnchor, constant: 5),
            questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            questionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    // Configure Content
    func configure(withQuestion question: String, number: Int) {
        questionNumberLabel.text = "\(number)."
        questionLabel.text = question
    }
}

