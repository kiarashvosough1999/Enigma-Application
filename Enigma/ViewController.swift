//
//  ViewController.swift
//  Enigma
//
//

import UIKit

final class ViewController: UIViewController {

    let encryptView = EncryptionView()
    let logoImage = LogoImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        view.backgroundColor = .darkGray
        view.addSubview(logoImage)
        
        logoImage.setupLogo()
        setupEncryptView()
    }
    
    private func setupEncryptView() {
        let safeGuide = view.safeAreaLayoutGuide
        view.addSubview(encryptView)
        NSLayoutConstraint.activate([
            encryptView.leftAnchor.constraint(equalTo: safeGuide.leftAnchor, constant: 20),
            encryptView.rightAnchor.constraint(equalTo: safeGuide.rightAnchor, constant: -20),
            encryptView.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 20),
            encryptView.bottomAnchor.constraint(equalTo: logoImage.topAnchor, constant: -20)
            ])
    }
}

