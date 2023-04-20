//
//  FirebaseManager.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 5.04.2023.
//

import FirebaseFirestore
import FirebaseAuth

final class FirebaseManager {
    
    var dbf: Firestore!
    // var auth: Auth! -> Bununla da dene sonrasında.

    init() {
        dbf = Firestore.firestore()
    }

    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error was occured while log out from app. Error is: \(error.localizedDescription)")
        }
    }

    func changePassword(newPassword: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().currentUser?.updatePassword(to: newPassword) { error in
            if let error {
                // Error was occured while changing password.
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func getCurrentUserEmail() -> String {
        Auth.auth().currentUser?.email ?? ""
    }

    func getCurrentUserViaUserModel(completion: @escaping (UserModel) -> Void) {
        let email = getCurrentUserEmail()
        
        getAllUsers { users in
            for user in users {
                if user.email == email {
                    completion(user)
                    break
                }
            }
        }
    }

    func getAllUsers(completion: @escaping ([UserModel]) -> Void) {
        var users: [UserModel] = []
        let firebaseUsersRef = dbf.collection("Users")
        
        firebaseUsersRef.getDocuments { querySnaphot, error in
            if let querySnaphot {
                for document in querySnaphot.documents {
                    let data = document.data()
                    let user = UserModel(email: data["email"] as? String ?? "", name: data["name"] as? String ?? "", surname: data["surname"] as? String ?? "", password: data["password"] as? String ?? "")
                    users.append(user)
                }
                completion(users)
            }
        }
    }
    
    func loadDataFromFirebase(collection: String, completion: @escaping ([FirebaseBookModel]) -> Void) {
        let firebaseBookRef = dbf.collection(collection)
        
        firebaseBookRef.addSnapshotListener { querySnapshot, error in
            if let querySnapshot {
                var firebaseBooks: [FirebaseBookModel] = []
                
                for document in querySnapshot.documents {
                    let data = document.data()
                    let book = FirebaseBookModel(title: data["title"] as? String ?? "",
                                                 description: data["description"] as? String ?? "",
                                                 author: data["author"] as? String ?? "",
                                                 imageLink: data["imageLink"] as? String ?? "",
                                                 userComment: data["userComment"] as? String ?? "",
                                                 userEmail: data["userEmail"] as? String ?? "",
                                                 categories: data["categories"] as? String ?? "")
                    firebaseBooks.append(book)
                }
                completion(firebaseBooks)
            } else {
                print("Error retrieving documents: \(error?.localizedDescription ?? "")")
                completion([])
            }
        }
    }

    func loginWithFirebase(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { auth, error in
            if auth != nil {
                // Giriş başarılı.
                completion(true)
            }
            if error != nil {
                completion(false)
            }
        }
    }

    func signUpUser(user: UserModel, completion: @escaping (Bool) -> Void) {
        let userPassword = user.password ?? ""
        Auth.auth().createUser(withEmail: user.email, password: userPassword) { authResult, error in
            if error != nil {
                completion(false)
            }

            if authResult != nil {
                
                self.createNewUser(user)
                completion(true)
                
            }
        }
    }
    
    func createNewUser(_ userModel: UserModel) {
        dbf.collection("Users").addDocument(data: ["name": userModel.name, "email": userModel.email, "password": userModel.password ?? "",
                                                   "surname": userModel.surname ?? ""])
    }

    func addNewBookToFirebase(collection: String, _ firebaseBookModel: FirebaseBookModel) {
        dbf.collection(collection).addDocument(data: ["title": firebaseBookModel.title, "author": firebaseBookModel.author, "description": firebaseBookModel.description,
                                                                     "imageLink": firebaseBookModel.imageLink, "userEmail": firebaseBookModel.userEmail, "categories": firebaseBookModel.categories, "userComment": firebaseBookModel.userComment])
    }
}

