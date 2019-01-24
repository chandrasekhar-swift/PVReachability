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


@objc public enum ReachabilityState: Int{
    case reachable = 1
    case unreacahble
}

public typealias ReachabilityStateChange = (_ state: ReachabilityState) -> ()

@objc public class PVReachabilityService: NSObject{
    public static let shared = PVReachabilityService()
    private override init() {
        super.init()
        startNotify()
    }
    
    private var reachability = PVReachability()!
    private let notifier = PVReachabilityNotifier()
    private var cellularType : String? = nil
    
    @objc public static var isNetworkAvailable: Bool{
        return PVReachabilityService.shared.reachability.connection != .none
    }
    
    @objc public static var isWIFI: Bool{
        return PVReachabilityService.shared.reachability.connection == .wifi
    }
    
    @objc public static var isCellular: Bool{
        return PVReachabilityService.shared.reachability.connection == .cellular
    }
    
    @objc public static var networkString: String{
        return PVReachabilityService.shared.stringFromNetWork()
    }
    
    private func stringFromNetWork() -> String{
        if PVReachabilityService.isNetworkAvailable == false{
            return ""
        }
        if PVReachabilityService.isCellular{
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
        notifier.notify = { state in
            self.cellularType = nil
            switch state {
            case .reachable:
                if let reach = PVReachability(){
                    self.reachability = reach
                }
            case .unreacahble:
                break
            }
        }
    }
}

@objc public class PVReachabilityNotifier: NSObject{
    
    private var reachability = PVReachability()!
    public var notify: ReachabilityStateChange?
    
    public override init() {
        super.init()
        startNotify()
    }
    
    @objc private func startNotify(){
        reachability.whenReachable = {[weak self] _ in
            self?.notify?(.reachable)
        }
        
        reachability.whenUnreachable = { [weak self] _ in
            self?.notify?(.unreacahble)
        }
        
        do {
            try reachability.startNotifier()
        } catch {}
    }
}
