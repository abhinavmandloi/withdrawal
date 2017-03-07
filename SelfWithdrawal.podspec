Pod::Spec.new do |s|
 
  # 1
  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.name = “Selfwithdrawal”
  s.summary = "Selfwithdrawal lets a user select an ice cream flavor."
  s.requires_arc = true
 
  # 2
  s.version = "0.1.0"
 
  # 3
  s.license = { :type => "MIT", :file => "LICENSE" }
 
  # 4 - Replace with your name and e-mail address
  s.author = { “Abhinav” => "abhinav.mandloi@mindstix.com" }
 
  # For example,
  # s.author = { “Abhinav” => “abhinav.mandloi@mindstix.com" }
 
 
  # 5 - Replace this URL with your own Github page's URL (from the address bar)
  s.homepage = "https://github.com/abhinavmandloi/withdrawal.git"
 
  # For example,
  # s.homepage = "https://github.com/abhinavmandloi/withdrawal"
 
 
  # 6 - Replace this URL with your own Git URL from "Quick Setup"
  s.source = { :git => "[Your RWPickFlavor Git URL Goes Here]", :tag => "#{s.version}"}
 
  # For example,
  # s.source = { :git => "https://github.com/abhinavmandloi/withdrawal.git", :tag => "#{s.version}"}
 
 
  # 7
  s.framework = "UIKit"
  s.dependency ‘AFNetworking’~> ‘2.6.3’
 
  # 8
  s.source_files = "Selfwithdrawal/**/*.{ObjectiveC}”
 
  # 9
  s.resources = "Selfwithdrawal/**/*.{png,jpeg,jpg,storyboard,xib}"
end
