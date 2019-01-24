/*
 //  Created by chandra sekhar p on 23/01/19.
 //  Copyright © 2019 chandra sekhar p. All rights reserved.
 //
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2. Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 */

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

extension PVReachability{
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

