import UIKit

class ExamViewController: UIViewController {
    var examTitle: String?
    var currentQuestionIndex = 0
    var questions: [String] = [
        "Sample question ?",
        "Sample question ?",
        "Sample question ?",
        "Sample question ?",
        "Sample question ?",
        "Sample question ?",
        "Sample question ?",
        "Sample question ?",
        "Sample question ?",
        "Sample question ?"
        
        
    ]
    var options: [[String]] = [
        ["Option A", "Option B", "Option C", "Option D"], 
        ["Option A", "Option B", "Option C", "Option D"],
        ["Option A", "Option B", "Option C", "Option D"],
        ["Option A", "Option B", "Option C", "Option D"],
        ["Option A", "Option B", "Option C", "Option D"],
        ["Option A", "Option B", "Option C", "Option D"],
        ["Option A", "Option B", "Option C", "Option D"],
        ["Option A", "Option B", "Option C", "Option D"],
        ["Option A", "Option B", "Option C", "Option D"],
        ["Option A", "Option B", "Option C", "Option D"]
    ]
    
    // UI Elements
    var questionLabel: UILabel!
    var optionButtons: [UIButton] = []
    var previousButton: UIButton!
    var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
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
        let currentQuestion = questions[currentQuestionIndex]
        let questionNumber = currentQuestionIndex + 1
        questionLabel.text = "\(questionNumber). \(currentQuestion)"
        
        let currentOptions = options[currentQuestionIndex]
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
}
