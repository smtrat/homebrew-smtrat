class Cocoa < Formula
  desc "CoCoALib is a GPL C++ library for doing Computations in Commutative Algebra."
  homepage "http://cocoa.dima.unige.it/cocoalib/"
  url "http://cocoa.dima.unige.it/cocoalib/tgz/CoCoALib-0.99555.tgz"
  version "0.99555"
  sha256 "0a7d96789885027c7fcb875f281aadb613ab5e7ff6e1f233abbf2c499136c517"

  depends_on :macos => :mavericks
  depends_on "gmp" => ["c++11"]

  def install
    system "mkdir", "#{prefix}/include"
    system "mkdir", "#{prefix}/bin"
    system "mkdir", "#{prefix}/lib"

    system "./configure", "--threadsafe-hack", "--with-cxxflags=-Wno-deprecated-declarations -fPIC", "--prefix=#{prefix}"
    system "make"
    system "make", "install"

    system "mv", "#{prefix}/include/CoCoA-#{version}", "#{prefix}/include/CoCoA"
  end
end
