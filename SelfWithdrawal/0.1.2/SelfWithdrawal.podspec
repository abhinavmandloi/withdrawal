Pod::Spec.new do |s|
 
  # 1
s.name = "SelfWithdrawal"
  s.platform = :ios, '7.0'
  s.ios.deployment_target = '8.0'
  s.summary = "SelfWithdrawal lets a user select an ice cream flavor."
  s.requires_arc = true
 
  # 2
  s.version = "0.1.2"
 
  # 3
  s.license = { :type => "MIT", :file => "LICENSE" }
 
  # 4
  s.author = {"Abhinav Mandloi" => "abhinav.mandloi@mindstix.com"}
 
  # For example,
  # s.author = { “Abhinav” => “abhinav.mandloi@mindstix.com" }
 
 
  # 5 - Replace this URL with your own Github page's URL (from the address bar)
  s.homepage = "https://github.com/abhinavmandloi/withdrawal.git"
 
  # For example,
  # s.homepage = "https://github.com/abhinavmandloi/withdrawal"
 
 
  # 6 - Replace this URL with your own Git URL from "Quick Setup"
  s.source = { :git => "https://github.com/abhinavmandloi/withdrawal.git", :tag => "#{s.version}", :commit => "4c66afeabcda270a0f5f2bd5af049f24dea54d1e" }
 
  # 7
  s.framework = "UIKit"
  s.dependency 'AFNetworking', '~>2.6.3' 
 
  # 8
  s.source_files = "SelfWithdrawal/*.{h,m}"

end
