import Foundation
import UIKit

class SettingViewController: UIViewController {
    
    // MARK: - Properties
    
    // Example properties for settings data
    private var notificationsEnabled = true
    private var darkModeEnabled = false
    
    // UI Components
    private var notificationsSwitch: UISwitch!
    private var darkModeStackView: UIStackView!
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Setup UI
        setupNavigationBar()
        setupViews()
        layoutViews()
    }
    
    // MARK: - UI Setup
    
    private func setupNavigationBar() {
        title = "Ayarlar"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupViews() {
       
    }
    
    private func layoutViews() {
       
    }
    
    // MARK: - Action Handlers
    
   
}
