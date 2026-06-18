class Libmeshb < Formula
  desc "A library to handle the *.meshb file format."
  homepage "https://github.com/LoicMarechal/libMeshb"
  url "https://github.com/LoicMarechal/libMeshb/archive/3c1f8b9a3484e28ebb74c2f6144e367415541527.tar.gz"
  sha256 "4df46c8c0c8af333f2676615b339e856ce9bc4cd771f6eb9298657001ed6739b"
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
