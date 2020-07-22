//
//  RemiRepository.swift
//  ReMi
//
//  Created by Cihan Hasanoglu on 07.07.20.
//  Copyright © 2020 Cihan Hasanoglu. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class RemiRepository: ObservableObject {
    let db = Firestore.firestore()
    
    @Published var remis = [Remi]()
    
    init() {
        loadData() 
    }
    
    func loadData() {
        
        let userId = Auth.auth().currentUser?.uid
        
        db.collection("remis")
        .order(by: "createdTime")
        .whereField("userID", isEqualTo: userId)
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.remis = querySnapshot.documents.compactMap { document in
                    do {
                        let x = try document.data(as: Remi.self)
                        return x
                    }
                    catch {
                        print(error)
                    }
                    return nil
                    
                }
            }
        }
    }
    
    func addRemi(_ remi: Remi) {
        do {
            var addedRemi = remi
            addedRemi.userID = Auth.auth().currentUser?.uid
            let _ = try db.collection("remis").addDocument(from: addedRemi)
        }
        catch {
            fatalError("Unable to encode remi: \(error.localizedDescription)")
        }

    }
    
    func updateRemi(_ remi: Remi) {
        if let remiID = remi.id {
            do {
                try db.collection("remis").document(remiID).setData(from: remi)
            }
            catch {
                fatalError("Unable to encode remi: \(error.localizedDescription)")
            }
            
        }

    }
    
    func deleteRemi(at offsets: IndexSet) {
        let itemToDelete = offsets.lazy.map { self.remis[$0]}
        itemToDelete.forEach { remi in
            if let id = remi.id {
                db.collection("remis").document(id).delete()
            }
        }
        
    }
}
