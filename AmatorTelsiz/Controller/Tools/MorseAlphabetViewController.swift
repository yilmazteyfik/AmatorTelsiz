import UIKit
import AVFoundation
import CoreHaptics

class MorseAlphabetViewController: UIViewController {
    // MARK: - Properties
    let morseAlphabet = [
        "A": ".-", "B": "-...", "C": "-.-.", "D": "-..", "E": ".",
        "F": "..-.", "G": "--.", "H": "....", "I": "..", "J": ".---",
        "K": "-.-", "L": ".-..", "M": "--", "N": "-.", "O": "---",
        "P": ".--.", "Q": "--.-", "R": ".-.", "S": "...", "T": "-",
        "U": "..-", "V": "...-", "W": ".--", "X": "-..-", "Y": "-.--",
        "Z": "--..", "0": "-----", "1": ".----", "2": "..---", "3": "...--",
        "4": "....-", "5": ".....", "6": "-....", "7": "--...", "8": "---..",
        "9": "----."
    ]
    
    let vibrator = MorseVibrator()
    let flasher = Flasher()
    let player = MorsePlayer()
    
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
        title = "Mors Alfabesi"
        view.backgroundColor = .white
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        let sortedAlphabet = morseAlphabet.sorted(by: { $0.key < $1.key })
        var rowStackView: UIStackView?
        for (index, (letter, morseCode)) in sortedAlphabet.enumerated() {
            if index % 4 == 0 {
                rowStackView = createRowStackView()
                stackView.addArrangedSubview(rowStackView!)
            }
            
            let cardView = createCardView(for: "\(letter): \(morseCode)")
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
        button.addTarget(self, action: #selector(letterButtonTapped(_:)), for: .touchUpInside)
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
    @objc private func letterButtonTapped(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        let parts = title.split(separator: ":")
        guard let letter = parts.first, let morseCode = morseAlphabet[String(letter)] else { return }
        
        vibrator.vibrate(morseCode: morseCode)
        for character in morseCode {
            switch character {
            case ".":
                flasher.flashDot()
                player.playDot()
            case "-":
                flasher.flashDash()
                player.playDash()
            default:
                break
            }
            Thread.sleep(forTimeInterval: 0.3) // Adjust timing as needed
        }
    }
}


// MARK: - Helper Classes
class MorseVibrator {
    private let generator: UIImpactFeedbackGenerator? = {
        if #available(iOS 10.0, *) {
            return UIImpactFeedbackGenerator(style: .light)
        } else {
            return nil
        }
    }()
    
    func vibrateDot() {
        generator?.impactOccurred()
    }
    
    func vibrateDash() {
        generator?.impactOccurred()
    }
    
    func vibrate(morseCode: String) {
        for character in morseCode {
            switch character {
            case ".":
                vibrateDot()
            case "-":
                vibrateDash()
            default:
                break
            }
            Thread.sleep(forTimeInterval: 0.3) // Adjust timing as needed
        }
    }
}


class Flasher {
    private let device = AVCaptureDevice.default(for: .video)
    
    func flashDot() {
        guard let device = device else { return }
        try? device.lockForConfiguration()
        device.torchMode = .on
        device.unlockForConfiguration()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            try? device.lockForConfiguration()
            device.torchMode = .off
            device.unlockForConfiguration()
        }
    }
    
    func flashDash() {
        guard let device = device else { return }
        try? device.lockForConfiguration()
        device.torchMode = .on
        device.unlockForConfiguration()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            try? device.lockForConfiguration()
            device.torchMode = .off
            device.unlockForConfiguration()
        }
    }
}

class MorsePlayer {
    let dotSoundURL = Bundle.main.url(forResource: "dot", withExtension: "mp3")!
    let dashSoundURL = Bundle.main.url(forResource: "dash", withExtension: "mp3")!
    
    var dotPlayer: AVAudioPlayer?
    var dashPlayer: AVAudioPlayer?
    
    func playDot() {
        do {
            dotPlayer = try AVAudioPlayer(contentsOf: dotSoundURL)
            dotPlayer?.play()
        } catch {
            print("Error playing dot sound: \(error)")
        }
    }
    
    func playDash() {
        do {
            dashPlayer = try AVAudioPlayer(contentsOf: dashSoundURL)
            dashPlayer?.play()
        } catch {
            print("Error playing dash sound: \(error)")
        }
    }
}
