//
//  AnswerCardViewCell.swift
//  AmatorTelsiz
//
//  Created by Melik Bilyay on 30.04.2024.
//

import Foundation
import UIKit



class AnswerCardViewCell: UIView {


    let answerButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.titleLabel?.numberOfLines = 0
        button.contentHorizontalAlignment = .left
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var isThisAnswer = false
    @Published var isTapped = false
    
    // Properties
    var answerTappedAction: (() -> Void)?
    
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
        
        addSubview(answerButton)
        setupConstraints()
        
        answerButton.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            answerButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            answerButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            answerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            answerButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    // Configure Content
    func configure(withAnswer answer: String) {
        answerButton.setTitle(answer, for: .normal)
        adjustSizeToFitText()
    }
    
    // Adjust size of the view to fit the text
    private func adjustSizeToFitText() {
        let maxSize = CGSize(width: frame.width, height: .greatestFiniteMagnitude)
        let textSize = answerButton.titleLabel?.sizeThatFits(maxSize) ?? CGSize.zero
        let newHeight = textSize.height + 55 // Add some padding
        
        // Update height constraint
        NSLayoutConstraint.deactivate(constraints.filter { $0.firstAttribute == .height })
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: newHeight)
        ])
    }
    
    // Button Action
    @objc private func answerButtonTapped() {
        isTapped = true

        answerTappedAction?()
    }
}



