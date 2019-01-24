Pod::Spec.new do |s|
  s.name             = 'PVReachability'
  s.version          = '0.1.3'
  s.summary          = 'Reachability Helper with network names & block notifier'
  s.description      = <<-DESC
• Now you can get network state change as block
    let notifier = PVReachabilityNotifier()
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
                       DESC
 
  s.homepage         = 'https://github.com/chandrasekhar-swift/PVReachability'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Chandra' => 'chandrasekhar.swift@gmail.com' }
  s.source           = { :git => 'https://github.com/chandrasekhar-swift/PVReachability.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'PVReachability/cls/*.swift'
 
end
