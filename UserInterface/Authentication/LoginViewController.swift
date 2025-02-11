//
//  LoginViewController.swift
//  Catstagram
//
//  Created by 김수비 on 1/14/25.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    var email = String()
    var password = String()
    var userInfo: UserInfo?
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAttribute()
    }
    
    // MARK: - Actions
    @IBAction func emailTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""

        self.loginButton.backgroundColor = text.isValidEmail() ? .facebookColor : .disabledButtonColor
        self.email = text
    }
    
    @IBAction func passwordTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        
        self.loginButton.backgroundColor = text.count > 2 ? .facebookColor : .disabledButtonColor
        self.password = text
    }
    
    @IBAction func loginButtonDidTap(_ sender: UIButton) {
        // 회원가입정보를 전달받아서, 그것과 textField 데이터가 일치하면, tabBar로 화면 전환
        
        guard let userInfo = self.userInfo else { return }
        
        if userInfo.email == self.email &&
            userInfo.password == self.password {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
            self.view.window?.windowScene?.keyWindow?.rootViewController = vc
        }
    }
    
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        // 화면전환
        // 1. 스토리보드를 생성
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 2. 뷰컨트롤러를 생성
        let registerViewController = storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
        
        // 3. 화면전환 메소드를 이용해서 화면을 전환
//        self.present(registerViewController, animated: false, completion: nil)
        self.navigationController?.pushViewController(registerViewController, animated: true)
        
        // 회원가입 정보 가져오기
        registerViewController.userInfo = { [weak self] (userInfo) in
            self?.userInfo = userInfo
        }
    }
    
    // MARK: - Helpers
    private func setupAttribute(){
        
        let text1 = "계정이 없으신가요?"
        let text2 = "가입하기"
        
        let font1 = UIFont.systemFont(ofSize: 13)
        let font2 = UIFont.systemFont(ofSize: 13)
        
        let color1 = UIColor.darkGray
        let color2 = UIColor.facebookColor
        
        let attributes = generateButtonArribute(self.registerButton, texts: text1, text2, fonts: font1, font2, colors: color1, color2)
        
        self.registerButton.setAttributedTitle(attributes, for: .normal)
    }
}
