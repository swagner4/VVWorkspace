//
//  SheetsAPI.swift
//  VVScoring
//
//  Created by WAGNER, STEVEN on 2/28/17.
//  Copyright © 2017 Q Is Silqent. All rights reserved.
//

import UIKit
import AppAuth
import GTMAppAuth
import GoogleAPIClient
import GoogleAPIClientForREST

//Global Data
var fileList: [GTLDriveFile] = []
var currentFile: GTLDriveFile?
let sheetAPI = SheetsAPI()

var authorization: GTMAppAuthFetcherAuthorization?

let data = sheetAPI.getDataFromSheet()

//var authorization: GTMAppAuthFetcherAuthorization?

class SheetsAPI: NSObject
{
    private let kKeychainItemName = "VVScoring"
    private let kClientID = "8515603760-06n65qr36qolbj558fughnt8d800rvf0.apps.googleusercontent.com"
    private let kRedirectURI = "com.googleusercontent.apps.8515603760-06n65qr36qolbj558fughnt8d800rvf0:/oauthredirect"
    private let kIssuer = "https://accounts.google.com"
    
    private let VVSCORINGID = "1Q3WbC_37Ecmfg2Dh4U8M0S0g3zMfJwC0FvOCdHPshTo"
    
    public var fileListRetrieved = false
    
    let appDelegate = (UIApplication.shared.delegate! as! AppDelegate)
    let userDefaults = UserDefaults.standard
    let kAuthorizerKey = "authorization"
 
    
    
    private let service = GTLRSheetsService()
    private let driveService = GTLServiceDrive()
    
    func storeState() -> Bool
    {
        if authorization != nil && (authorization?.canAuthorize())! {
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: authorization!)
            self.userDefaults.set(encodedData, forKey: self.kAuthorizerKey)
            self.userDefaults.synchronize()
            return true
        }
        return false
    }
    
    func loadState() -> Bool
    {
        if let _ = userDefaults.object(forKey: kAuthorizerKey)
        {
            let decoded = userDefaults.object(forKey: kAuthorizerKey) as! Data
            let testAuth = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! GTMAppAuthFetcherAuthorization
            authorization = testAuth
            service.authorizer = authorization
            driveService.authorizer = authorization
            return true
        }
        return false
    }
    
    func removeState()
    {
        fileList = []
        currentFile = nil
        authorization = nil
        self.userDefaults.removeObject(forKey: self.kAuthorizerKey)
    }
    
    func auth(viewController: UIViewController)
    {
        if loadState()
        {
            //listDocuments()
        }
        else
        {
            let issuer = URL(string: kIssuer)!
            let redirectURI = URL(string: kRedirectURI)!
            
            // discovers endpoints
            OIDAuthorizationService.discoverConfiguration(forIssuer: issuer, completion: {(_ configuration: OIDServiceConfiguration?, _ error: Error?) -> Void in
                if configuration == nil {
                    return
                }
                // builds authentication request
                let scopes = [kGTLRAuthScopeSheetsSpreadsheets, kGTLRAuthScopeDrive, kGTLAuthScopeDrive, "https://www.googleapis.com/auth/userinfo.profile", "https://www.googleapis.com/auth/drive", "https://www.googleapis.com/auth/drive.readonly", "https://www.googleapis.com/auth/spreadsheets", "https://www.googleapis.com/auth/spreadsheets.readonly"]
                let request = OIDAuthorizationRequest(configuration: configuration!, clientId: self.kClientID, scopes: scopes, redirectURL: redirectURI, responseType: OIDResponseTypeCode, additionalParameters: nil)
                // performs authentication request
                self.appDelegate.currentAuthorizationFlow = OIDAuthState.authState(byPresenting: request, presenting: viewController, callback: {(_ authState: OIDAuthState?, _ error: Error?) -> Void in
                    if authState != nil {
                        authorization = GTMAppAuthFetcherAuthorization(authState: authState!)
                        self.service.authorizer = authorization
                        self.driveService.authorizer = authorization
                        if !self.storeState()
                        {
                            self.removeState()
                        }
                        self.listDocuments()
                        
                    }
                })
            })
        }
        
    }
 
    
    func getDataFromSheet() -> [[Any]]
    {
        var output: [[Any]] = [[]]

            let range = "Sheet1"
            let query = GTLRSheetsQuery_SpreadsheetsValuesGet.query(withSpreadsheetId: VVSCORINGID, range: range)
            service.executeQuery(query, completionHandler: {(_ ticket: GTLRServiceTicket, _ result: Any, _ error : Error?) -> Void in
                Swift.print(error)
                output = ((result as! GTLRSheets_ValueRange).values!)
            })
        
        return output
    }
    
    func updateSheetWithData(values: [[Any]])
    {
        if(currentFile != nil)
        {
            let data = GTLRSheets_ValueRange()
            data.range = "Sheet1"
            data.majorDimension = kGTLRSheets_DimensionRange_Dimension_Rows
            data.values = values
            
            let query = GTLRSheetsQuery_SpreadsheetsValuesUpdate.query(withObject: data, spreadsheetId: VVSCORINGID, range: data.range!)
            query.valueInputOption = kGTLRSheets_BatchUpdateValuesRequest_ValueInputOption_UserEntered
            service.executeQuery(query, delegate: self, didFinish: nil)
        }
    }
    
    func listDocuments() {
        let query = GTLQueryDrive.queryForFilesList()!
        query.pageSize = 1000
        query.fields = "nextPageToken, files(mimeType, id, name)"
        query.orderBy = "modifiedByMeTime desc,name"
        driveService.executeQuery(query, completionHandler:{(_ ticket: GTLServiceTicket?, _  response: Any, _ error: Error?) -> Void in
            Swift.print(error)
            if let files = (response as! GTLDriveFileList).files, !files.isEmpty
            {
                fileList = files as! [GTLDriveFile]
                for file in fileList
                {
                    if file.mimeType != "application/vnd.google-apps.spreadsheet" && !file.name.contains("[SCD]")
                    {
                        if let index = fileList.index(of: file) {
                            fileList.remove(at: index)
                        }
                    }
                }
            }
            currentFile = fileList[0]
            self.fileListRetrieved = true
        })
    }
    
    
}
