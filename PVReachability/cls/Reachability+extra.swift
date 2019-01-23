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
        //print(CTTelephonyNetworkInfo().serviceCurrentRadioAccessTechnology ?? "nill")
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

