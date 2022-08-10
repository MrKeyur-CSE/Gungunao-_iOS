//
//  FirebaseManager.swift
//  Gungunaoo
//
//  Created by Keyur Panchal on 09/08/22.
//

import Foundation
import Firebase

final class FirebaseAuthManager {
    static func createUser(firstName: String, lastName: String, email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                let db = Firestore.firestore()
                
                db.collection("userInfo").document(user.uid).setData(["firstName": firstName, "lastName": lastName, "emailAddress": email]) { (error) in
                    if error != nil {
                        //self.showError("Error saving user data")
                        completionBlock(false)
                    }
                    completionBlock(true)
                }
            } else {
                completionBlock(false)
            }
        }
    }
    
    static func signIn(email: String, pass: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if error != nil {
                completionBlock(false)
            } else {
                completionBlock(true)//result?.user.uid
            }
        }
    }
}

final class FirebaseManager {

    static private var db = Firestore.firestore()
    
    static func fetchMusicUrls(completionBlock: @escaping (_ audios: [String]) -> Void) {
        db.collection("music").getDocuments { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            var urls = [String]()
            documents.forEach { documentSnapshot in
                if let url = documentSnapshot.data()["url"] as? String {
                    urls.append(url)
                }
            }
            completionBlock(urls)
        }
    }

    static func logout() {
        Player.share.pause()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        do {
            try Auth.auth().signOut()
        } catch {

        }
    }
}
