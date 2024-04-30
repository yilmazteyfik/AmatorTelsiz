import UIKit

class SettingViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    // MARK: - Properties
    var settingsTitleLabel: UILabel!
    var accountCardView: UIView!
    var membershipsCardView: UIView!
    var darkModeCardView: UIView!
    var nameLabel: UILabel!
    var avatarImageView: UIImageView!
    var imagePicker = UIImagePickerController()
    var selectedImage: UIImage? = nil
    var darkModeSwitch: UISwitch!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupImagePicker()
    }
    
    // MARK: - Setup
    private func setupViews() {
        // Settings Title Label
        settingsTitleLabel = UILabel()
        settingsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsTitleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        settingsTitleLabel.textColor = .black
        view.addSubview(settingsTitleLabel)
        title = "Ayarlar"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0xBC/255, green: 0x17/255, blue: 0x31/255, alpha: 1.0)]
        
        // Avatar Image View
        avatarImageView = UIImageView(image: UIImage(systemName: "person.circle.fill"))
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.tintColor = .black
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 40 // Half of the width/height to make it round
        avatarImageView.clipsToBounds = true
        view.addSubview(avatarImageView)
        
        // Add tap gesture recognizer to avatarImageView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tapGesture)
        
        // Name Label
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "TA7AII"
// Set your name here
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.textColor = .black
        view.addSubview(nameLabel)
        
        // Account Card View
        accountCardView = UIView()
        accountCardView.translatesAutoresizingMaskIntoConstraints = false
        accountCardView.backgroundColor = .white
        accountCardView.layer.cornerRadius = 10
        accountCardView.layer.shadowColor = UIColor.black.cgColor
        accountCardView.layer.shadowOpacity = 0.3
        accountCardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        accountCardView.layer.shadowRadius = 4
        view.addSubview(accountCardView)
        
        // Account Label
        let accountLabel = UILabel()
        accountLabel.translatesAutoresizingMaskIntoConstraints = false
        accountLabel.text = "Hesabım"
        accountLabel.textColor = .black
        accountCardView.addSubview(accountLabel)
        
        // Account Icon
        let accountIconImageView = UIImageView(image: UIImage(systemName: "person.circle.fill"))
        accountIconImageView.translatesAutoresizingMaskIntoConstraints = false
        accountIconImageView.tintColor = .black
        accountCardView.addSubview(accountIconImageView)
        
        // Memberships Card View
        membershipsCardView = UIView()
        membershipsCardView.translatesAutoresizingMaskIntoConstraints = false
        membershipsCardView.backgroundColor = .white
        membershipsCardView.layer.cornerRadius = 10
        membershipsCardView.layer.shadowColor = UIColor.black.cgColor
        membershipsCardView.layer.shadowOpacity = 0.3
        membershipsCardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        membershipsCardView.layer.shadowRadius = 4
        view.addSubview(membershipsCardView)
        
        // Memberships Label
        let membershipsLabel = UILabel()
        membershipsLabel.translatesAutoresizingMaskIntoConstraints = false
        membershipsLabel.text = "Üyelikler"
        membershipsLabel.textColor = .black
        membershipsCardView.addSubview(membershipsLabel)
        
        // Memberships Icon
        let membershipsIconImageView = UIImageView(image: UIImage(systemName: "person.3.fill"))
        membershipsIconImageView.translatesAutoresizingMaskIntoConstraints = false
        membershipsIconImageView.tintColor = .black
        membershipsCardView.addSubview(membershipsIconImageView)
        
        // Dark Mode Card View
        darkModeCardView = UIView()
        darkModeCardView.translatesAutoresizingMaskIntoConstraints = false
        darkModeCardView.backgroundColor = .white
        darkModeCardView.layer.cornerRadius = 10
        darkModeCardView.layer.shadowColor = UIColor.black.cgColor
        darkModeCardView.layer.shadowOpacity = 0.3
        darkModeCardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        darkModeCardView.layer.shadowRadius = 4
        view.addSubview(darkModeCardView)
        
        // Dark Mode Label
        let darkModeLabel = UILabel()
        darkModeLabel.translatesAutoresizingMaskIntoConstraints = false
        darkModeLabel.text = "Karanlık Mod"
        darkModeLabel.textColor = .black
        darkModeCardView.addSubview(darkModeLabel)
        
        // Dark Mode Icon
        let darkModeIconImageView = UIImageView(image: UIImage(systemName: "moon.fill"))
        darkModeIconImageView.translatesAutoresizingMaskIntoConstraints = false
        darkModeIconImageView.tintColor = .black
        darkModeCardView.addSubview(darkModeIconImageView)
        
        // Dark Mode Switch
        darkModeSwitch = UISwitch()
        darkModeSwitch.translatesAutoresizingMaskIntoConstraints = false
        darkModeSwitch.addTarget(self, action: #selector(darkModeSwitchChanged), for: .valueChanged)
        darkModeCardView.addSubview(darkModeSwitch)
        
        // Constraints
        NSLayoutConstraint.activate([
            
            settingsTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            settingsTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            avatarImageView.topAnchor.constraint(equalTo: settingsTitleLabel.bottomAnchor, constant: 10),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 80),
            avatarImageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            accountLabel.leadingAnchor.constraint(equalTo: accountIconImageView.trailingAnchor, constant: 8),
            accountLabel.centerYAnchor.constraint(equalTo: accountCardView.centerYAnchor),
            
            accountIconImageView.leadingAnchor.constraint(equalTo: accountCardView.leadingAnchor, constant: 8),
            accountIconImageView.centerYAnchor.constraint(equalTo: accountCardView.centerYAnchor),
            accountIconImageView.widthAnchor.constraint(equalToConstant: 24),
            accountIconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            accountCardView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            accountCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            accountCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            accountCardView.heightAnchor.constraint(equalToConstant: 60),
            
            membershipsLabel.leadingAnchor.constraint(equalTo: membershipsIconImageView.trailingAnchor, constant: 8),
            membershipsLabel.centerYAnchor.constraint(equalTo: membershipsCardView.centerYAnchor),
            
            membershipsIconImageView.leadingAnchor.constraint(equalTo: membershipsCardView.leadingAnchor, constant: 8),
            membershipsIconImageView.centerYAnchor.constraint(equalTo: membershipsCardView.centerYAnchor),
            membershipsIconImageView.widthAnchor.constraint(equalToConstant: 24),
            membershipsIconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            membershipsCardView.topAnchor.constraint(equalTo: accountCardView.bottomAnchor, constant: 20),
            membershipsCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            membershipsCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            membershipsCardView.heightAnchor.constraint(equalToConstant: 60),
            
            darkModeLabel.leadingAnchor.constraint(equalTo: darkModeIconImageView.trailingAnchor, constant: 8),
            darkModeLabel.centerYAnchor.constraint(equalTo: darkModeCardView.centerYAnchor),
            
            darkModeIconImageView.leadingAnchor.constraint(equalTo: darkModeCardView.leadingAnchor, constant: 8),
            darkModeIconImageView.centerYAnchor.constraint(equalTo: darkModeCardView.centerYAnchor),
            darkModeIconImageView.widthAnchor.constraint(equalToConstant: 24),
            darkModeIconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            darkModeCardView.topAnchor.constraint(equalTo: membershipsCardView.bottomAnchor, constant: 20),
            darkModeCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            darkModeCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            darkModeCardView.heightAnchor.constraint(equalToConstant: 60),
            
            darkModeSwitch.centerYAnchor.constraint(equalTo: darkModeCardView.centerYAnchor),
            darkModeSwitch.trailingAnchor.constraint(equalTo: darkModeCardView.trailingAnchor, constant: -20),
            
        ])
    }
    
    private func setupImagePicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImage = pickedImage
            avatarImageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @objc private func avatarTapped() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func applySoftDarkMode() {
        // Renkleri yumuşat
        let lightGrayColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
        view.backgroundColor = lightGrayColor
        settingsTitleLabel.textColor = .darkGray
        nameLabel.textColor = .darkGray
        accountCardView.backgroundColor = lightGrayColor
        membershipsCardView.backgroundColor = lightGrayColor
        darkModeCardView.backgroundColor = lightGrayColor
    }
    private func revertToOriginalColors() {
        // Eski renklere geri dön
        view.backgroundColor = .white
        settingsTitleLabel.textColor = .black
        nameLabel.textColor = .black
        accountCardView.backgroundColor = .white
        membershipsCardView.backgroundColor = .white
        darkModeCardView.backgroundColor = .white
    }



    @objc private func darkModeSwitchChanged(_ sender: UISwitch) {
        DarkModeManager.shared.isDarkModeEnabled = sender.isOn
    }


    
}
