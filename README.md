# MX Atrium Swift sample application
This is a simple "Hello Transactions!" application written in Swift 3 using Xcode 8. The purpose of this application is to demonstrate using the MX Atrium API to read transactional data from an existing user and display it inside a UITableView.

## Requirements:
- Xcode 8
- Swift 3
- [MX Atrium developer account](https://atrium.mx.com)

## Installation

###CocoaPods

Install the latest [CocoaPods](https://cocoapods.org/) version that supports Swift 3
````
sudo gem install cocoapods --pre
````
or try the following if you experience any permission issues
````
sudo gem install -n /usr/local/bin cocoapods --pre
````

The included Pod file adds the latest version of both Alamofire and SwiftyJSON

````ruby
# Uncomment this line to define a global platform for your project
platform :ios, '9.0'

target 'MXAtrium' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MXAtrium
	pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git', :branch => 'master'
	pod 'SwiftyJSON', :git => 'https://github.com/SwiftyJSON/SwiftyJSON.git', :branch => 'master'
end

````
Run the following command:
````
pod install
````
Open the project using the workspace file created by CocoaPods ````MXAtrium.xcworkspace````
