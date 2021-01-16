Pod::Spec.new do |spec|

  spec.name         = "Nafuda"
  spec.version      = "1.0.1"
  spec.summary      = "This search web site's title"
  spec.description  = "TODO: write here"
  spec.homepage     = "https://github.com/p1atdev/Nafuda"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author             = { "p1atdev" => "shu_teiei@outlook.jp" }
  spec.source       = { :git => "https://github.com/p1atdev/Nafuda.git", :tag => "#{spec.version}" }
  spec.platform     = :ios, "9.0"
  spec.requires_arc = true
  spec.source_files = 'Nafuda/*.{swift}'
  # s.resources    = 'Kusabi/**/*.{xib,png}'
  spec.swift_version = "5.0"
end
