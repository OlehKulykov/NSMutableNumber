Pod::Spec.new do |s|

# Common settings
  s.name         = "NSMutableNumber"
  s.version      = "1.1.1"
  s.summary      = "NSMutableNumber - full thread safe mutable NSNumber implementation"
  s.description  = <<-DESC
NSMutableNumber - full thread safe mutable NSNumber implementation.
                      DESC
  s.homepage     = "https://github.com/OlehKulykov/NSMutableNumber"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Oleh Kulykov" => "info@resident.name" }
  s.source       = { :git => 'https://github.com/OlehKulykov/NSMutableNumber.git', :tag => s.version.to_s }

# Platforms
  s.ios.deployment_target = "7.0"
  s.osx.deployment_target = "10.7"
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'

# Build  
  s.source_files = '*.{h,hpp,mm}'
  s.public_header_files = '*.h'
  s.requires_arc = true
  s.libraries = 'pthread', 'stdc++'
end
