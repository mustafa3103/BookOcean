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
                print(error.localizedDescription)
                completion(false)
            } else {
                completion(true)
            }
        }
    }

    func getCurrentUserViaUserModel(completion: @escaping (UserModel, String) -> Void) {
        let email = getCurrentUserEmail()
        
        getAllUsers { users, documentIDs in
            for index in 0 ..< users.count {
                let user = users[index]
                let documentID = documentIDs[index]
                
                if user.email == email {
                    completion(user, documentID)
                }
            }
        }
    }

    func getAllUsers(completion: @escaping ([UserModel], [String]) -> Void) {
        var users: [UserModel] = []
        var documentIDs: [String] = []
        let firebaseUsersRef = dbf.collection("Users")
        
        firebaseUsersRef.getDocuments { querySnaphot, error in
            if let querySnaphot = querySnaphot {
                for document in querySnaphot.documents {
                    let data = document.data()
                    
                    let user = UserModel(email: data["email"] as? String ?? "",
                                         name: data["name"] as? String ?? "",
                                      surname: data["surname"] as? String ?? "",
                                    password: data["password"] as? String ?? "",
                                         friends: data["friends"] as? [String])
                    
                    users.append(user)
                    documentIDs.append(document.documentID)
                }
                completion(users, documentIDs)
            }
        }
    }

    func getCurrentUserFriends(completion: @escaping ([UserModel]) -> Void) {
        var userFriends: [UserModel] = []
        
        getCurrentUserViaUserModel { currentUser, documentId in
            
            self.getAllUsers { friends, documentIds in
                for friend in friends {
                    guard let currentUserFriends = currentUser.friends else { return }
                    if currentUserFriends.contains(friend.email) {
                        userFriends.append(friend)
                    }
                }
                completion(userFriends)
            }
        }
    }

    func deleteSelectedFriend(_ selectedFriend: UserModel) {
        getCurrentUserViaUserModel { currentUser, currentUserId in
            let firebaseUserRef = self.dbf.collection("Users").document(currentUserId)
            
            // Remove the selected friend from the friends array
            firebaseUserRef.updateData(["friends": FieldValue.arrayRemove([selectedFriend.email])]) { error in
                if let error = error {
                    print("Error removing friend: \(error.localizedDescription)")
                } else {
                    print("Friend removed successfully")
                }
            }
        }
    }
    
    func addFriend(friendUserModel: UserModel) {

        getCurrentUserViaUserModel { currentUser, currentUserId in
            let userReference = self.dbf.collection("Users").document(currentUserId)
            
            var currentUserFriends = currentUser.friends ?? []
            currentUserFriends.append(friendUserModel.email)
            
            let currentUserWithUpdatedFriends = UserModel(email: currentUser.email, name: currentUser.name, surname: currentUser.surname, password: currentUser.password, friends: currentUserFriends)
            
            let friendEmail = friendUserModel.email
            let friendUserRef = self.dbf.collection("Users").whereField("email", isEqualTo: friendEmail)
            
            friendUserRef.getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error adding friend: \(error.localizedDescription)")
                    return
                }
                
                guard let document = querySnapshot?.documents.first else {
                    print("Error adding friend: friend user not found")
                    return
                }
                
                var friendUserModel = UserModel(email: document.get("email") as? String ?? "", name: document.get("name") as? String ?? "", surname: document.get("surname") as? String, password: document.get("password") as? String, friends: document.get("friends") as? [String] ?? [])

                friendUserModel.friends?.append(currentUser.email)
                let friendUserRef = document.reference
                friendUserRef.updateData(["friends": friendUserModel.friends ?? [String]()]) { error in
                    if let error = error {
                        print("Error adding friend: \(error.localizedDescription)")
                    } else {
                        print("Friend added successfully to friend user's friends list")
                    }
                }
            }

            userReference.updateData(["friends": currentUserWithUpdatedFriends.friends ?? [String]()]) { error in
                if let error = error {
                    print("Error adding friend: \(error.localizedDescription)")
                } else {
                    print("Friend added successfully to current user's friends list")
                }
            }
        }
    }

    func createNewUser(_ userModel: UserModel) {
        dbf.collection("Users").addDocument(data: ["name": userModel.name, "email": userModel.email, "password": userModel.password ?? "",
                                                   "surname": userModel.surname ?? ""])
    }

    func getCurrentUserEmail() -> String {
        Auth.auth().currentUser?.email ?? ""
    }

    func loadReadingList(completion: @escaping ([FirebaseBookModel]) -> Void) {
        let currentUserEmail = getCurrentUserEmail()
        let readingListBookRef = dbf.collection("SelectedBooks").whereField("userEmail", isEqualTo: currentUserEmail)
        
        readingListBookRef.getDocuments { query, error in
            if let query {
                var readingListBooks: [FirebaseBookModel] = [FirebaseBookModel]()
                
                for document in query.documents {
                    let data = document.data()
                    
                    let book = FirebaseBookModel(title: data["title"] as? String ?? "",
                                                 description: data["description"] as? String ?? "",
                                                 author: data["author"] as? String ?? "",
                                                 imageLink: data["imageLink"] as? String ?? "",
                                                 userComment: data["userComment"] as? String ?? "",
                                                 userEmail: data["userEmail"] as? String ?? "",
                                                 categories: data["categories"] as? String ?? "")
                    readingListBooks.append(book)
                }
                completion(readingListBooks)
            }
        }
    }

    func loadDataFromFirebase(collection: String, completion: @escaping ([FirebaseBookModel]) -> Void) {
        let firebaseBookRef = dbf.collection(collection)
        
        getCurrentUserFriends { friends in
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
                        
                        for friend in friends {
                            if friend.email == book.userEmail {
                                firebaseBooks.append(book)
                            }
                        }
                    }
                    completion(firebaseBooks)
                } else {
                    print("Error retrieving documents: \(error?.localizedDescription ?? "")")
                    completion([])
                }
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

    func addNewBookToFirebase(collection: String, _ firebaseBookModel: FirebaseBookModel) {
        dbf.collection(collection).addDocument(data: ["title": firebaseBookModel.title, "author": firebaseBookModel.author, "description": firebaseBookModel.description,
                                                      "imageLink": firebaseBookModel.imageLink, "userEmail": firebaseBookModel.userEmail, "categories": firebaseBookModel.categories, "userComment": firebaseBookModel.userComment])
    }
}
