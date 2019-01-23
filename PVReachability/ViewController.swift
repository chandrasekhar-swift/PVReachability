//
//  ViewController.swift
//  PVReachability
//
//  Created by chandra sekhar p on 22/01/19.
//  Copyright © 2019 chandra sekhar p. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ReachabilityService.shared.reachabilityStateChanged = { state in
            switch state {
            case .reachable:
                print("Network reachable")
            case .unreacahble:
                print("Network unreachable")
            }
        }
        
        print(ReachabilityService.isCellular)
        print(ReachabilityService.isWIFI)
        print(ReachabilityService.networkString)
        print(ReachabilityService.isNetworkAvailable)        
    }
}

