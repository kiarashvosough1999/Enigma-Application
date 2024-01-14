//
//  EncryptionView.swift
//  Enigma
//
//

import UIKit

final class EncryptionView: UIStackView {
    
    var enigma = Enigma()
    
    let stackView: UIStackView = {
       let stckView = UIStackView()
        stckView.axis = .vertical
        stckView.distribution = .fillEqually
        stckView.spacing = 8.0
        stckView.translatesAutoresizingMaskIntoConstraints = false
        return stckView
    }()
    
    let loadedKeysLbl: UILabel = {
       let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFontMetrics(forTextStyle: UIFont.TextStyle.body).scaledFont(for: UIFont(name: "Helvetica-Bold", size: 14)!)
        return lbl
    }()
    
    let messageTxtView: UITextView = {
        let txtView = UITextView(frame: .zero)
        txtView.font = UIFontMetrics(forTextStyle: UIFont.TextStyle.body).scaledFont(for: UIFont(name: "Helvetica-Bold", size: 14)!)
        txtView.textColor = .white
//        txtView.isScrollEnabled = true
        txtView.layer.cornerRadius = 5
        txtView.backgroundColor = .gray
        return txtView
    }()
    
    let encryptDecryptCtrl: UISegmentedControl = {
       let segmntCtrl = UISegmentedControl(items: ["ENCRYPT", "DECRYPT"])
        segmntCtrl.tintColor = .white
        segmntCtrl.selectedSegmentIndex = 0
        segmntCtrl.addTarget(self, action: #selector(encryptDecryptChangeed(_:)), for: .valueChanged)
        return segmntCtrl
    }()
    
    let encryptDecryptButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("ENCRYPT", for: .normal)
        btn.layer.cornerRadius = 5
        btn.backgroundColor = .white
        btn.setTitleColor(.gray, for: .normal)
        btn.addTarget(self, action: #selector(processMessage), for: .touchUpInside)
        return btn
    }()
    
    let processedMessageTxtView: UITextView = {
       let txtView = UITextView(frame: .zero)
        txtView.font = UIFontMetrics(forTextStyle: UIFont.TextStyle.body).scaledFont(for: UIFont(name: "Helvetica-Bold", size: 20)!)
        txtView.textColor = .white
        txtView.isScrollEnabled = true
        txtView.layer.cornerRadius = 5
        txtView.backgroundColor = .gray
        return txtView
    }()

    init() {
        super.init(frame: .zero)

        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        axis = .vertical
        distribution = .fillEqually
        spacing = 8.0
        translatesAutoresizingMaskIntoConstraints = false
        loadedKeysLbl.text = "Keys loaded today: \(enigma.getCurrentDay().rawValue)"
        
        addArrangedSubview(stackView)
        stackView.addArrangedSubview(loadedKeysLbl)
        stackView.addArrangedSubview(messageTxtView)
        stackView.addArrangedSubview(encryptDecryptCtrl)
        stackView.addArrangedSubview(encryptDecryptButton)
        addArrangedSubview(processedMessageTxtView)
    }
    
    @objc func encryptDecryptChangeed(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            encryptDecryptButton.setTitle("ENCRYPT", for: .normal)
        } else {
            encryptDecryptButton.setTitle("DECRYPT", for: .normal)
        }
    }
    
    @objc func processMessage() {
        guard let message = messageTxtView.text else { return }
        enigma.loadEncryptionKeys(for: enigma.getCurrentDay())
        if encryptDecryptCtrl.selectedSegmentIndex == 0 {
            let encrypted = enigma.encrypt(message: message)
            processedMessageTxtView.text = encrypted
        } else {
            guard message.count % 3 == 0 else { return }
            let decrypted = enigma.decrypt(message: message)
            processedMessageTxtView.text = decrypted
        }
    }
    
}
