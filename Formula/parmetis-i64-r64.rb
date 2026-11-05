class ParmetisI64R64 < Formula
  desc "MPI-based parallel graph partitioning library (64-bit idx_t and real_t)"
  homepage "http://glaros.dtc.umn.edu/gkhome/metis/parmetis/overview"
  url "http://glaros.dtc.umn.edu/gkhome/fetch/sw/parmetis/parmetis-4.0.3.tar.gz"
  mirror "https://ftp.mcs.anl.gov/pub/pdetools/spack-pkgs/parmetis-4.0.3.tar.gz"
  sha256 "f2d9a231b7cf97f1fee6e8c9663113ebf6c240d407d3c118c55b3633d6be6e5f"
  license :cannot_represent

  depends_on "cmake" => :build
  # parmetis.h includes metis.h, which ParMETIS does not install itself
  depends_on "metis-i64-r64"
  depends_on "open-mpi"

  def install
    # Build the bundled METIS with 64-bit integers (idx_t) and 64-bit reals (real_t)
    inreplace "metis/include/metis.h", "#define IDXTYPEWIDTH 32", "#define IDXTYPEWIDTH 64"
    inreplace "metis/include/metis.h", "#define REALTYPEWIDTH 32", "#define REALTYPEWIDTH 64"

    # ParMETIS 4.0.3 declares cmake_minimum_required(VERSION 2.8), rejected by CMake >= 4
    ENV["CMAKE_POLICY_VERSION_MINIMUM"] = "3.5"

    system "make", "config", "prefix=#{prefix}", "shared=1", "cc=mpicc", "cxx=mpicxx"
    system "make", "install"

    pkgshare.install "Graphs"
  end

  test do
    (testpath/"parmetis_test.c").write <<~C
      #include <stdio.h>
      #include <parmetis.h>
      int main(void) {
        printf("%d%d%zu", IDXTYPEWIDTH, REALTYPEWIDTH, sizeof(idx_t) * 8);
        return 0;
      }
    C
    system "mpicc", "parmetis_test.c", "-I#{include}", "-I#{formula_opt_include("metis-i64-r64")}",
                    "-L#{lib}", "-lparmetis", "-o", "parmetis_test"
    assert_equal "646464", shell_output("./parmetis_test")

    cp pkgshare/"Graphs/rotor.graph", testpath
    output = shell_output("mpirun -np 2 #{bin}/parmetis rotor.graph 1 2 1 1 6 1")
    assert_match "Final   2-way Cut", output
  end
end
