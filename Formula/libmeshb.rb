class Libmeshb < Formula
  desc "A library to handle the *.meshb file format."
  homepage "https://github.com/LoicMarechal/libMeshb"
  url "https://github.com/LoicMarechal/libMeshb/archive/418213e.tar.gz"
  sha256 "f48c7e65169ab501bebef28f9af6a229f8ee269ed7b1303e1c9ed3330aaba0fd"
  license "MIT"
  version "7.80"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", "-DBUILD_SHARED_LIBS=ON", "-DCMAKE_BUILD_TYPE=Debug", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "true"
  end
end
