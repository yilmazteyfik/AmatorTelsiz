import UIKit
import CoreLocation
import RealmSwift


class ToolsViewController: UIViewController, CLLocationManagerDelegate {
    // MARK: - Properties
    private var locationManager = CLLocationManager()
    private let toolIcons: [UIImage] = ["pngegg", "pngegg-1", "pngegg-2", "pngegg-4", "pngegg-3","pngegg-5","pngegg-6","saved"].compactMap { UIImage(named: $0) }
    private let toolNames = ["Pusula", "Mors Alfabesi", "Fonetik Alfabe", "Röle Bilgileri", "Q Kodları", "Aprs-Fi", "Kaydedilenler"]
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupScrollView()
        layoutTools()
        
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
        self.navigationItem.hidesBackButton = true
    }
    
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            
        ])
    }
    
    // MARK: - Helpers
    private func layoutTools() {
        title = "Araçlar"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0xBC/255, green: 0x17/255, blue: 0x31/255, alpha: 1.0)]
        
        var previousTool: UIView?
        let startingHeight: CGFloat = 20
        let cornerRadius: CGFloat = 20
        let cardSpacing: CGFloat = 10
        
        for (index, toolName) in toolNames.enumerated() {
            guard index < toolIcons.count else {
                // Eğer ikon sayısı toolNames sayısından azsa, bir placeholder ikon kullanabilirsiniz
                continue
            }

            let cardView = UIView()
            cardView.backgroundColor = .white
            cardView.layer.cornerRadius = cornerRadius
            cardView.layer.shadowColor = UIColor.black.cgColor
            cardView.layer.shadowOpacity = 0.1
            cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
            cardView.layer.shadowRadius = 4
            contentView.addSubview(cardView)
            cardView.translatesAutoresizingMaskIntoConstraints = false
            
            let button = UIButton(type: .system)
            button.setTitle("", for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(toolButtonTapped(_:)), for: .touchUpInside)
            cardView.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            let iconImageView = UIImageView()
            iconImageView.image = toolIcons[index].withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = UIColor(red: 188/255, green: 23/255, blue: 49/255, alpha: 1.0)
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
                cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                cardView.heightAnchor.constraint(equalToConstant: 80),
                
            ])
            
            if let previousTool = previousTool {
                cardView.topAnchor.constraint(equalTo: previousTool.bottomAnchor, constant: cardSpacing).isActive = true
            } else {
                cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: startingHeight).isActive = true
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
        
        // Set the bottom constraint of the contentView
        if let lastTool = previousTool {
            lastTool.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        }
    }
    
    @objc private func toolButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let compassVC = CompassViewController()
            navigationController?.pushViewController(compassVC, animated: true)
        case 1:
            let morseAlphabetVC = MorseAlphabetViewController()
            navigationController?.pushViewController(morseAlphabetVC, animated: true)
        case 2:
            let phoneticAlphabetVC = PhoneticAlphabetViewController()
            navigationController?.pushViewController(phoneticAlphabetVC, animated: true)
        case 3:
            let roleVC = RoleViewController()
            navigationController?.pushViewController(roleVC, animated: true)
        case 4:
            let qcodeVC = QCodeViewController()
            navigationController?.pushViewController(qcodeVC, animated: true)
        case 5:
            let aprsVC = APRSViewController()
            navigationController?.pushViewController(aprsVC, animated: true)
        case 6:
            let realm  = try! Realm()
            let ques = try! realm.objects(Question.self)
            
            if ques.count == 0 {
                let vc = NoQuestionViewController()
                navigationController?.pushViewController(vc, animated: true)
            }else {
                let savedVC = SavedQuestions()
                savedVC.examTitle = "Kaydedilenler"
                navigationController?.pushViewController(savedVC, animated: true)

            }
        default:
            break
        }
    }
}
