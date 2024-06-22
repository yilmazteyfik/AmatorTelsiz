import UIKit

class NoQuestionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the navigation bar for this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // View background color
        view.backgroundColor = .white
        
        // Create UILabel
        let noQuestionLabel = UILabel()
        noQuestionLabel.text = "There is no question"
        noQuestionLabel.textColor = .black
        noQuestionLabel.textAlignment = .center
        noQuestionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Add UILabel to the view
        view.addSubview(noQuestionLabel)
        
        // Add constraints to center the UILabel
        NSLayoutConstraint.activate([
            noQuestionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noQuestionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Add tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped() {
        let toolsViewController = ToolsViewController()
        navigationController?.pushViewController(toolsViewController, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar again when this view controller is about to disappear
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
