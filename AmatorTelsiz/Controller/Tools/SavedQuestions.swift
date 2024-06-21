import UIKit
import Combine
import CoreData
import RealmSwift

class SavedQuestions: UIViewController {
    //MARK: - Properties
    let realm  = try! Realm()
    var examTitle: String?
    var answerIndex = 0
    var currentQuestionIndex = 0
    var isDeneme = false
    var isSaved = true

    
    var checkAnswerTimer: Timer?
    let transitionDelay: TimeInterval = 0.5 // Geçiş gecikmesi süresi (1 saniye olarak ayarlanmıştır)
    var que: Results<Question>?
    var questions = [Question]()

    private var cancellables: Set<AnyCancellable> = []
    private var answerCardViews: [AnswerCardViewCell] = []

    let titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "NONE"
        return titleLabel
    }()
    private var questionCardView: QuestionCardViewCell = {
        let view = QuestionCardViewCell(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var previousButton: UIButton = {
        let previousButton = UIButton(type: .system)
        let previousButtonImage = UIImage(systemName: "arrow.left.circle.fill")
        previousButton.setImage(previousButtonImage, for: .normal)
        previousButton.tintColor = UIColor(red: 188/255, green: 23/255, blue: 49/255, alpha: 1.0)
        previousButton.addTarget(self, action: #selector(previousButtonTapped(_:)), for: .touchUpInside)
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        return previousButton
    }()
    private var nextButton: UIButton = {
        let nextButton = UIButton(type: .system)
        let nextButtonImage = UIImage(systemName: "arrow.right.circle.fill")
        nextButton.setImage(nextButtonImage, for: .normal)
        nextButton.tintColor = UIColor(red: 188/255, green: 23/255, blue: 49/255, alpha: 1.0)
        nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        return nextButton
    }()

    private var saveButton: UIButton = {
        let button = UIButton(type: .system)
        let buttonImage = UIImage(systemName: "star.fill")
        button.setImage(buttonImage, for: .normal)
        button.tintColor = UIColor.red
        button.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    
    
    //MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false

        view.backgroundColor = .white
        que = realm.objects(Question.self)
        questions = convertResultsToArray(results: que)
        style()
        layout()
        displayQuestion()
        updateButtonStates()
        startCheckingAnswers()
        navigationController?.navigationBar.titleTextAttributes = [
                .font: UIFont.systemFont(ofSize: 14) // Küçük bir yazı tipi boyutu
            ]
        
        

        
        
    
    }
}
//MARK: - Helpers
extension SavedQuestions{
    private func style(){
        titleLabel.text = examTitle
        view.addSubview(titleLabel)
        view.addSubview(questionCardView)
        view.addSubview(previousButton)
        view.addSubview(nextButton)
        view.addSubview(saveButton)
        // Initialize Answer CardViews
        for _ in 0..<4 {
            let answerCardView = AnswerCardViewCell(frame: .zero)
            answerCardView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(answerCardView)
            answerCardViews.append(answerCardView)
        }
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        


    }
    private func layout(){
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        
        previousButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        previousButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true

        
        NSLayoutConstraint.activate([
            questionCardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            questionCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            answerCardViews[0].topAnchor.constraint(equalTo: questionCardView.bottomAnchor, constant: 20),
            answerCardViews[0].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            answerCardViews[0].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            answerCardViews[1].topAnchor.constraint(equalTo: answerCardViews[0].bottomAnchor, constant: 20),
            answerCardViews[1].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            answerCardViews[1].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            answerCardViews[2].topAnchor.constraint(equalTo: answerCardViews[1].bottomAnchor, constant: 20),
            answerCardViews[2].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            answerCardViews[2].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            answerCardViews[3].topAnchor.constraint(equalTo: answerCardViews[2].bottomAnchor, constant: 20),
            answerCardViews[3].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            answerCardViews[3].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      

            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            
        ])
        
    }
}
//MARK: - Buttons
extension SavedQuestions{
    @objc func checkTappedAnswer() {
        for answerCardView in answerCardViews {
            if answerCardView.isTapped && answerCardView.isThisAnswer {
                answerCardView.backgroundColor = correct_color
                answerCardView.answerButton.setTitleColor(.white, for: .normal)
                disableOtherAnswers()
            } else if answerCardView.isTapped {
                answerCardView.backgroundColor = false_color
                answerCardView.answerButton.setTitleColor(.white, for: .normal)
                showCorrectOption()
                disableOtherAnswers()
            }
        }
    }
    @objc func previousButtonTapped(_ sender: UIButton) {
        currentQuestionIndex -= 1
        displayQuestionWithDelay()
    }

    @objc func nextButtonTapped(_ sender: UIButton) {
        currentQuestionIndex += 1
        displayQuestionWithDelay()
        print("lolo")

    }

    @objc func swiped(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            nextQuestion()
        } else if gesture.direction == .right {
            previousQuestion()
        }
    }
    @objc func deleteButtonTapped(_ sender: UIButton) {
        let currentQuestion = questions[currentQuestionIndex]
        let ques = try! realm.objects(Question.self)

        
        // Sorunun mevcut olup olmadığını kontrol edin
        if let deleteObject = realm.objects(Question.self).filter("question == %@", currentQuestion.question).first {
            realm.beginWrite()
            realm.delete(deleteObject)
            try! realm.commitWrite()
            
            sender.setImage(UIImage(systemName: "star"), for: .normal)
            print("Deleted")
        }
        if ques.count == 0 {
            let vc = NoQuestionViewController()
            navigationController?.pushViewController(vc, animated: true)

        } else {
            sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
            currentQuestionIndex += 1
            displayQuestionWithDelay()
        }
        print("que count :\(ques.count)")


        
    }
}
//MARK: - Utilities
extension SavedQuestions{
    func showCorrectOption(){
        for answerCardView in answerCardViews {
            if answerCardView.isThisAnswer {
                answerCardView.backgroundColor = correct_color
                answerCardView.answerButton.setTitleColor(.white, for: .normal)
            }
        }
    }
    private func disableOtherAnswers() {
        for answerCardView in answerCardViews {
            answerCardView.isUserInteractionEnabled = false
        }
    }
    private func enableOtherAnswers() {
        for answerCardView in answerCardViews {
            answerCardView.isUserInteractionEnabled = true
            answerCardView.answerButton.setTitleColor(.black, for: .normal)

        }
    }
    func displayQuestion() {
        enableOtherAnswers()
        let currentQuestion = questions[currentQuestionIndex].question
        let currentAnswers = questions[currentQuestionIndex].options
        let ans = questions[currentQuestionIndex].answer
        questionCardView.configure(withQuestion: currentQuestion, number: currentQuestionIndex + 1)
        for (index, answer) in currentAnswers.enumerated() {
            if answer == ans{
                answerCardViews[index].configure(withAnswer: answer)
                answerCardViews[index].isThisAnswer = true
                answerCardViews[index].backgroundColor = .white
                answerCardViews[index].isTapped = false
                answerIndex = index
            }
            else {
                answerCardViews[index].configure(withAnswer: answer)
                answerCardViews[index].backgroundColor = .white
                answerCardViews[index].isThisAnswer = false
                answerCardViews[index].isTapped = false
            }
            answerCardViews[index].$isTapped
                .sink { [weak self] isTapped in
                    if isTapped {
                        self?.checkTappedAnswer()
                    }
                }
                .store(in: &cancellables)
        }
    }
    func updateButtonStates() {
        previousButton.isEnabled = currentQuestionIndex > 0
        nextButton.isEnabled = currentQuestionIndex < questions.count - 1
        
    }
    func nextQuestion() {
        guard currentQuestionIndex < questions.count - 1 else { return }
        currentQuestionIndex += 1
        if currentQuestionIndex + 1 <= questions.count {
            displayQuestionWithDelay()
        }
        
    }

    func previousQuestion() {
        guard currentQuestionIndex > 0 else { return }
        currentQuestionIndex -= 1
        displayQuestionWithDelay()
    }

    

    func displayQuestionWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + transitionDelay) {
            self.displayQuestion()
            self.updateButtonStates()
        }
    }

    func startCheckingAnswers() {
        checkAnswerTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkTappedAnswer), userInfo: nil, repeats: true)
    }
}