//
//  CheckEmailDuplicateButton.swift
//  Frontend
//
//  Created by Suyeon Hwang on 11/2/24.
//

import UIKit

final class CheckEmailDuplicateButton: UIButton {
    
    // MARK: - Properties
    
    var isActive: Bool = true {
        didSet {
            setNeedsUpdateConfiguration()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        var config = UIButton.Configuration.filled()
        config.contentInsets = .init(top: 2, leading: 6, bottom: 2, trailing: 6)
        config.attributedTitle = AttributedString("중복확인")
        config.attributedTitle?.setAttributes(AttributeContainer([NSAttributedString.Key.font: UIFont.Pretendard(family: .Bold)]))
        config.background.cornerRadius = 12
//        config.background.backgroundColor = UIColor(hex: "ECE6FF")
//        config.attributedTitle?.setAttributes(AttributeContainer([NSAttributedString.Key.foregroundColor: UIColor(hex: "916AFF"), NSAttributedString.Key.font: UIFont.Pretendard(family: .Bold)]))
        
        self.configuration = config
        
        let buttonStateHandler: UIButton.ConfigurationUpdateHandler = { button in
            switch self.isActive {
            case true:
                self.isEnabled = true
                button.configuration?.background.backgroundColor = UIColor(hex: "ECE6FF")
                button.configuration?.attributedTitle?.setAttributes(AttributeContainer([NSAttributedString.Key.foregroundColor: UIColor(hex: "916AFF"), NSAttributedString.Key.font: UIFont.Pretendard(family: .Bold)]))
            case false:
                self.isEnabled = false
                button.configuration?.background.backgroundColor = UIColor(hex: "DEE2E6")
                button.configuration?.attributedTitle?.setAttributes(AttributeContainer([NSAttributedString.Key.foregroundColor: UIColor(hex: "85888A"), NSAttributedString.Key.font: UIFont.Pretendard(family: .Bold)]))
            }
        }
        
        self.configurationUpdateHandler = buttonStateHandler
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
