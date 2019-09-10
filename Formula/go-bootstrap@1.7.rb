class GoBootstrapAT17 < Formula
  desc "Golang bootstrap compiler for Golang compiler."
  homepage "https://golang.org"
  version "1.7"

  if Hardware::CPU.is_32_bit? then
    case Hardware::CPU.arch_32_bit
    when :arm
      url "https://storage.googleapis.com/golang/go1.7.linux-armv6l.tar.gz"
      sha256 "4192592728e2f9fac8ae43abedb4b98d811836c3965035e7cb8c603aa5e65be4"
    when :intel
      url "https://storage.googleapis.com/golang/go1.7.linux-386.tar.gz"
      sha256 "1207477aa3471222f0555825f9d6ac2a39abc75839f2dfd357f19f5077f710f2"
    end
  else
    if OS.mac?
      url "https://storage.googleapis.com/golang/go1.7.darwin-amd64.tar.gz"                                                                       
      sha256 "51d905e0b43b3d0ed41aaf23e19001ab4bc3f96c3ca134b48f7892485fc52961"                                                                   
    elsif OS.linux?
      url "https://storage.googleapis.com/golang/go1.7.linux-amd64.tar.gz"                                                                        
      sha256 "702ad90f705365227e902b42d91dd1a40e48ca7f67a2f4b2fd052aaa4295cd95"                                                                   
    end
  end

  keg_only :versioned_formula

  def install
    Pathname.glob(buildpath/"*") {|path| (libexec/"go-bootstrap").install path}
  end

  def caveats
    "Please note that go #{version} installed by this formula is a go compiler for bootstrap which is used to build a new go compiler."
  end
end
