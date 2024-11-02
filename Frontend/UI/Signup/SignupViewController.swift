//
//  SignupViewController.swift
//  Frontend
//
//  Created by Suyeon Hwang on 11/2/24.
//

import UIKit

final class SignupViewController: UIViewController {
    
    // MARK: - Properties
    
    private var isValidEmail: Bool = false
    
    private var isEmailDuplicateChecked: Bool = false
    
    private let ageArray: [Int] = Array(1...99)
    private var selectedAge: Int?
    
    private let interestArray: [String] = ["청년", "취업", "창업", "교육"/*, "장학금", "중장년", "경제", "노인", "사업", "주택", "지원", "저소득"*/]
    private let minimumLineSpacing: CGFloat = 10
    private let minimumInteritemSpacing: CGFloat = 10
    private var selectedInterestArray: Set<String> = []
    
    // MARK: - Views
    
    private let exitButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(exitButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "회원가입"
        label.font = .Pretendard(size: 18, family: .SemiBold)
        return label
    }()
    
    private let emailStackView = TextFieldStackView()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일"
        label.font = .Pretendard(family: .Medium)
        return label
    }()
    
    private let checkEmailDuplicateButton: CheckEmailDuplicateButton = {
        let button = CheckEmailDuplicateButton()
        button.addTarget(self, action: #selector(checkEmailDuplicateButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "이메일을 입력해주세요."
        tf.addTarget(self, action: #selector(tfDidChange), for: .editingChanged)
        return tf
    }()
    
    private let emailNotValidLabel: UILabel = {
        let label = UILabel()
        label.text = "이미 등록된 이메일이에요."
        label.textColor = .red
        label.font = .Pretendard(size: 12, family: .Medium)
        return label
    }()
    
    private let passwordStackView = TextFieldStackView()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = .Pretendard(family: .Medium)
        return label
    }()
    
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "비밀번호를 입력해주세요."
        tf.addTarget(self, action: #selector(tfDidChange), for: .editingChanged)
        return tf
    }()
    
    private let passwordConfirmStackView = TextFieldStackView()
    
    private let passwordConfirmLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 재입력"
        label.font = .Pretendard(family: .Medium)
        return label
    }()
    
    private let passwordConfirmTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "비밀번호를 다시 입력해주세요."
        tf.addTarget(self, action: #selector(tfDidChange), for: .editingChanged)
        return tf
    }()
    
    private let passwordNotValidLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호가 틀렸어요."
        label.textColor = .red
        label.font = .Pretendard(size: 12, family: .Medium)
        return label
    }()
    
    private let ageTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "만 나이"
        textField.tintColor = .clear
        return textField
    }()
    
    private let agePicker = UIPickerView()
    
    private let toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let confirmButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(pickerDoneButtonDidTap))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let cancelButton = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(pickerCancelButtonDidTap))
        
        toolBar.setItems([confirmButton, space, cancelButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        return toolBar
    }()
    
    private let interestLabel: UILabel = {
        let label = UILabel()
        label.text = "관심 그룹"
        label.font = .Pretendard(size: 20, family: .Bold)
        return label
    }()
    
    private let interestGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "최대 3개의 관심사를 선택할 수 있어요."
        label.font = .Pretendard(size: 16, family: .Medium)
        return label
    }()
    
    private lazy var interestCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = minimumLineSpacing
        flowLayout.minimumInteritemSpacing = minimumInteritemSpacing
        flowLayout.estimatedItemSize = CGSize(width: 79, height: 35)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.dataSource = self
        view.delegate = self
        view.allowsMultipleSelection = true
        view.register(InterestCollectionViewCell.self,
                      forCellWithReuseIdentifier: InterestCollectionViewCell.identifier)
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configAgeTextField()
        
        setupTitleLabel()
        setupExitButton()
        setupEmailStackView()
        setupEmailNotValidLabel()
        setupPasswordStackView()
        setupPasswordConfirmStackView()
        setupPasswordNotValidLabel()
        setupAgeTextField()
        setupInterestLabel()
        setupInterestGuideLabel()
        setupInterestCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print(interestCollectionView.frame)
        
        interestCollectionView.reloadData()
    }
    
    // MARK: - Layout
    
    private func setupExitButton() {
        view.addSubview(exitButton)
        
        exitButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(15)
        }
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(11)
        }
    }
    
    private func setupEmailStackView() {
        emailTextField.rightView = checkEmailDuplicateButton
        
        view.addSubview(emailStackView)
        
        [emailLabel, emailTextField].forEach {
            emailStackView.addArrangedSubview($0)
        }
        
        emailStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(18)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(42)
        }
    }
    
    private func setupEmailNotValidLabel() {
        view.addSubview(emailNotValidLabel)
        
        emailNotValidLabel.snp.makeConstraints { make in
            make.trailing.equalTo(emailStackView.snp.trailing)
            make.top.equalTo(emailStackView.snp.bottom).offset(2)
        }
    }
    
    private func setupPasswordStackView() {
        view.addSubview(passwordStackView)
        
        [passwordLabel, passwordTextField].forEach {
            passwordStackView.addArrangedSubview($0)
        }
        
        passwordStackView.snp.makeConstraints { make in
            make.top.equalTo(emailNotValidLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(18)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(42)
        }
    }
    
    private func setupPasswordConfirmStackView() {
        view.addSubview(passwordConfirmStackView)
        
        [passwordConfirmLabel, passwordConfirmTextField].forEach {
            passwordConfirmStackView.addArrangedSubview($0)
        }
        
        passwordConfirmStackView.snp.makeConstraints { make in
            make.top.equalTo(passwordStackView.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(18)
        }
        
        passwordConfirmTextField.snp.makeConstraints { make in
            make.height.equalTo(42)
        }
    }
    
    private func setupPasswordNotValidLabel() {
        view.addSubview(passwordNotValidLabel)
        
        passwordNotValidLabel.snp.makeConstraints { make in
            make.trailing.equalTo(passwordConfirmStackView.snp.trailing)
            make.top.equalTo(passwordConfirmStackView.snp.bottom).offset(2)
        }
    }
    
    private func setupAgeTextField() {
        view.addSubview(ageTextField)
        
        ageTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(passwordConfirmStackView)
            make.top.equalTo(passwordNotValidLabel.snp.bottom).offset(30)
            make.height.equalTo(42)
        }
    }
    
    private func setupInterestLabel() {
        view.addSubview(interestLabel)
        
        interestLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(ageTextField)
            make.top.equalTo(ageTextField.snp.bottom).offset(30)
        }
    }
    
    private func setupInterestGuideLabel() {
        view.addSubview(interestGuideLabel)
        
        interestGuideLabel.snp.makeConstraints { make in
            make.leading.equalTo(interestLabel.snp.leading)
            make.top.equalTo(interestLabel.snp.bottom).offset(8)
        }
    }
    
    private func setupInterestCollectionView() {
        view.addSubview(interestCollectionView)
        
        interestCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(ageTextField)
            make.top.equalTo(interestGuideLabel.snp.bottom).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    // MARK: - Actions
    
    @objc private func exitButtonDidTap() {
        print("exit button tapped")
    }
    
    @objc private func tfDidChange() {
        
    }
    
    @objc private func checkEmailDuplicateButtonDidTap() {
        print("duplicate button tapped")
        isEmailDuplicateChecked = true
        if isEmailDuplicateChecked {
            print("if")
            checkEmailDuplicateButton.isActive = false
        }
        print("isEmailDuplicateChecked: \(isEmailDuplicateChecked)")
    }
    
    @objc private func pickerDoneButtonDidTap() {
        if let age = selectedAge {
            ageTextField.text = "만 \(age)세"
        }
        else {
            ageTextField.text = "만 0세"
        }
        ageTextField.resignFirstResponder()
    }
    
    @objc private func pickerCancelButtonDidTap() {
        ageTextField.resignFirstResponder()
    }
    
    // MARK: - Functions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func configAgeTextField() {
        ageTextField.inputView = agePicker
        ageTextField.inputAccessoryView = toolBar
        
        agePicker.delegate = self
        agePicker.dataSource = self
    }
}

// MARK: - Extension: UIPickerView

extension SignupViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ageArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(ageArray[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedAge = ageArray[row]
    }
    
}

// MARK: - Extension: UICollectionView

extension SignupViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("numberOfItems: \(interestArray.count)")
        return interestArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestCollectionViewCell.identifier, for: indexPath) as? InterestCollectionViewCell
//        else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestCollectionViewCell.identifier, for: indexPath) as? InterestCollectionViewCell else {
            fatalError("Cell could not be dequeued as InterestCollectionViewCell")
        }
        cell.configure(with: interestArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.isSelected = true
        selectedInterestArray.insert(interestArray[indexPath.item])
        print("=== didSelectItemAt ===")
        print("selectedInterestArray: \(selectedInterestArray)")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.isSelected = false
        selectedInterestArray.remove(interestArray[indexPath.item])
        print("=== didDeselectItemAt ===")
        print("selectedInterestArray: \(selectedInterestArray)")
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return selectedInterestArray.count >= 3 ? false : true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("size for item at: \(indexPath)")
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestCollectionViewCell.identifier, for: indexPath) as? InterestCollectionViewCell
//        else { return .zero }
        guard let cell = collectionView.cellForItem(at: indexPath) as? InterestCollectionViewCell else { return .zero }
        print("cell: \(cell)")
        cell.configure(with: interestArray[indexPath.item])
        
        let interestLabelFrame = cell.getInterestLabelFrame()
        let cellHeight = interestLabelFrame.height + 13
        let cellWidth = 15 + interestLabelFrame.width + 15
        print("indexPath: \(indexPath)의 셀 크기는 \(cellWidth), \(cellHeight)")

        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
}

#Preview {
    SignupViewController()
}
