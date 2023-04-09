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
    
    func getAllUsers() -> [UserModel]? {
        var users: [UserModel]?
        let firebaseUsersRef = dbf.collection("Users")
        
        firebaseUsersRef.getDocuments { querySnaphot, error in
            if let querySnaphot {
                for document in querySnaphot.documents {
                    let data = document.data()
                    
                }
            }
        }
        
        return users
    }
    
    func loadDataFromFirebase(completion: @escaping ([FirebaseBookModel]) -> Void) {
        let firebaseBookRef = dbf.collection("Books")
        
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
    
    func getCurrentUserEmail() -> String {
        Auth.auth().currentUser?.email ?? ""
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

    func addNewBookToFirebase(_ firebaseBookModel: FirebaseBookModel) {
        dbf.collection("Books").addDocument(data: ["title": firebaseBookModel.title, "author": firebaseBookModel.author, "description": firebaseBookModel.description,
                                                                     "imageLink": firebaseBookModel.imageLink, "userEmail": firebaseBookModel.userEmail, "categories": firebaseBookModel.categories, "userComment": firebaseBookModel.userComment])
    }
}

