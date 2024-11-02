//
//  CustomTextField.swift
//  Frontend
//
//  Created by Suyeon Hwang on 11/2/24.
//

import UIKit

final class CustomTextField: UITextField {
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor(hex: "F5F6FA")
        font = .Pretendard(size: 16, family: .Medium)
        textColor = UIColor.black
        layer.cornerRadius = 8
        
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [ .font: UIFont.Pretendard(size: 16, family: .Medium) ])
        
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        leftViewMode = .always
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        rightViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
