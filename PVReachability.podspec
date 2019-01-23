Pod::Spec.new do |s|
  s.name             = 'PVReachability'
  s.version          = '0.1.1'
  s.summary          = 'Reachability V0.1.1'
  s.description      = <<-DESC
• Now you can access network flags using class methods
        print(ReachabilityService.isCellular)
        print(ReachabilityService.isWIFI)
        print(ReachabilityService.networkString)
        print(ReachabilityService.isNetworkAvailable)
• Now you can get network state change as block
ReachabilityService.shared.reachabilityStateChanged = { state in
            switch state {
            case .reachable:
                print("Network reachable")
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
