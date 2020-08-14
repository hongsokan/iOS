//
//  FacebookViewController.swift
//  FirebaseLogin
//
//  Created by 안홍석 on 2020/08/13.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class FacebookViewController: UIViewController, LoginButtonDelegate {
    
    @IBOutlet weak var facebookLoginButton: FBLoginButton!
    
    /*
    let loginButton = FBLoginButton()
    loginButton.center = view.center
    view.addSubview(loginButton)
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        
        facebookLoginButton.delegate = self
        
        /*
        앱에는 한 번에 한 명의 사용자만 로그인할 수 있습니다. Facebook에서는 [FBSDKAccessToken currentAccessToken]을 통해 사용자가 앱에 로그인했음을 표시합니다.
        FBSDKLoginManager에서 이 토큰을 설정하고, currentAccessToken을 설정할 때 이 토큰을 자동으로 키체인 캐시에도 씁니다.
        FBSDKAccessToken에는 사용자를 식별하는 데 사용할 수 있는 userID가 포함되어 있습니다.
        로드할 때 기존 토큰을 확인하려면 View Controller를 업데이트해야 합니다. 이렇게 하면 누군가 이미 앱에 권한을 부여한 경우 로그인 플로를 불필요하게 다시 표시하지 않을 수 있습니다.
        */
        if let token = AccessToken.current, !token.isExpired {
            // User is logged in, do work such as go to next view controller.
        }
        
        /*
        Facebook 로그인을 사용할 때 앱에서 사용자 데이터에 대한 권한을 요청할 수 있습니다.
        Facebook 로그인 버튼의 읽기 권한
        추가적인 읽기 권한을 요청하려면 FBSDKLoginButton 개체의 readPermissions 속성을 설정하세요.
        */
        facebookLoginButton.permissions = ["public_profile", "email"]
    }
    
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        if (result?.token == nil) { return }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
            print(error.localizedDescription)
            // ...
            return
            }
        }
        
        LoginManager().logOut()
          // User is signed in
          // ...
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
