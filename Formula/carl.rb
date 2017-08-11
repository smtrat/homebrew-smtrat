class Carl < Formula
  desc "A Computer ARithmetic and Logic library."
  homepage "https://github.com/smtrat/carl"
  url "https://github.com/smtrat/carl/archive/17.08.zip"
  version "17.08"
  sha256 "736a47c91718ea92e1ede84bc47446654ab9a4aa205a70e2c3162406b7f6487b"

  head "https://github.com/smtrat/carl.git", :using => :git

  option "with-thread-safe", "Make CArL thread-safe."
  option "with-cocoalib", "Build CArL with support for CoCoALib."
  option "with-cln", "Build CArL with support for cln."
  option "with-ginac", "Build CArL with support for GiNaC."

  depends_on :macos => :mavericks
  depends_on "cmake"
  depends_on "boost" => ["c++11"]
  depends_on "gmp" => ["c++11"]
  depends_on "cln" if build.with?("cln")
  depends_on "ginac" if build.with?("ginac")
  depends_on "moves-rwth/misc/cocoalib" if build.with?("ginac")

  def install
    args = %w[
      -DEXPORT_TO_CMAKE=OFF
      -DCMAKE_BUILD_TYPE=RELEASE
    ]
    args << "-DTHREAD_SAFE=ON" if build.with?("thread-safe")
    args << "-DUSE_CLN_NUMBERS=ON" if build.with?("cln")
    args << "-DUSE_GINAC=ON" if build.with?("ginac")
    args << "-DUSE_COCOA=ON" if build.with?("cocoa")

    mktemp do
      system "cmake", buildpath, *(std_cmake_args + args)
      system "make", "lib_carl"
    end
  end
end
