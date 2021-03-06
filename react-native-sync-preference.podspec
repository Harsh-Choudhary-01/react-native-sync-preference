require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-sync-preference"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-sync-preference
                   DESC
  s.homepage     = "https://github.com/Harsh-Choudhary-01/react-native-sync-preference"
  s.license      = "MIT"
  # s.license    = { :type => "MIT", :file => "FILE_LICENSE" }
  s.authors      = { "Harsh Choudhary" => "harsh@pickodelivery.com" }
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/Harsh-Choudhary-01/react-native-sync-preference.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,swift}"
  s.requires_arc = true

  s.dependency "React"
  # ...
  # s.dependency "..."
end

