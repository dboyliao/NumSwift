Pod::Spec.new do |s|
s.name         = "NumSwift"
s.version      = "1.0.4"
s.summary      = "Numeric Operations for Swift"

s.description  = <<-DESC
This project is just a simple practice on Swift and Accelerate framework. The swift files contain some basic function used in numeric computation. The main functionality is build upon Accelearate framework which leaverages SIMD of the CPU, which make the codes run faster than native Swift code.

I am a big fan of python. In this project, you can find many of the functions mimic the API from numpy which is a popular package for scientific computation.

I hope you enjoy this package. Cheers.

DESC

s.homepage     = "https://github.com/dboyliao/NumSwift"

s.license      = 'MIT'


s.authors      = { "Dboy Liao" => "qmalliao@gmail.com" }


s.platform     = :ios
s.platform     = :ios, "8.0"

s.ios.deployment_target = "8.0"

#s.source = { :git => "git@github.com:dboyliao/NumSwift.git", :sha1 =>  '3d30d2a6afef3e1060bf0a825c4415ad0d453ab8'}
s.source       = { :git => "https://github.com/dboyliao/NumSwift.git", :tag => s.version }


s.source_files  = "NumSwift/Source/*.swift", "NumSwift/Source/Signal/*.swift"

s.frameworks = "Accelerate"


s.requires_arc = true

end
