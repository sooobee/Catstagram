//
//  RegisterViewController.swift
//  Catstagram
//
//  Created by 김수비 on 1/15/25.
//

import UIKit

class RegisterViewController: UIViewController {
    // MARK: - Properties
    
    var email: String = ""
    var name: String = ""
    var nickname: String = ""
    var password: String = ""
    
    var userInfo: ((UserInfo) -> Void)?
    
    // 유효성검사를 위한 프로퍼티
    var isValidEmail = false {
        didSet { // 프로퍼티 옵저버(값이 변경될 때마다 실행)
            self.validateUserInfo()
        }
    }
    
    var isValidName = false {
        didSet {
            self.validateUserInfo()
        }
    }
    
    var isValidNickname = false {
        didSet {
            self.validateUserInfo()
        }
    }
    
    var isValidPassword = false {
        didSet {
            self.validateUserInfo()
        }
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var popToLoginButton: UIButton!
    
    // 연산프로퍼티
    var textFields: [UITextField] {
        [emailTextField, nameTextField, nicknameTextField, passwordTextField]
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupAttribute()
        
        // bug fix
        // swipe해서 뒤로가기
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    // MARK: - Actions
    @objc // IBAction를 코드로 작성할 때랑 동일
    func textFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        
        switch sender {
        case emailTextField:
            self.isValidEmail = text.isValidEmail()
            self.email = text
            
        case nameTextField:
            self.isValidName = text.count > 2
            self.name = text
            
        case passwordTextField:
            self.isValidPassword = text.isValidPassword()
            self.password = text
            
        case nicknameTextField:
            self.isValidNickname = text.count > 2
            self.nickname = text
            
        default:
            fatalError("Missing TextField...")
        }
    }
    
    @IBAction func backButtonDidTap(_ sender: UIBarButtonItem) {
        // 뒤로가기
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        // 뒤로가기
        self.navigationController?.popViewController(animated: true)
        
        let userInfo = UserInfo(email: self.email,
                                name: self.name,
                                nickname: self.nickname,
                                password: self.password)
        
        self.userInfo?(userInfo)
        
    }
    
    
    // MARK: - Helpers
    // (받은 데이터를 어디에다 보내줄지를 정의), textField와 Action을 연결
    private func setupTextField() {
        
        textFields.forEach { tf in
            tf.addTarget(self,
                         action: #selector(textFieldEditingChanged(_:)),
                         for: .editingChanged)
        }
    }
    
    // 사용자가 입력한 회원정보를 확인하고 -> UI 업데이트
    private func validateUserInfo(){
        
        if isValidEmail
            && isValidName
            && isValidNickname
            && isValidPassword {
            
            UIView.animate(withDuration: 0.33) {
                self.signupButton.isEnabled = true
                self.signupButton.backgroundColor = UIColor.facebookColor
            }
        } else {
            // 유효성 검사 -> false
            UIView.animate(withDuration: 0.33) {
                self.signupButton.isEnabled = false
                self.signupButton.backgroundColor = UIColor.disabledButtonColor
            }
        }
        
    }
    
    private func setupAttribute(){
        // register버튼 색 다르게 설정
        let text1 = "계정이 있으신가요?"
        let text2 = "로그인"
        
        let font1 = UIFont.systemFont(ofSize: 13)
        let font2 = UIFont.systemFont(ofSize: 13)
        
        let color1 = UIColor.darkGray
        let color2 = UIColor.facebookColor
        
        let attributes = generateButtonArribute(self.popToLoginButton, texts: text1, text2, fonts: font1, font2, colors: color1, color2)
        
        self.popToLoginButton.setAttributedTitle(attributes, for: .normal)
    }
}

// 정규표현식
extension String {
    // 대문자, 소문자, 특수문자, 숫자 8자 이상일 때, -> True
    func isValidPassword() -> Bool {
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
        
        return passwordValidation.evaluate(with: self)
    }
    
    // @, 2글자 이상
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
