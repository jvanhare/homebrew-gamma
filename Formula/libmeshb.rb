class Libmeshb < Formula
  desc "A library to handle the *.meshb file format."
  homepage "https://github.com/LoicMarechal/libMeshb"
  url "https://github.com/LoicMarechal/libMeshb/archive/906a83e61a2b150b85c7436acb151879fd63cfe2.tar.gz"
  sha256 "6febf8c2518bd5844ca539531a64004cd17befa716665bcfe7c2ddc77f070702"
  license "MIT"
  version "8.00"

  depends_on "cmake" => :build
  depends_on "gfortran" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", "-DBUILD_SHARED_LIBS=ON", "-DWITH_GMF_AIO=ON", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "true"
  end
end
