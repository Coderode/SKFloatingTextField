#
# Be sure to run `pod lib lint SKFloatingTextField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SKFloatingTextField'
  s.version          = '0.1.0'
  s.summary          = 'This project will create a custom floating title textfield for iOS Applications.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'This project will create a custom floating title textfield for iOS Applications. Just give the custom class to a view (height and width as needed for the textfield) as SKFloatingTextField in the storyboard. Also to make changes import the SKFloatingTextField in the UIViewController and make IBOUTLET of the view in the UIViewController and you will be ready access all the properties, methods, delegate available in it.'
                       DESC

  s.homepage         = 'https://github.com/coderode/SKFloatingTextField'
  s.screenshots     = 'https://github.com/Coderode/Images/blob/master/iOS/floating-textfield/tuto1.png', 'https://github.com/Coderode/Images/blob/master/iOS/floating-textfield/tuto2.png','https://github.com/Coderode/Images/blob/master/iOS/floating-textfield/tuto3.png','https://github.com/Coderode/Images/blob/master/iOS/floating-textfield/tuto4.png','https://github.com/Coderode/Images/blob/master/iOS/floating-textfield/screen1.png','https://github.com/Coderode/Images/blob/master/iOS/floating-textfield/screen2.png','https://github.com/Coderode/Images/blob/master/iOS/floating-textfield/screen3.png','https://github.com/Coderode/Images/blob/master/iOS/floating-textfield/screen4.png','https://github.com/Coderode/Images/blob/master/iOS/floating-textfield/screen5.png','https://github.com/Coderode/Images/blob/master/iOS/floating-textfield/screen6.png','https://github.com/Coderode/Images/blob/master/iOS/floating-textfield/screen7.png','https://github.com/Coderode/Images/blob/master/iOS/floating-textfield/screen8.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'coderode' => 'sk9958814616@gmail.com' }
  s.source           = { :git => 'https://github.com/coderode/SKFloatingTextField.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.instagram.com/sandeep__kush/'

  s.ios.deployment_target = '13.0'

  s.source_files = 'SKFloatingTextField/Classes/**/*'
  s.swift_version = '5.0'
  s.resource_bundles = {
   'SKFloatingTextField' => ['SKFloatingTextField/Classes/SKFloatingTextField.xib']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
