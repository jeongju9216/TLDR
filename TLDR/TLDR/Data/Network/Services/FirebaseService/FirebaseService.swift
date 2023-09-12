//
//  FirebaseService.swift
//  TLDR
//
//  Created by 유정주 on 2022/11/06.
//

import UIKit
import Firebase

final class FirebaseService: Loggable {
    static let shared: FirebaseService = FirebaseService()
    private init() { }

    //MARK: - Properties
    private var firebaseRef: DatabaseReference!
    
    //MARK: - Methods
    func initFirebase() {
        configureFirebase()
        initFirebaseRef()
    }
    
    func configureFirebase() {
        FirebaseApp.configure()
    }
    
    func initFirebaseRef() {
        firebaseRef = Database.database().reference()
    }
    
    func fetchState() async -> StateData {
        var snapshot: DataSnapshot?
        do {
            snapshot = try await firebaseRef.child("state").getData()
        } catch {
            jlog(.error, error.localizedDescription)
        }
        
        let snapData = snapshot?.value as? [String: String]
        
        let result = snapData?["result"] ?? "fail"
        let notice = snapData?["notice"] ?? ""
        
        let stateData = StateData(state: Result(rawValue: result) ?? .fail,
                                  notice: notice)
        
        return stateData
    }

    func fetchVersion() async -> VersionData {
        var snapshot: DataSnapshot?
        do {
            snapshot = try await firebaseRef.child("version").getData()
        } catch {
            jlog(.error, error.localizedDescription)
        }
        
        let snapData = snapshot?.value as? [String: String]

        let forced = snapData?["forced"] ?? "0.0.0"
        let lasted = snapData?["lasted"] ?? "0.0.0"
        let appleID = snapData?["appleID"] ?? ""
        let bundleID = snapData?["bundleID"] ?? ""
        
        let versionData: VersionData = VersionData(forced: forced,
                                                   lasted: lasted,
                                                   appleID: appleID,
                                                   bundleID: bundleID)
        
        return versionData
    }
    
    func fetchDomain() async -> String {
        var snapshot: DataSnapshot?
        do {
            snapshot = try await firebaseRef.child("domain").getData()
        } catch {
            jlog(.error, error.localizedDescription)
        }
        
        let domain = snapshot?.value as? String ?? ""

        return domain
    }
    
    func fetchPolicyURL() async -> String {
        var snapshot: DataSnapshot?
        do {
            snapshot = try await firebaseRef.child("policyURL").getData()
        } catch {
            jlog(.error, error.localizedDescription)
        }
        
        let policyURL = snapshot?.value as? String ?? ""
        
        return policyURL
    }
}
