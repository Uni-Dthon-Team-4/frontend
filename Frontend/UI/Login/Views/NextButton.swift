//
//  NextButton.swift
//  Frontend
//
//  Created by Suyeon Hwang on 11/2/24.
//

import UIKit

final class NextButton: UIButton {
    
    // MARK: - Properties
    
    var isActive: Bool = false {
        didSet {
            setNeedsUpdateConfiguration()
        }
    }
    
    // MARK: - Initialization
    
    init(title: String = "로그인", font: UIFont = .Pretendard(size: 16, family: .Bold)) {
        super.init(frame: .zero)
        
        var config = UIButton.Configuration.filled()
        config.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)
        config.attributedTitle = AttributedString(title)
        config.attributedTitle?.setAttributes(AttributeContainer([NSAttributedString.Key.font: font]))
        self.configuration = config
        
        let buttonStateHandler: UIButton.ConfigurationUpdateHandler = { button in
            switch self.isActive {
            case true:
                self.isEnabled = true
                button.configuration?.background.backgroundColor = UIColor(hex: "916AFF")
                //button.configuration?.baseForegroundColor = .white
                button.configuration?.attributedTitle?.setAttributes(AttributeContainer([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: font]))
            case false:
                self.isEnabled = false
                button.configuration?.background.backgroundColor = UIColor(hex: "F6F2FF")
                //button.configuration?.baseForegroundColor = UIColor(hexCode: "D2C2FF")
                button.configuration?.attributedTitle?.setAttributes(AttributeContainer([NSAttributedString.Key.foregroundColor: UIColor(hex: "D2C2FF"), NSAttributedString.Key.font: font]))
            }
        }
        
        self.configurationUpdateHandler = buttonStateHandler
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    private func setupButton() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.isEnabled = false  // 초기 상태
    }
}
