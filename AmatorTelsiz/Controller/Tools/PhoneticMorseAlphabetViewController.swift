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
        // Sözlüğü sıralı bir diziye dönüştür
        let sortedAlphabet = phoneticAlphabet.sorted(by: { $0.key < $1.key })

        var rowStackView: UIStackView?
        for (index, (word, _)) in sortedAlphabet.enumerated() {
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
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25)
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
        
        let label = UILabel()
        label.text = String(title.prefix(1))
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        cardView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: cardView.centerYAnchor, constant: -10) // Harfi yukarı kaydır
        ])
        
        let button = AnimatedButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(wordButtonTapped(_:)), for: .touchUpInside)
        cardView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 3), // Butonu label'in altına yerleştir
            button.bottomAnchor.constraint(equalTo: cardView.bottomAnchor)
        ])
        
        // Butonun dokunma alanını genişletme
        let hitTestInset: CGFloat = 20
        button.hitTestEdgeInsets = UIEdgeInsets(top: -hitTestInset, left: -hitTestInset, bottom: -hitTestInset, right: -hitTestInset)
        
        return cardView
    }

    
    // MARK: - Button Actions
    @objc private func wordButtonTapped(_ sender: AnimatedButton) {
        guard let title = sender.titleLabel?.text else { return }
        if let phonetic = phoneticAlphabet[title] {
            speak(phonetic)
            sender.animateTap()
        }
    }
    
    private func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechSynthesizer.speak(utterance)
    }
}

class AnimatedButton: UIButton {
    var normalBackgroundColor: UIColor = .white
    var highlightedBackgroundColor: UIColor = UIColor(white: 0.9, alpha: 1.0)
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? highlightedBackgroundColor : normalBackgroundColor
        }
    }
    
    func animateTap() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.transform = .identity
            }
        }
    }
}

extension UIButton {
    var hitTestEdgeInsets: UIEdgeInsets {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.hitTestEdgeInsets) as? UIEdgeInsets ?? UIEdgeInsets.zero
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.hitTestEdgeInsets, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let relativeFrame = self.bounds
        let hitFrame = relativeFrame.inset(by: hitTestEdgeInsets)
        if hitFrame.contains(point) {
            return self
        }
        return nil
    }
}

private struct AssociatedKeys {
    static var hitTestEdgeInsets = "hitTestEdgeInsets"
}
