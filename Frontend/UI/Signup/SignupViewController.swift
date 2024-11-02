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
    private var selectedAge: Int? {
        didSet {
            tfDidChange()
        }
    }
    
    private let interestArray: [String] = ["청년", "취업", "창업", "교육", "장학금", "중장년", "경제", "노인", "사업", "주택", "지원", "저소득"]
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
    
    private lazy var emailTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "이메일을 입력해주세요."
        tf.delegate = self
        tf.addTarget(self, action: #selector(tfDidChange), for: .editingChanged)
        return tf
    }()
    
    private let emailNotValidLabel: UILabel = {
        let label = UILabel()
        label.text = "이미 등록된 이메일이에요."
        label.textColor = .red
        label.font = .Pretendard(size: 12, family: .Medium)
        label.isHidden = true
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
        tf.textContentType = .newPassword
        tf.isSecureTextEntry = true
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
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(tfDidChange), for: .editingChanged)
        return tf
    }()
    
    private let passwordNotValidLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호가 틀렸어요."
        label.textColor = .red
        label.font = .Pretendard(size: 12, family: .Medium)
        label.isHidden = true
        return label
    }()
    
    private let ageTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "만 나이"
        textField.tintColor = .clear
        textField.addTarget(self, action: #selector(tfDidChange), for: .valueChanged)
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
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            return self.createLayoutSection()
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(InterestCollectionViewCell.self, forCellWithReuseIdentifier: InterestCollectionViewCell.identifier)
        collectionView.allowsMultipleSelection = true
        return collectionView
    }()
    
    private let signupButton: NextButton = {
        let button = NextButton(title: "회원가입")
        button.addTarget(self, action: #selector(signupButtonDidTap), for: .touchUpInside)
        return button
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
        setupSignupButton()
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
        }
    }
    
    private func setupSignupButton() {
        view.addSubview(signupButton)
        
        signupButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(interestCollectionView)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(15)
            make.top.equalTo(interestCollectionView.snp.bottom).offset(10)
        }
    }
    
    // MARK: - Actions
    
    @objc private func exitButtonDidTap() {
        print("exit button tapped")
        
        let alertController = UIAlertController(title: "정말 회원가입을 그만하시겠어요?",
                                                message: "작성 내용은 저장되지 않습니다.",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel))
        alertController.addAction(UIAlertAction(title: "나가기", style: .destructive, handler: { action in
            self.dismiss(animated: true)
        }))
        
        self.present(alertController, animated: true)
    }
    
    @objc private func tfDidChange() {
        let isValidEmail = if let text = emailTextField.text { text != "" } else { false }
        let isPwSame = isPasswordSame(passwordTextField, passwordConfirmTextField)
        print("isValidEmail: \(isValidEmail)")
        print("isPwSame: \(isPwSame)")
        print("age: \(selectedAge)")
        if isValidEmail
            && isEmailDuplicateChecked
            && !(passwordTextField.text?.isEmpty ?? true)
            && isPwSame
            && (selectedAge != nil) {
            signupButton.isActive = true
        }
        else {
            signupButton.isActive = false
        }
    }
    
    @objc private func checkEmailDuplicateButtonDidTap() {
        print("duplicate button tapped")
        let email = emailTextField.text
        
        if email != "" {
            let request = CheckDuplicateRequestDTO(userId: email!)
            print("request: \(request)")
            
            CheckDuplicateService.getEmailDuplicateCheck(request: request) { [weak self] succeed, failed in
                guard let succeed = succeed else {
                    // 에러가 난 경우, alert 창 present
                    switch failed {
                    case .disconnected:
                        self?.present(UIAlertController.networkErrorAlert(title: failed!.localizedDescription), animated: true)
                    case .serverError:
                        self?.present(UIAlertController.networkErrorAlert(title: failed!.localizedDescription), animated: true)
                    case .unknownError:
                        self?.present(UIAlertController.networkErrorAlert(title: failed!.localizedDescription), animated: true)
                    default:
                        self?.present(UIAlertController.networkErrorAlert(title: "요청에 실패하였습니다."), animated: true)
                    }
                    return
                }
                print("=== Signup, check duplicate data succeeded ===")
                print("== data: \(succeed)")
                
                // 중복 체크 통과했을 때
                if succeed {
                    self?.isEmailDuplicateChecked = true
                    self?.checkEmailDuplicateButton.isActive = false
                    self?.emailNotValidLabel.isHidden = true
                    self?.tfDidChange()
//                    let alert = UIAlertController(title: "중복되지 않는 이메일입니다!", message: nil, preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "확인", style: .default))
//                    self?.present(alert, animated: true)
                }
                else {
                    self?.emailNotValidLabel.isHidden = false
                }
                print("isEmailDuplicateChecked: \(self?.isEmailDuplicateChecked)")
            }
        }
        else {
            let alert = UIAlertController(title: "이메일을 입력해주세요!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true)
        }
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
    
    @objc private func signupButtonDidTap() {
        print("signup button tapped")
        
        let requestDTO = SignupRequestDTO(userId: emailTextField.text!,
                                          password: passwordTextField.text!,
                                          email: emailTextField.text!,
                                          age: selectedAge!,
                                          keyword1: selectedInterestArray.popFirst(),
                                          keyword2: selectedInterestArray.popFirst(),
                                          keyword3: selectedInterestArray.popFirst(),
                                          address: nil)
        print("dto: \(requestDTO)")
        
        SignupService.postSignup(request: requestDTO) { [weak self] succeed, failed in
            guard let data = succeed else {
                // 에러가 난 경우, alert 창 present
                switch failed {
                case .disconnected:
                    self?.present(UIAlertController.networkErrorAlert(title: failed!.localizedDescription), animated: true)
                default:
                    self?.present(UIAlertController.networkErrorAlert(title: "회원가입에 실패하였습니다."), animated: true)
                }
                return
            }
            
            print("=== Signup, postSignup succeeded ===")
            print("== data: \(data)")
            
            UserDefaults.standard.set(true, forKey: "isFirstLaunch")
            UserDefaults.standard.synchronize()
            
            UserDefaultsManager.shared.setData(value: data.id, key: .id)
            UserDefaultsManager.shared.setData(value: data.uuid, key: .uuid)
            UserDefaultsManager.shared.setData(value: data.age, key: .age)
            UserDefaultsManager.shared.setData(value: data.keyword1 ?? "", key: .keyword1)
            UserDefaultsManager.shared.setData(value: data.keyword2 ?? "", key: .keyword2)
            UserDefaultsManager.shared.setData(value: data.keyword3 ?? "", key: .keyword3)
            
            self?.moveToHomeVC()
            
//            // 만약 실패한 경우 실패했다고 알림창
//            if data.isSuccess == false {
//                self?.present(UIAlertController.networkErrorAlert(title: "댓글 등록에 실패하였습니다."), animated: true)
//                return
//            }
//            else {
//                print("=== 새 댓글 등록, 데이터 업데이트 ===")
//                self?.loadCommentData()
//            }
        }
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
    
    private func isPasswordSame(_ first: UITextField,_ second: UITextField) -> Bool {
        // 두 텍스트필드 값이 같을 때 true
        if(first.text == second.text) {
            passwordNotValidLabel.isHidden = true
            return true
        }
        // 두 텍스트필드 값이 다를 때
        else {
            // 비번 확인 창이 비어있으면 확인 불가하므로 false
            if second.text == "" {
                passwordNotValidLabel.isHidden = true
                return false
            }
            // 비번 확인 창 내용이 있으면 값이 다른 거이므로 false
            else {
                passwordNotValidLabel.isHidden = false
                return false
            }
        }
    }
    
    private func createLayoutSection() -> NSCollectionLayoutSection {
        // 아이템 크기를 콘텐츠에 맞게 조절
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .estimated(35))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // 그룹을 가로 방향으로 설정하고, 아이템을 포함
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(35))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10) // 아이템 간의 간격 설정

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10 // 그룹 간의 간격 설정
        //section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16) // 섹션 여백 설정

        return section
    }
    
    private func moveToHomeVC() {
        DispatchQueue.main.async {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVcTo(TabBarViewController(), animated: false)
        }
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
        return interestArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestCollectionViewCell.identifier, for: indexPath) as? InterestCollectionViewCell
        else { return UICollectionViewCell() }
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
        
        return UICollectionViewFlowLayout.automaticSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
}

// MARK: - Extension: Textfield

extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return isEmailDuplicateChecked ? false : true
    }
}

#Preview {
    SignupViewController()
}
