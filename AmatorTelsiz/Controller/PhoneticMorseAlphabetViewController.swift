import UIKit
import AVFoundation

class PhoneticAlphabetViewController: UIViewController {
    // MARK: - Properties
    let phoneticAlphabet = [
        "Alpha": "Al-fuh",
        "Bravo": "Brah-voh",
        "Charlie": "Char-lee",
        "Delta": "Dell-tah",
        "Echo": "Eck-oh",
        "Foxtrot": "Foks-trot",
        "Golf": "Golf",
        "Hotel": "Hoh-tel",
        "India": "In-dee-ah",
        "Juliett": "Jew-lee-ett",
        "Kilo": "Key-loh",
        "Lima": "Lee-mah",
        "Mike": "Mike",
        "November": "No-vem-ber",
        "Oscar": "Oss-cah",
        "Papa": "Pah-pah",
        "Quebec": "Keh-beck",
        "Romeo": "Row-me-oh",
        "Sierra": "See-air-rah",
        "Tango": "Tang-goh",
        "Uniform": "You-nee-form",
        "Victor": "Vik-tah",
        "Whiskey": "Wiss-key",
        "X-ray": "Ecks-ray",
        "Yankee": "Yang-key",
        "Zulu": "Zoo-loo"
    ]
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
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
        var rowStackView: UIStackView?
        for (index, (word, _)) in phoneticAlphabet.enumerated() {
            if index % 3 == 0 {
                rowStackView = createRowStackView()
                stackView.addArrangedSubview(rowStackView!)
            }
            
            let cardView = createCardView(for: "\(word)")
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
        if let phonetic = phoneticAlphabet[title] {
            speak(phonetic)
        }
    }
    
    private func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechSynthesizer.speak(utterance)
    }
}
