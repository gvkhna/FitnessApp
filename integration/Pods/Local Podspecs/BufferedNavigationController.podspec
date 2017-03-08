Pod::Spec.new do |s|
  s.name     = 'BufferedNavigationController'
  s.version  = '0.0.1'
  s.summary  = 'UINavigationController that can queue concurrent animation changes without breaking the interface'
  s.homepage = 'https://github.com/Plasma/BufferedNavigationController'
  s.source   = { :git => 'git://github.com/Plasma/BufferedNavigationController.git' }

  s.description = 'BufferedNavigationController extends UINavigationController to automatically queue up transitions between view controllers.'

  s.source_files = '*.{h,m}'
end
