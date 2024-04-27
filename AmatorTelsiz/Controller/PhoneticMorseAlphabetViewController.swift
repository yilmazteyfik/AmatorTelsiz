import UIKit
import AVFoundation

class PhoneticAlphabetViewController: UIViewController {
    // MARK: - Properties
    let phoneticAlphabet = [
        "Alpha",
        "Bravo",
        "Charlie",
        "Delta",
        "Echo",
        "Foxtrot",
        "Golf",
        "Hotel",
        "India",
        "Juliett",
        "Kilo",
        "Lima",
        "Mike",
        "November",
        "Oscar",
        "Papa",
        "Quebec",
        "Romeo",
        "Sierra",
        "Tango",
        "Uniform",
        "Victor",
        "Whiskey",
        "X-ray",
        "Yankee",
        "Zulu"
    ]
    
    let player = PhoneticAlphabetPlayer()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Phonetic Alphabet"
        view.backgroundColor = .white
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        let sortedAlphabet = phoneticAlphabet.sorted(by: { $0.key < $1.key })
        var rowStackView: UIStackView?
        for (index, (word, phonetic)) in sortedAlphabet.enumerated() {
            if index % 4 == 0 {
                rowStackView = createRowStackView()
                stackView.addArrangedSubview(rowStackView!)
            }
            
            let cardView = createCardView(for: "\(word): \(phonetic)")
            rowStackView?.addArrangedSubview(cardView)
        }
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }


    private func createRowStackView() -> UIStackView {
        let rowStackView = UIStackView()
        rowStackView.axis = .horizontal
        rowStackView.distribution = .fillEqually
        rowStackView.spacing = 10
        return rowStackView
    }

    
    private func createCardView(for title: String) -> UIView {
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardView.layer.shadowRadius = 4
        
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(wordButtonTapped(_:)), for: .touchUpInside)
        cardView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            button.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            button.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            button.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10)
        ])
        
        return cardView
    }
    
    // MARK: - Button Actions
    @objc private func wordButtonTapped(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        let word = title.split(separator: ":").first ?? ""
        if let phonetic = phoneticAlphabet[String(word)] {
            player.speak(phonetic)
        }
    }
}

// MARK: - Helper Classes
class PhoneticAlphabetPlayer {
    let speechSynthesizer = AVSpeechSynthesizer()
    
    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechSynthesizer.speak(utterance)
    }
}
