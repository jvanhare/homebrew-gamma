class Tetgen < Formula
    desc "Quality Tetrahedral Mesh Generator and 3D Delaunay Triangulator"
    homepage "https://wias-berlin.de/software/tetgen"
    url "https://wias-berlin.de/software/tetgen/1.5/src/tetgen1.6.0.tar.gz"
    sha256 "87b5e61ebd3a471fc4f2cdd7124c2b11dd6639f4feb1f941a5d2f5110d05ce39"
    license "AGPL-3.0-only"

    def install
        system ENV.cxx, "-O0", "-fPIC", "-c", "predicates.cxx"
        system ENV.cxx, "-O3", "-fPIC", "-o", "tetgen", "tetgen.cxx", "predicates.o", "-lm"
        system ENV.cxx, "-O3", "-fPIC", "-DTETLIBRARY", "-c", "tetgen.cxx"

        if OS.mac?
            system "libtool", "-static", "-o", "libtet.a", "tetgen.o", "predicates.o"
        else
            system "ar", "rcs", "libtet.a", "tetgen.o", "predicates.o"
        end

        bin.install "tetgen"
        include.install "tetgen.h"
        lib.install "libtet.a"
    end
end