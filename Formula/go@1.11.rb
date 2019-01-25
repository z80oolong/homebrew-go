class GoAT111 < Formula
  desc "Open source programming language to build simple/reliable/efficient software"
  homepage "https://golang.org"
  version "1.11.4"

  url "https://dl.google.com/go/go#{version}.src.tar.gz"
  mirror "https://fossies.org/linux/misc/go#{version}.src.tar.gz"
  sha256 "4cfd42720a6b1e79a8024895fa6607b69972e8e32446df76d6ce79801bbadb15"

  go_version = version.to_s.split(".")[0..1].join(".")

  resource "gonet" do
    url "https://go.googlesource.com/net.git",
        :branch => "release-branch.go#{go_version}"
  end

  resource "gotools" do
    url "https://go.googlesource.com/tools.git",
        :branch => "release-branch.go#{go_version}"
  end

  keg_only :versioned_formula

  depends_on "z80oolong/go/go-bootstrap@1.7"

  option "without-cgo", "Build without cgo (also disables race detector)"
  option "without-race", "Build without race detector"

  def install
    # Fixes: Error: Failure while executing: ../bin/ldd ../line-clang.elf: Permission denied
    unless OS.mac?
      chmod "+x", Dir.glob("src/debug/dwarf/testdata/*.elf")
      chmod "+x", Dir.glob("src/debug/elf/testdata/*-exec")
    end

    ENV["GOROOT_BOOTSTRAP"] = "#{Formula["z80oolong/go/go-bootstrap@1.7"].opt_libexec}/go-bootstrap"

    cd "src" do
      ENV["GOROOT_FINAL"] = libexec
      ENV["GOOS"]         = OS.mac? ? "darwin" : "linux"
      ENV["CGO_ENABLED"]  = "0" if build.without?("cgo")
      system "./make.bash", "--no-clean"
    end

    (buildpath/"pkg/obj").rmtree
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/go*"]

    # Race detector only supported on amd64 platforms.
    # https://golang.org/doc/articles/race_detector.html
    if build.with?("cgo") && build.with?("race") && MacOS.prefer_64_bit?
      system bin/"go", "install", "-race", "std"
    end

    # Build and install godoc
    ENV.prepend_path "PATH", bin
    ENV["GOPATH"] = buildpath

    (buildpath/"src/golang.org/x/net").install resource("gonet")
    (buildpath/"src/golang.org/x/tools").install resource("gotools")

    cd "src/golang.org/x/tools/cmd/godoc/" do
      system "go", "build"
      (libexec/"bin").install "godoc"
    end
    bin.install_symlink libexec/"bin/godoc"
  end

  def caveats; <<~EOS
    A valid GOPATH is required to use the `go get` command.
    If $GOPATH is not specified, $HOME/go will be used by default:
      https://golang.org/doc/code.html#GOPATH

    You may wish to add the GOROOT-based install location to your PATH:
      export PATH=$PATH:#{opt_libexec}/bin
  EOS
  end

  test do
    (testpath/"hello.go").write <<~EOS
      package main

      import "fmt"

      func main() {
          fmt.Println("Hello World")
      }
    EOS
    # Run go fmt check for no errors then run the program.
    # This is a a bare minimum of go working as it uses fmt, build, and run.
    system bin/"go", "fmt", "hello.go"
    assert_equal "Hello World\n", shell_output("#{bin}/go run hello.go")

    # godoc was installed
    assert_predicate libexec/"bin/godoc", :exist?
    assert_predicate libexec/"bin/godoc", :executable?

    if build.with? "cgo"
      ENV["GOOS"] = "freebsd"
      system bin/"go", "build", "hello.go"
    end
  end
end
