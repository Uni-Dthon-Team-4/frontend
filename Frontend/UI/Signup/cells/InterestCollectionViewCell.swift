//
//  InterestCollectionViewCell.swift
//  Frontend
//
//  Created by Suyeon Hwang on 11/2/24.
//

import UIKit

final class InterestCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "InterestCollectionViewCell"
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = UIColor(hex: "916AFF")
                interestLabel.textColor = .white
            }
            else {
                contentView.backgroundColor = UIColor(hex: "F5F6FA")
                interestLabel.textColor = .black
            }
        }
    }
    
    // MARK: - Views
    
    private let interestLabel: UILabel = {
        let label = UILabel()
        label.text = "✨ 관심사"
        label.font = .Pretendard(size: 16, family: .SemiBold)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor(hex: "F5F6FA")
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15
        
        setupInterestLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupInterestLabel() {
        contentView.addSubview(interestLabel)
        
        interestLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.bottom.equalToSuperview().inset(6.5)
        }
    }
    
    // MARK: - Functions
    
    func configure(with interest: String) {
        print("configuring, with : \(interest)")
        interestLabel.text = "✨ \(interest)"
        interestLabel.sizeToFit()
    }
    
    func getInterestLabelFrame() -> CGRect {
        return interestLabel.frame
    }
}
