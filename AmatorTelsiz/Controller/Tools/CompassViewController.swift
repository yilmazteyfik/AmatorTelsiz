//
//  CompassViewController.swift
//  AmatorTelsiz
//
//  Created by Melik Bilyay on 27.04.2024.
//

import Foundation
import UIKit
import CoreLocation

class CompassViewController: UIViewController, CLLocationManagerDelegate {
    // Compass UI Elements
    var compassImageView: UIImageView!
    var degreeLabel: UILabel!
    
    // Location Manager
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLocationManager()
    }
    
    func setupUI() {
        // Set background color to white
        view.backgroundColor = .white
        
        // Compass Image View
        compassImageView = UIImageView(image: UIImage(named: "compass"))
        compassImageView.contentMode = .scaleAspectFit
        compassImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(compassImageView)
        
        NSLayoutConstraint.activate([
            compassImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            compassImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            compassImageView.widthAnchor.constraint(equalToConstant: 300),
            compassImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        // Degree Label
        degreeLabel = UILabel()
        degreeLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        degreeLabel.textColor = .black
        degreeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(degreeLabel)
        
        NSLayoutConstraint.activate([
            degreeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            degreeLabel.topAnchor.constraint(equalTo: compassImageView.bottomAnchor, constant: 20)
        ])
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let heading = newHeading.magneticHeading
        let rotationAngle = CGFloat(-heading).toRadians // Convert heading to radians and negate for UIImageView rotation
        compassImageView.transform = CGAffineTransform(rotationAngle: rotationAngle)
        
        let roundedHeading = Int(heading)
        let direction = getDirection(heading: roundedHeading)
        degreeLabel.text = "\(roundedHeading)° \(direction)"
    }
    
    func getDirection(heading: Int) -> String {
        let directions = ["K", "KKB", "KB", "DBK", "D", "DKG", "KG", "KGD", "GD", "GKGD", "GKG", "BGD", "B"]
        let index = Int((Double(heading) / 360.0) * 12) % 12
        return directions[index]
    }
}

extension CGFloat {
    var toRadians: CGFloat { return self * .pi / 180 }
}

