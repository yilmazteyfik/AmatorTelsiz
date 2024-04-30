import UIKit

class AB_IExamViewController: UIViewController {
    var examTitle: String?
    var currentQuestionIndex = 0
    var isDeneme = false
    let transitionDelay: TimeInterval = 0.5 // Geçiş gecikmesi süresi (1 saniye olarak ayarlanmıştır)

    var questions = ab_questions().getABIsletmeQuestions()


    private var questionCardView: QuestionCardViewCell!
    private var answerCardViews: [AnswerCardViewCell] = []
    private var previousButton: UIButton!
    private var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if isDeneme {
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

        // Initialize Question CardView
        questionCardView = QuestionCardViewCell(frame: .zero)
        questionCardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionCardView)

        // Initialize Answer CardViews
        for _ in 0..<4 {
            let answerCardView = AnswerCardViewCell(frame: .zero)
            answerCardView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(answerCardView)
            answerCardViews.append(answerCardView)
        }

        // Previous Button
        previousButton = UIButton(type: .system)
        let previousButtonImage = UIImage(systemName: "arrow.left.circle.fill")
        previousButton.setImage(previousButtonImage, for: .normal)
        previousButton.tintColor = UIColor(red: 188/255, green: 23/255, blue: 49/255, alpha: 1.0)
        previousButton.addTarget(self, action: #selector(previousButtonTapped(_:)), for: .touchUpInside)
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(previousButton)

        previousButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        previousButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true

        // Next Button
        nextButton = UIButton(type: .system)
        let nextButtonImage = UIImage(systemName: "arrow.right.circle.fill")
        nextButton.setImage(nextButtonImage, for: .normal)
        nextButton.tintColor = UIColor(red: 188/255, green: 23/255, blue: 49/255, alpha: 1.0)
        nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton)

        // Swipe Gesture Recognizer
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)

        // Display first question
        displayQuestion()
        updateButtonStates()

        // Layout Constraints
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

    func displayQuestion() {
        let currentQuestion = questions[currentQuestionIndex].question
        let currentAnswers = questions[currentQuestionIndex].options
        questionCardView.configure(withQuestion: currentQuestion, number: currentQuestionIndex + 1)
        for (index, answer) in currentAnswers.enumerated() {
            answerCardViews[index].configure(withAnswer: answer)
        }
    }

    func updateButtonStates() {
        previousButton.isEnabled = currentQuestionIndex > 0
        nextButton.isEnabled = currentQuestionIndex < questions.count - 1
    }

    @objc func previousButtonTapped(_ sender: UIButton) {
        currentQuestionIndex -= 1
        displayQuestionWithDelay()
    }

    @objc func nextButtonTapped(_ sender: UIButton) {
        currentQuestionIndex += 1
        displayQuestionWithDelay()
    }

    @objc func swiped(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            nextQuestion()
        } else if gesture.direction == .right {
            previousQuestion()
        }
    }

    func nextQuestion() {
        guard currentQuestionIndex < questions.count - 1 else { return }
        currentQuestionIndex += 1
        displayQuestionWithDelay()
    }

    func previousQuestion() {
        guard currentQuestionIndex > 0 else { return }
        currentQuestionIndex -= 1
        displayQuestionWithDelay()
    }

    func makeRandomTest() -> [Question] {
        guard questions.count >= 20 else  {
            return questions
        }
        var selectedQuestions: [Question] = []

        while selectedQuestions.count < 20 {
            let randomIndex = Int.random(in: 0..<questions.count)
            let randomQuestion = questions[randomIndex]

            if !selectedQuestions.contains(where: { $0.question == randomQuestion.question }) {
                selectedQuestions.append(randomQuestion)
            }
        }
        return selectedQuestions
    }

    func displayQuestionWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + transitionDelay) {
            self.displayQuestion()
            self.updateButtonStates()
        }
    }
}
