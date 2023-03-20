//
//  FirebaseService.swift
//  TLDR
//
//  Created by 유정주 on 2022/11/06.
//

import UIKit
import Firebase
import JeongLogger

final class FirebaseService {
    static let shared: FirebaseService = FirebaseService()
    init() { }

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
            JeongLogger.error(error.localizedDescription)
        }
        
        let snapData = snapshot?.value as? [String: String]
        
        let result = snapData?["result"] ?? "fail"
        let notice = snapData?["notice"] ?? ""
        JeongLogger.log("result: \(result) / notice: \(notice)")
        
        let stateData = StateData(state: Result(rawValue: result) ?? .fail,
                                  notice: notice)
        
        return stateData
    }

    func fetchVersion() async -> VersionData {
        var snapshot: DataSnapshot?
        do {
            snapshot = try await firebaseRef.child("version").getData()
        } catch {
            JeongLogger.error(error.localizedDescription)
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
        
        JeongLogger.log("versions: \(versionData)")
        return versionData
    }
    
    func fetchPolicyURL() async -> String {
        var snapshot: DataSnapshot?
        do {
            snapshot = try await firebaseRef.child("policyURL").getData()
        } catch {
            JeongLogger.error(error.localizedDescription)
        }
        
        let policyURL = snapshot?.value as? String ?? ""
        
        return policyURL
    }
}
