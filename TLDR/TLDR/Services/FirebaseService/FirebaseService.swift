//
//  FirebaseService.swift
//  TLDR
//
//  Created by 유정주 on 2022/11/06.
//

import UIKit
import Firebase

final class FirebaseService {
    static let shared: FirebaseService = FirebaseService()
    init() { }

    //MARK: - Properties
    private var firebaseRef: DatabaseReference!
    
    //MARK: - Methods
    func configureFirebase() {
        FirebaseApp.configure()
    }
    
    func initDatabase() {
        firebaseRef = Database.database().reference()
    }
    
    func fetchVersion() async -> (String, String) {
        do {
            let snapshot = try await firebaseRef.child("version/data").getData()
            let snapData = snapshot.value as? [String: String]

            let versions: (String, String) = (snapData?["lasted"] ?? "0.0.0", snapData?["forced"] ?? "0.0.0")
            Logger.info("[fetchVersion] versions: \(versions)")

            return versions
        } catch {
            Logger.error("[fetchVersion] Error: \(error.localizedDescription)")
            return ("0.0.0", "0.0.0")
        }
    }
}
