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
    
    func signUpUser(user: UserModel) -> Bool {
        var result = false
        let userPassword = user.password ?? ""
        Auth.auth().createUser(withEmail: user.email, password: userPassword) { authResult, error in
            if error != nil {
                print("Error was occured while signing new user to the application.")
            }

            if authResult != nil {
                print("User created succesfully.")
                // Burada Users collectionına datayı setle. addDocument metodu kullanarak.
                //
                result = true
            }
        }
        return result
    }

    func getCurrentUserEmail() -> String {
        Auth.auth().currentUser?.email ?? ""
    }

    func addNewBookToFirebase(_ firebaseBookModel: FirebaseBookModel) {
        dbf.collection("Books").addDocument(data: ["title": firebaseBookModel.title, "author": firebaseBookModel.author, "description": firebaseBookModel.description,
                                                                     "imageLink": firebaseBookModel.imageLink, "userEmail": firebaseBookModel.userEmail, "categories": firebaseBookModel.categories, "userComment": firebaseBookModel.userComment])
    }
}

