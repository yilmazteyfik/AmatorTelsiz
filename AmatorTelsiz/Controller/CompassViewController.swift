import UIKit
import CoreLocation

class CompassViewController: UIViewController, CLLocationManagerDelegate {
    // MARK: - Properties
    private var locationManager = CLLocationManager()
    private var arrowImageView = UIImageView()
    private var lastHeadingAngle: CGFloat = 0.0
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureNavigationBar()
        configureArrowImageView()
        configureLocationManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startUpdatingLocation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopUpdatingLocation()
    }
    
    // MARK: - Helpers
    private func configureNavigationBar() {
        let backButton = UIBarButtonItem(title: "Geri", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func configureArrowImageView() {
        arrowImageView.image = UIImage(named: "arrow")
        arrowImageView.contentMode = .scaleAspectFit
        view.addSubview(arrowImageView)
        
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arrowImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            arrowImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 100),
            arrowImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func configureLocationManager() {
        if CLLocationManager.headingAvailable() {
            locationManager.delegate = self
            locationManager.startUpdatingHeading()
        } else {
            showAlert(title: "Hata", message: "Cihaz pusula desteği sağlamıyor.")
        }
    }
    
    private func startUpdatingLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        } else {
            showAlert(title: "Hata", message: "Konum servisleri kapalı.")
        }
    }
    
    private func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let newAngle = CGFloat(newHeading.trueHeading).toRadians
        let delta = angleDifference(from: lastHeadingAngle, to: newAngle)
        
        UIView.animate(withDuration: 0.2) {
            self.arrowImageView.transform = self.arrowImageView.transform.rotated(by: delta)
        }
        
        lastHeadingAngle = newAngle
    }
    
    // MARK: - Actions
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Utility
    private func angleDifference(from: CGFloat, to: CGFloat) -> CGFloat {
        var delta = to - from
        if delta > .pi {
            delta -= 2 * .pi
        } else if delta < -.pi {
            delta += 2 * .pi
        }
        return delta
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

extension CGFloat {
    var toRadians: CGFloat { return self * .pi / 180 }
}
