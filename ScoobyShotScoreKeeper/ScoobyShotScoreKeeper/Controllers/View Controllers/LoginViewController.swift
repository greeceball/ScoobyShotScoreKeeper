//
//  LoginViewController.swift
//  ScoobyShotScoreKeeper
//
//  Created by Colby Harris on 6/8/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import UIKit
import AuthenticationServices
import CloudKit

class LoginViewController: UIViewController, ASAuthorizationControllerDelegate {
    
    @IBOutlet weak var logInStackView: UIStackView!
    
    let defaults = UserDefaults.standard
    var user: User?
    
    struct Keys {
        static let userID = "userID"
        static let userRefKey = "userRef"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //resetDefaults()

        NotificationCenter.default.addObserver(self, selector: #selector(appleIDStateRevoked), name: ASAuthorizationAppleIDProvider.credentialRevokedNotification, object: nil)

        checkUserDefaultsIsNil()
        setUpSignInAppleButton()
    }
    
    func setUpSignInAppleButton() {
        let signInBtn = ASAuthorizationAppleIDButton()
        signInBtn.addTarget(self, action: #selector(handleAppleIdRequest), for: .touchUpInside)
        signInBtn.cornerRadius = 10
        
        logInStackView?.addArrangedSubview(signInBtn)
    }
    
    @objc func handleAppleIdRequest() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    @objc func appleIDStateRevoked() {
        defaults.set("", forKey: Keys.userID)
        defaults.synchronize()
        self.showLoginViewController()
    }
    
    func finishLoggingIn() {
        
        var currentUser: String = ""
        
        UserController.shared.fetchUser(completion: { (result) in
            switch result {
                
            case .success(let user):
                guard let username = user.username else { return }
                currentUser = username.description
                StoredVariables.shared.userInfo["user"] = currentUser
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toTabBarVC", sender: nil)
                }
                
            case .failure(let error):
                print(error.errorDescription)
            }
        })
        
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? TabBarController, let _ = sender as? User {
            destinationVC.user = self.user
        }
    }
    
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential :
            let userName = credentials.user
            let fullName = credentials.fullName
            let email = credentials.email
            print("User id is \(userName) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: email))")
            
            guard let firstName = fullName?.givenName, let lastName = fullName?.familyName, let userEmail = email else { return }
            
            UserController.shared.doesRecordExist(inRecordType: "User", withField: "userName", equalTo: userName) { (result) in
                if result == false {
                    
                    UserController.shared.createUserWith(username: userName, firstName: firstName, lastName: lastName, pdgaNumber: nil, email: userEmail, friends: []) { (result) in
                        switch result {
                            
                        case .success(let user):
                            guard let user = user else { return }
                            StoredVariables.shared.userInfo["user"] = user
                            UserDefaults.standard.set(user.recordID.recordName, forKey: "userCKRecordID")
                            StoredVariables.shared.userInfo["userRef"] = user.appleUserRef
                            UserDefaults.standard.set(user.appleUserRef, forKey: "userRef")
                            self.saveUserID(credentials: credentials)
                            self.defaults.synchronize()
                            DispatchQueue.main.async {
                                self.finishLoggingIn()
                            }
                        case .failure(let error):
                            print(error.localizedDescription,"An error occured when trying to save user to cloudKit.")
                        }
                    }
                } else if result == true {
                    DispatchQueue.main.async {
                        self.saveUserID(credentials: credentials)
                        self.finishLoggingIn()
                    }
                }
            }
            
        case _ as ASPasswordCredential :
            break
        default:
            let alert = UIAlertController(title: "Apple SignIn", message: "Something went wrong with your Apple SignIn", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func saveUserID(credentials: ASAuthorizationAppleIDCredential) {
        self.defaults.set(credentials.user, forKey: Keys.userID)
        defaults.synchronize()
    }
    
    func checkUserDefaultsIsNil() {
        let username = defaults.value(forKey: Keys.userID) as? String ?? ""
        
        if username != "" {
            DispatchQueue.main.async {
                self.finishLoggingIn()
            }
        }
    }
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}


extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}

extension UIViewController {
    
    func showLoginViewController() {
        let storyboard = UIStoryboard(name: "MainMini", bundle: nil)
        if let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginViewController") as? LoginViewController {
            self.present(loginViewController, animated: true, completion: nil)
        }
    }
}
