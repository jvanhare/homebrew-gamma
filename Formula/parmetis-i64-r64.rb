class ParmetisI64R64 < Formula
  desc "ParMETIS 4.0.3"
  homepage "https://github.com/jvanhare/parmetis"
  url "https://github.com/jvanhare/parmetis/archive/refs/tags/v4.0.3.tar.gz"
  sha256 "706d79ecd782bda75b1edda5f9a1de89ce5d92e32c6d234e3c30c9f0359da401"
  license "Apache-2.0"

  depends_on "cmake" => :build
  depends_on "open-mpi"

  def install
    system "cmake", "-S", ".", "-B", "build", "-DMETIS_I64=ON", "-DMETIS_R64=ON", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"parmetis_test.cc").write <<~CPP
      #include <iostream>
      #include "metis.h"
      int main() { std::cout << IDXTYPEWIDTH << REALTYPEWIDTH << std::endl; }
    CPP
    system ENV.cxx, "parmetis_test.cc", "-I#{include}", "-std=c++11", "-o", "parmetis_test"
    assert_match "6464", shell_output("./parmetis_test")
  end
end
