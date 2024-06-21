import UIKit

class NoQuestionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // View arka plan rengini beyaz yapalım
        view.backgroundColor = .white
        
        // UILabel oluşturma
        let noQuestionLabel = UILabel()
        noQuestionLabel.text = "There is no question"
        noQuestionLabel.textColor = .black
        noQuestionLabel.textAlignment = .center
        noQuestionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // UILabel'i view'e ekleyelim
        view.addSubview(noQuestionLabel)
        
        // UILabel'in ortalanması için constraint'ler ekleyelim
        NSLayoutConstraint.activate([
            noQuestionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noQuestionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Tap gesture recognizer ekleyelim
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped() {
        let toolsViewController = ToolsViewController()
        navigationController?.pushViewController(toolsViewController, animated: true)
    }
}
