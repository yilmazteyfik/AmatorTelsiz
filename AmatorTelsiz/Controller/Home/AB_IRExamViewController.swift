//
//  AB_IRExamViewController.swift
//  AmatorTelsiz
//
//  Created by Teyfik Yılmaz on 29.04.2024.
//

import UIKit

class AB_IRExamViewController: UIViewController {
    var examTitle: String?
    var currentQuestionIndex = 0
    var isDeneme = false

    var questions = ab_questions().getABIRQuestions()

    
    // UI Elements
    var questionLabel: UILabel!
    var optionButtons: [UIButton] = []
    var previousButton: UIButton!
    var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if(isDeneme == true){
            questions = makeRandomTest()
            print(questions.count)
        }
        
        
        // Title Label
        let titleLabel = UILabel()
        titleLabel.text = examTitle
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        // Question Label
        questionLabel = UILabel()
        questionLabel.font = UIFont.systemFont(ofSize: 18)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionLabel)
        
        questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        questionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        
        // Option Buttons
        for i in 0..<4 {
            let optionButton = UIButton(type: .system)
            optionButton.setTitle("", for: .normal)
            optionButton.tag = i
            optionButton.addTarget(self, action: #selector(optionButtonTapped(_:)), for: .touchUpInside)
            optionButton.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(optionButton)
            
            optionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            optionButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: CGFloat(10 + 50 * i)).isActive = true
            optionButtons.append(optionButton)
        }
        
        // Previous Button
        previousButton = UIButton(type: .system)
        previousButton.setTitle("Previous", for: .normal)
        previousButton.addTarget(self, action: #selector(previousButtonTapped(_:)), for: .touchUpInside)
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(previousButton)
        
        previousButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        previousButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
        // Next Button
        nextButton = UIButton(type: .system)
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton)
        
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
        // Display first question
        displayQuestion()
        updateButtonStates()
    }
    
    func displayQuestion() {
        let currentQuestion = questions[currentQuestionIndex].question
        let questionNumber = currentQuestionIndex + 1
        questionLabel.text = "\(questionNumber). \(currentQuestion)"
        
        let currentOptions = questions[currentQuestionIndex].options
        for (index, option) in currentOptions.enumerated() {
            optionButtons[index].setTitle(option, for: .normal)
        }
    }
    
    func updateButtonStates() {
        previousButton.isEnabled = currentQuestionIndex > 0
        nextButton.isEnabled = currentQuestionIndex < questions.count - 1
    }
    
    @objc func optionButtonTapped(_ sender: UIButton) {
        // Handle option selection
        // Here you can implement your logic to check the selected option
    }
    
    @objc func previousButtonTapped(_ sender: UIButton) {
        currentQuestionIndex -= 1
        displayQuestion()
        updateButtonStates()
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        currentQuestionIndex += 1
        displayQuestion()
        updateButtonStates()
    }
    func makeRandomTest() -> [Question]{
        guard questions.count >= 20 else  {
            return questions // Soru sayısı, istenilen sayıdan azsa nil döndür
        }
        var selectedQuestions: [Question] = []
        
        while selectedQuestions.count < 20 {
            let randomIndex = Int.random(in: 0..<questions.count) // Dizide rastgele bir indeks seç
            let randomQuestion = questions[randomIndex] // Rastgele seçilen soruyu al
            
            // Daha önce seçilmiş sorular arasında, aynı sorunun bulunmadığından emin olmak için özelleştirilmiş bir closure kullanılır
            if !selectedQuestions.contains(where: { $0.question == randomQuestion.question }) {
                selectedQuestions.append(randomQuestion) // Daha önce seçilmemişse diziye ekle
            }
        }
        return selectedQuestions
    }
}
