class LPlib < Formula
  desc "A parallelization framework for numerical simulation."
  homepage "https://github.com/LoicMarechal/LPlib"
  url "https://github.com/LoicMarechal/LPlib/archive/a20c306.tar.gz"
  sha256 "ef91709e77515a5a953686dfcfba85e40cb929c25e7d2430bfe3301dc1ddebd2"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "libmeshb"

  def install
    system "cmake", "-S", ".", "-B", "build", "-DBUILD_SHARED_LIBS=ON", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "true"
  end
end
