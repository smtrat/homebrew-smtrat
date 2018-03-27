class Carl < Formula
  desc "Computer ARithmetic and Logic library"
  homepage "https://github.com/smtrat/carl"
  url "https://github.com/smtrat/carl/archive/17.12.zip"
  version "17.12"
  sha256 "4a1394fd21b143a1b4b0620f54b92131c885b6dd0db485687426f14d7af9e492"

  head "https://github.com/smtrat/carl.git", :using => :git

  option "with-thread-safe", "Build with thread-safe support"

  depends_on :macos => :mavericks
  depends_on "cmake"
  depends_on "boost"
  depends_on "gmp"
  depends_on "eigen"
  depends_on "cln" => :optional
  depends_on "ginac" => :optional
  depends_on "moves-rwth/misc/cocoalib" => :optional

  def install
    args = %w[
      -DEXPORT_TO_CMAKE=OFF
      -DCMAKE_BUILD_TYPE=RELEASE
    ]
    args << "-DTHREAD_SAFE=ON" if build.with?("thread-safe")
    args << "-DUSE_CLN_NUMBERS=ON" if build.with?("cln")
    args << "-DUSE_GINAC=ON" if build.with?("ginac")
    args << "-DUSE_COCOA=ON" if build.with?("cocoalib")

    mktemp do
      system "cmake", buildpath, *(std_cmake_args + args)
      system "make", "install"
    end
  end
end
