Pod::Spec.new do |s|
  s.name             = 'PVReachability'
  s.version          = '0.1.0'
  s.summary          = 'Reachability summary'
  s.description      = <<-DESC
Reachability Description for pod
                       DESC
 
  s.homepage         = 'https://github.com/chandrasekhar-swift/PVReachability'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Chandra' => 'chandrasekhar.swift@gmail.com' }
  s.source           = { :git => 'https://github.com/chandrasekhar-swift/PVReachability.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'PVReachability/cls/*.swift'
 
end
