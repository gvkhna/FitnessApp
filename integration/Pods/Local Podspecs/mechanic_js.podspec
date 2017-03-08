Pod::Spec.new do |s|
  s.name     = 'mechanic_js'
  s.version  = '0.2'
  s.summary  = 'The power of UIAutomation with the simplicity of modern' \
               'javascript CSS selector engines.'
  s.homepage = 'http://www.cozykozy.com/mechanicjs/'
  s.authors  = { 'Jason Kozemczak' => 'jason.kozemczak@gmail.com' }
  s.source   = { :git => 'https://github.com/jaykz52/mechanic.git' }

  s.description = 'mechanic.js lets you take the power of UIAutomation ' \
                  'with the simplicity of modern javascript CSS selector ' \
                  'engines to make your UIAutomation scripts terse and beautiful.'

  s.platform = :ios
  # s.platform = :osx # UIAutomation isn't yet on OS X

  s.preserve_paths = 'src/*.js'
end
