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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(appleIDStateRevoked), name: ASAuthorizationAppleIDProvider.credentialRevokedNotification, object: nil)
        
        checkUserDefaultsIsNil()
        setUpSignInAppleButton()
    }
    
    func setUpSignInAppleButton() {
        let signInBtn = ASAuthorizationAppleIDButton()
        signInBtn.addTarget(self, action: #selector(handleAppleIdRequest), for: .touchUpInside)
        signInBtn.cornerRadius = 10
        //Add button on some view or stack
        
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
        self.showLoginViewController()
    }
    
    func finishLoggingIn() {
        
        var currentUser: String = ""
        
        UserController.shared.fetchUser(completion: { (result) in
            switch result {
                
            case .success(let user):
                currentUser = user.username.description
                StoredVariables.shared.userInfo["user"] = currentUser
            case .failure(let error):
                print(error.errorDescription)
            }
        })
        
        performSegue(withIdentifier: "toMainVC", sender: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
                    self.fetchAppleUserReference { (result) in
                        switch result {
                        case .success(let reference):
                            guard let reference = reference else { return completion(.failure(.noUserLoggedIn)) }
                            
                            let user = UserController.shared.createUserWith(username: userName, firstName: firstName, lastName: lastName, pdgaNumber: nil, email: email, appleUserReference: reference)
                            
                            UserController.shared.saveUser(user: user) { (result) in
                                switch result {
                                case true:
                                    self.user = user
                                    StoredVariables.shared.userInfo["user"] = user
                                    StoredVariables.shared.userInfo["collection"] = userCollection
                                    UserDefaults.standard.set(userCollection.collectionCKRecordID.recordName, forKey: "userCollectionID")
                                    
                                    CollectionController.shared.saveCollection(collection: userCollection) { (result) in
                                        self.saveUserID(credentials: credentials)
                                        DispatchQueue.main.async {
                                            self.finishLoggingIn()
                                        }
                                    }
                                    
                                case false:
                                    print("An error occured when trying to save user to cloudKit.")
                                }
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
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
    }
    
    func checkUserDefaultsIsNil() {
        let username = defaults.value(forKey: Keys.userID) as? String ?? ""
        
        if username != "" {
            DispatchQueue.main.async {
                self.finishLoggingIn()
            }
        }
    }
    private func fetchAppleUserReference(completion: @escaping (Result<CKRecord.Reference?, UserError>) -> Void) {
        
        CKContainer.default().fetchUserRecordID { (recordID, error) in
            if let error = error {
                completion(.failure(.ckError(error)))
            }
            
            if let recordID = recordID {
                let reference = CKRecord.Reference(recordID: recordID, action: .deleteSelf)
                completion(.success(reference))
            }
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginViewController") as? LogInViewController {
            self.present(loginViewController, animated: true, completion: nil)
        }
    }
}
