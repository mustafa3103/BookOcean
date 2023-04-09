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
        Auth.auth().createUser(withEmail: user.email, password: user.password) { authResult, error in
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
}

