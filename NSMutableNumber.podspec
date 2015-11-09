Pod::Spec.new do |s|

# Common settings
  s.name         = "NSMutableNumber"
  s.version      = "1.0.1"
  s.summary      = "NSMutableNumber - simple mutable NSNumber wrapper"
  s.description  = <<-DESC
NSMutableNumber - simple mutable NSNumber Objective-C wrapper.
                      DESC
  s.homepage     = "https://github.com/OlehKulykov/NSMutableNumber"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Oleh Kulykov" => "info@resident.name" }
  s.source       = { :git => 'https://github.com/OlehKulykov/NSMutableNumber.git', :tag => s.version.to_s }

# Platforms
  s.ios.deployment_target = "5.0"
  s.osx.deployment_target = "10.7"

# Build  
  s.source_files = '*.{h,m}'
  s.public_header_files = '*.h'
  s.requires_arc = true
end
