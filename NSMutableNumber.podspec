Pod::Spec.new do |s|

# Common settings
  s.name         = "NSMutableNumber"
  s.version      = "1.0.7"
  s.summary      = "NSMutableNumber - mutable number realization, common to NSNumber"
  s.description  = <<-DESC
NSMutableNumber - mutable number realization, common to NSNumber.
                      DESC
  s.homepage     = "https://github.com/OlehKulykov/NSMutableNumber"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Oleh Kulykov" => "info@resident.name" }
  s.source       = { :git => 'https://github.com/OlehKulykov/NSMutableNumber.git', :tag => s.version.to_s }

# Platforms
  s.ios.deployment_target = "5.0"
  s.osx.deployment_target = "10.7"

# Build  
  s.source_files = '*.{h,mm}'
  s.public_header_files = '*.h'
  s.requires_arc = true
end
