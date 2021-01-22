//
//  OTPTextField.swift
//  appCarbon
//
//  Created by macbook on 21.01.2021.
//

import UIKit

class OTPTextField: UITextField {
    
    var didEnterLastDigit: ((String) -> Void)?
    
    var defaultCharacter = "-"
    
    private var isConfigure = false
    
    private var digitLabels = [UILabel]()
    
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(becomeFirstResponder))
        return recognizer
    }()
    
    func configure(with count: Int = 6) {
        guard isConfigure == false else { return }
        isConfigure.toggle()
        
        configureTextField()
        
        let labelsStackView = createLabelStackView(with: count)
        addSubview(labelsStackView)
        
        addGestureRecognizer(tapRecognizer)
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: topAnchor),
            labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configureTextField() {
        tintColor = .clear
        textColor = .clear
        keyboardType = .numberPad
        textContentType = .oneTimeCode
    
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        delegate = self
    }
    
    private func createLabelStackView(with count: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        for _ in 1 ... count {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 40)
            label.text = defaultCharacter
            label.isUserInteractionEnabled = true
            
            stackView.addArrangedSubview(label)
            
            digitLabels.append(label)
        }
        
        return stackView
    }
    
    @objc private func textDidChange() {
        guard let text = self.text, text.count <= digitLabels.count else { return }
        
        for i in 0 ..< digitLabels.count {
            let currentLabel = digitLabels[i]
            
            if i < text.count {
                let index = text.index(text.startIndex, offsetBy: i)
                currentLabel.text = String(text[index])
            } else {
                currentLabel.text = defaultCharacter
            }
            
            if text.count == digitLabels.count {
            didEnterLastDigit?(text)
            }
        }
    }
}

extension OTPTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let characterCount = textField.text?.count else { return false }
        return characterCount < digitLabels.count || string == ""
    }
}
