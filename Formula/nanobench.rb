class Nanobench < Formula
  desc "Simple, fast, accurate single-header microbenchmarking functionality for C++11/14/17/20"
  homepage "https://github.com/martinus/nanobench"
  url "https://raw.githubusercontent.com/martinus/nanobench/v4.3.11/src/include/nanobench.h"
  sha256 "7d20cc0daed3f56341ccd9b5c4b1b25b2f064d76638a5ba0304a5795a32cc1b6"
  license "MIT"

  def install
    (include/"nanobench").install "nanobench.h"
  end
end
