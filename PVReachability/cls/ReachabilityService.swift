//
//  ReachabilityService.swift
//  PVReachability
//
//  Created by chandra sekhar p on 23/01/19.
//  Copyright © 2019 chandra sekhar p. All rights reserved.
//

import Foundation

@objc public enum ReachabilityState: Int{
    case reachable = 1
    case unreacahble
}

@objc public class ReachabilityService: NSObject{
    static let shared = ReachabilityService()
    private override init() {
        super.init()
        startNotify()
    }
    private let reachability = Reachability()!
    private var cellularType : String? = nil
    public var reachabilityStateChanged = { (_ state: ReachabilityState) -> Void  in }
    
    
    @objc public static var isNetworkAvailable: Bool{
        return ReachabilityService.shared.reachability.connection != .none
    }
    
    @objc public static var isWIFI: Bool{
        return ReachabilityService.shared.reachability.connection == .wifi
    }
    
    @objc public static var isCellular: Bool{
        return ReachabilityService.shared.reachability.connection == .cellular
    }
    
    @objc public static var networkString: String{
        return ReachabilityService.shared.stringFromNetWork()
    }
    
    func rech(_ change: (_ state: ReachabilityState) -> Void){
        change(.reachable)
    }
    
    
    private func stringFromNetWork() -> String{
        if ReachabilityService.isNetworkAvailable == false{
            return ""
        }
        if ReachabilityService.isCellular{
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
            self.reachabilityStateChanged(.reachable)
            if reachability.connection == .wifi {
            } else {
                self.cellularType = nil
            }
        }
        reachability.whenUnreachable = { _ in
            self.reachabilityStateChanged(.unreacahble)

            self.cellularType = nil
           // print("Not reachable")
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            //print("Unable to start notifier")
        }
    }
}
