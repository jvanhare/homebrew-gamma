class Libmeshb < Formula
  desc "A library to handle the *.meshb file format."
  homepage "https://github.com/LoicMarechal/libMeshb"
  url "https://github.com/LoicMarechal/libMeshb/archive/4fe30218ff8ca51e4525d6bcfa43c4197080b0f6.tar.gz"
  sha256 "ffd8ed4df4fa5e2e7c0528dbd5d8c41e8cd52e3cf67bcd3e07a2ec43fda8322d"
  license "MIT"
  version "8.03"

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
