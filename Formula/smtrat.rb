class Smtrat < Formula
  desc "SMT Real Arithmetic Toolbox"
  homepage "https://github.com/smtrat/smtrat"
  url "https://github.com/smtrat/smtrat/archive/v2.2.zip"
  version "v2.2"
  sha256 "738a7cfe82556ef3d7c27f37d4199339f64d54f95d169fd12e8c1b73dd467c8d"

  head "https://github.com/smtrat/smtrat.git", :using => :git

  option "with-thread-safe", "Build with thread-safe support"

  depends_on :macos => :mavericks
  depends_on "cmake"
  depends_on "boost"
  depends_on "gmp"
  depends_on "eigen"
  depends_on "smtrat/smtrat/carl"

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
