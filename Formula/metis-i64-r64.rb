class MetisI64R64 < Formula
  desc "Programs that partition graphs and order matrices (64-bit idx_t and real_t)"
  homepage "http://glaros.dtc.umn.edu/gkhome/views/metis"
  url "http://glaros.dtc.umn.edu/gkhome/fetch/sw/metis/metis-5.1.0.tar.gz"
  mirror "https://ftp.mcs.anl.gov/pub/pdetools/spack-pkgs/metis-5.1.0.tar.gz"
  sha256 "76faebe03f6c963127dbb73c13eab58c9a3faeae48779f049066a21c087c5db2"
  license "Apache-2.0"

  depends_on "cmake" => :build

  conflicts_with "metis", because: "both install metis.h and libmetis"

  def install
    # Build with 64-bit integers (idx_t) and 64-bit reals (real_t)
    inreplace "include/metis.h", "#define IDXTYPEWIDTH 32", "#define IDXTYPEWIDTH 64"
    inreplace "include/metis.h", "#define REALTYPEWIDTH 32", "#define REALTYPEWIDTH 64"

    # METIS 5.1.0 declares cmake_minimum_required(VERSION 2.8), rejected by CMake >= 4
    ENV["CMAKE_POLICY_VERSION_MINIMUM"] = "3.5"

    system "make", "config", "prefix=#{prefix}", "shared=1"
    system "make", "install"

    pkgshare.install "graphs"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <metis.h>
      int main(void) {
        printf("%d%d%zu", IDXTYPEWIDTH, REALTYPEWIDTH, sizeof(idx_t) * 8);
        return 0;
      }
    C
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lmetis", "-o", "test"
    assert_equal "646464", shell_output("./test")

    cp pkgshare/"graphs/4elt.graph", testpath
    system bin/"graphchk", "4elt.graph"
    system bin/"gpmetis", "4elt.graph", "2"
    system bin/"ndmetis", "4elt.graph"
  end
end
