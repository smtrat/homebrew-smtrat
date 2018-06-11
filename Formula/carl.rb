class Carl < Formula
  desc "Computer ARithmetic and Logic library"
  homepage "https://github.com/smtrat/carl"
  url "https://github.com/smtrat/carl/archive/18.06.zip"
  version "18.06"
  sha256 "3b67e9350bacfdc1da7a786efe3cec479d26ff16f3b20c4f7e260ddef13ae08a"

  head "https://github.com/smtrat/carl.git", :using => :git

  option "with-thread-safe", "Build with thread-safe support"

  depends_on :macos => :mavericks
  depends_on "cmake"
  depends_on "boost"
  depends_on "gmp"
  depends_on "eigen"
  depends_on "cln" => :optional
  depends_on "ginac" => :optional
  depends_on "smtrat/smtrat/cocoalib" => :optional

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
