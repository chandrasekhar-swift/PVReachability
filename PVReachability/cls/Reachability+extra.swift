//
//  Reachability.swift
//  NewsDistill
//
//  Created by chandra sekhar p on 09/08/18.
//  Copyright © 2018 NewsDistill. All rights reserved.
//

import Foundation
import CoreTelephony

enum NetworkType {
    case unknown
    case noConnection
    case wifi
    case wwan2g
    case wwan3g
    case wwan4g
    case unknownTechnology(name: String)
    
    var trackingId: String {
        switch self {
        case .unknown:                      return "Unknown"
        case .noConnection:                 return "No Connection"
        case .wifi:                         return "Wifi"
        case .wwan2g:                       return "2G"
        case .wwan3g:                       return "3G"
        case .wwan4g:                       return "4G"
        case .unknownTechnology(let name):  return "Unknown Technology: \"\(name)\""
        }
    }
}

enum CellularType{
    case wwan2g
    case wwan3g
    case wwan4g
    case unknownTechnology(name: String)
    case unknown
    
    var string: String{
        switch self {
        case .wwan2g:                       return "2g"
        case .wwan3g:                       return "3g"
        case .wwan4g:                       return "4g"
        case .unknownTechnology(_):         return "unknown"
        case .unknown:                      return "unknown"
        }
    }
}

extension Reachability{
    func getCellularType() -> CellularType{
        guard let currentRadioAccessTechnology = CTTelephonyNetworkInfo().currentRadioAccessTechnology else { return .unknown }
        switch currentRadioAccessTechnology {
        case CTRadioAccessTechnologyGPRS,
             CTRadioAccessTechnologyEdge,
             CTRadioAccessTechnologyCDMA1x:
            return .wwan2g
        case CTRadioAccessTechnologyWCDMA,
             CTRadioAccessTechnologyHSDPA,
             CTRadioAccessTechnologyHSUPA,
             CTRadioAccessTechnologyCDMAEVDORev0,
             CTRadioAccessTechnologyCDMAEVDORevA,
             CTRadioAccessTechnologyCDMAEVDORevB,
             CTRadioAccessTechnologyeHRPD:
            return .wwan3g
        case CTRadioAccessTechnologyLTE:
            return .wwan4g
        default:
            return .unknownTechnology(name: currentRadioAccessTechnology)
        }
    }
}

@objc class NetworkManager: NSObject{
    static let shared = NetworkManager()
    private override init() {
        super.init()
        startNotify()
    }
    let reachability = Reachability()!
    private var cellularType : String? = nil
    
    @objc func isNetWork() -> Bool{
        return reachability.connection != .none
    }
    
    @objc func isWifi() -> Bool{
        return reachability.connection == .wifi
    }
    
    @objc func isCellular() -> Bool{
        return reachability.connection == .cellular
    }
    
    @objc func stringFromNetWork() -> String{
        if isCellular(){
            if self.cellularType == nil{
                self.cellularType = reachability.getCellularType().string
            }
            if let type = self.cellularType{
                return type
            }
        }
        return "wifi"
    }
    
    private func startNotify(){
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                self.cellularType = nil
                print("Reachable via Cellular")
            }
        }
        reachability.whenUnreachable = { _ in
            self.cellularType = nil
            print("Not reachable")
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}
