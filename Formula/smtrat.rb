class Smtrat < Formula
  desc "SMT Real Arithmetic Toolbox"
  homepage "https://github.com/smtrat/smtrat"
  url "https://github.com/smtrat/smtrat/archive/v2.1.zip"
  version "v2.1"
  sha256 "5b65cd2d8f81e22ee13c8f875bf1fafa0b84d8478a8cae7592cb6b628618c963"

  head "https://github.com/smtrat/smtrat.git", :using => :git

  option "with-thread-safe", "Build with thread-safe support"

  depends_on :macos => :mavericks
  depends_on "cmake"
  depends_on "boost"
  depends_on "gmp"
  depends_on "eigen"
  depends_on "smtrat/smtrat/carl" => :optional

  def install
    args = %w[
      -DCMAKE_BUILD_TYPE=RELEASE
    ]
    args << "-DTHREAD_SAFE=ON" if build.with?("thread-safe")
    args << "-DUSE_GINAC=ON" if build.with?("ginac")
    args << "-DUSE_COCOA=ON" if build.with?("cocoalib")

    mktemp do
      system "cmake", buildpath, *(std_cmake_args + args)
      system "make", "install"
    end
  end
end
