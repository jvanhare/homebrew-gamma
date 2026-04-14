class Nanobench < Formula
  desc "Simple, fast, accurate single-header microbenchmarking functionality for C++11/14/17/20"
  homepage "https://github.com/martinus/nanobench"
  url "https://raw.githubusercontent.com/martinus/nanobench/v4.3.11/src/include/nanobench.h"
  sha256 "PUT_THE_CORRECT_SHA256_HERE"
  license "MIT"

  def install
    include.install "src/include/nanobench/nanobench.h"
  end
end
