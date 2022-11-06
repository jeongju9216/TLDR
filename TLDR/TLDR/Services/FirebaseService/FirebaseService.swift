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
    
    func fetchState() async -> (Bool, String) {
        do {
            let snapshot = try await firebaseRef.child("state").getData()
            let snapData = snapshot.value as? [String: Any]
            
            let result = snapData?["result"] as? String ?? "failed"
            let notice = snapData?["notice"] as? String ?? ""
            Logger.info("result: \(result) / notice: \(notice)")
            
            return (result.lowercased() == "ok", notice)
        } catch {
            Logger.error("\(error.localizedDescription)")
            return (false, "failed")
        }
    }

    func fetchVersion() async -> (String, String) {
        do {
            let snapshot = try await firebaseRef.child("version").getData()
            let snapData = snapshot.value as? [String: String]

            let lastedVersion = snapData?["lasted"] ?? "0.0.0"
            let forcedVersion = snapData?["forced"] ?? "0.0.0"
            
            let versions: (String, String) = (lastedVersion, forcedVersion)
            Logger.info("versions: \(versions)")

            return versions
        } catch {
            Logger.error("\(error.localizedDescription)")
            return ("0.0.0", "0.0.0")
        }
    }
}
