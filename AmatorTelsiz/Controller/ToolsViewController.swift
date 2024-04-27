import UIKit
import CoreLocation

class ToolsViewController: UIViewController, CLLocationManagerDelegate {
    // MARK: - Properties
    private var locationManager = CLLocationManager()
    private let toolIcons: [UIImage] = ["pngegg", "pngegg-1", "pngegg-2", "pngegg-4", "pngegg-3","pngegg-5","pngegg-6"].compactMap { UIImage(named: $0) }
    
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
        title = "Tools"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let toolNames = ["Pusula", "Mors Alfabesi", "Fonetik Alfabe", "Röle Bilgileri", "Q Kodları", "Aprs-Fi"]
        
        var previousTool: UIView?
        let startingHeight: CGFloat = 150
        let cornerRadius: CGFloat = 20
        let cardSpacing: CGFloat = 10
        
        for (index, toolName) in toolNames.enumerated() {
            let cardView = UIView()
            cardView.backgroundColor = .white
            cardView.layer.cornerRadius = cornerRadius
            cardView.layer.shadowColor = UIColor.black.cgColor
            cardView.layer.shadowOpacity = 0.1
            cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
            cardView.layer.shadowRadius = 4
            view.addSubview(cardView)
            cardView.translatesAutoresizingMaskIntoConstraints = false
            
            let button = UIButton(type: .system)
            button.setTitle("", for: .normal)
            button.tag = index
            cardView.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            let iconImageView = UIImageView()
            iconImageView.image = toolIcons[index]
            iconImageView.contentMode = .scaleAspectFit
            cardView.addSubview(iconImageView)
            iconImageView.translatesAutoresizingMaskIntoConstraints = false
            
            let toolLabel = UILabel()
            toolLabel.text = toolName
            toolLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            toolLabel.textAlignment = .left
            cardView.addSubview(toolLabel)
            toolLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                cardView.heightAnchor.constraint(equalToConstant: 80),
            ])
            
            if let previousTool = previousTool {
                cardView.topAnchor.constraint(equalTo: previousTool.bottomAnchor, constant: cardSpacing).isActive = true
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
                iconImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
                iconImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
                iconImageView.widthAnchor.constraint(equalToConstant: 40),
                iconImageView.heightAnchor.constraint(equalToConstant: 40)
            ])
            
            NSLayoutConstraint.activate([
                toolLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 20),
                toolLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
                toolLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor)
            ])
            
            previousTool = cardView
        }
        
    }
    }
