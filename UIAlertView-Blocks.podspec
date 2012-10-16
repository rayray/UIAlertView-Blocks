Pod::Spec.new do |s|
  s.name         = "UIAlertView-Blocks"
  s.version      = "0.0.1"
  s.summary      = "Support for blocks in UIAlertView to replace the use of UIAlertViewDelegate."
  s.description  = <<-DESC
                      This simple category adds support to use block callbacks with `UIAlertView`.
                      It doesn't override the use of `UIAlertViewDelegate` since the delegate methods will still be called if a delegate is provided and assuming that they are implemented.
                    DESC
  s.homepage     = "https://github.com/sguillope/UIAlertView-Blocks"

  s.license      = 'CCPL'
  s.author       = "Sylvain Guillopé"
  
  s.source       = { :git => "https://github.com/sguillope/UIAlertView-Blocks.git", :tag => "1.0" }
  s.platform     = :ios, '6.0'
  s.source_files = '*.{h,m}'
end
