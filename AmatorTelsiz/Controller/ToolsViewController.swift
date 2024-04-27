import UIKit
import CoreLocation

class ToolsViewController: UIViewController, CLLocationManagerDelegate {
    // MARK: - Properties
    private var locationManager = CLLocationManager()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layoutTools()
        
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
    }
    
    // MARK: - Helpers
    private func layoutTools() {
        let toolNames = ["Tool 1", "Tool 2", "Tool 3", "Tool 4", "Tool 5"]
        
        var previousTool: UIView?
        let startingHeight: CGFloat = 100 // Yeni başlangıç yüksekliği
        
        for (index, toolName) in toolNames.enumerated() {
            // Card view oluştur
            let cardView = UIView()
            cardView.backgroundColor = .lightGray // Arka plan rengini açık gri yap
            cardView.layer.cornerRadius = 10
            cardView.layer.borderWidth = 1
            cardView.layer.borderColor = UIColor.lightGray.cgColor
            view.addSubview(cardView)
            cardView.translatesAutoresizingMaskIntoConstraints = false
            
            // Buton oluştur
            let button = UIButton(type: .system)
            button.setTitle("", for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            button.tag = index // Butonun tag'ini indeks olarak ayarla
            cardView.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            // İçerik oluştur
            let iconImageView = UIImageView(image: UIImage(named: "icon"))
            iconImageView.contentMode = .scaleAspectFit
            cardView.addSubview(iconImageView)
            iconImageView.translatesAutoresizingMaskIntoConstraints = false
            
            let toolLabel = UILabel()
            toolLabel.text = toolName
            toolLabel.textAlignment = .left
            cardView.addSubview(toolLabel)
            toolLabel.translatesAutoresizingMaskIntoConstraints = false
            
            // Constraintleri ayarla
            NSLayoutConstraint.activate([
                cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                cardView.heightAnchor.constraint(equalToConstant: 50)
            ])
            
            if let previousTool = previousTool {
                cardView.topAnchor.constraint(equalTo: previousTool.bottomAnchor, constant: 10).isActive = true
            } else {
                cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingHeight).isActive = true
            }
            
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
                button.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
                button.topAnchor.constraint(equalTo: cardView.topAnchor),
                button.bottomAnchor.constraint(equalTo: cardView.bottomAnchor)
            ])
            
            NSLayoutConstraint.activate([
                iconImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
                iconImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
                iconImageView.widthAnchor.constraint(equalToConstant: 30),
                iconImageView.heightAnchor.constraint(equalToConstant: 30)
            ])
            
            NSLayoutConstraint.activate([
                toolLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
                toolLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor)
            ])
            
            // Önceki kartı güncelle
            previousTool = cardView
        }
    }
    
    // MARK: - Actions
    @objc private func buttonTapped(_ sender: UIButton) {
        if sender.tag == 0 { // Tool 1 butonuna basıldığında
            let compassViewController = CompassViewController()
            compassViewController.modalPresentationStyle = .fullScreen
            present(compassViewController, animated: true, completion: nil)
        }
    }
}
