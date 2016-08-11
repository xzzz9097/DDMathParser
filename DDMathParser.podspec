Pod::Spec.new do |s|
  s.name = 'DDMathParser'
  s.version = '1.1'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'String → Number'
  s.description  = <<-DESC
                   An extensible and flexible library to parse a string
                   as a mathematical expression and evaluate it.
                   DESC
  s.homepage = 'https://github.com/davedelong/DDMathParser'
  s.social_media_url = 'https://twitter.com/davedelong'
  s.authors = { 'Dave DeLong' => 'me@davedelong.com' }
  s.source = { :git => 'https://github.com/xzzz9097/DDMathParser.git', :tag => s.version }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'DDMathParser/*.{h,m}'

  s.requires_arc = true
  s.module_name = 'DDMathParser'
end
