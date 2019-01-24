//
//  ViewController.swift
//  PVReachability
//
//  Created by chandra sekhar p on 22/01/19.
//  Copyright © 2019 chandra sekhar p. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let notifier = PVReachabilityNotifier()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notifier.notify = { state in
            switch state {
            case .reachable:
                print(PVReachabilityService.isCellular)
                print(PVReachabilityService.isWIFI)
                print(PVReachabilityService.networkString)
                print(PVReachabilityService.isNetworkAvailable)
            case .unreacahble:
                print("Network unreachable")
            }
        }
    }
}

