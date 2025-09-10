class Tetgen < Formula
    desc "Quality Tetrahedral Mesh Generator and 3D Delaunay Triangulator"
    homepage "https://wias-berlin.de/software/tetgen"
    url "https://wias-berlin.de/software/tetgen/1.5/src/tetgen1.6.0.tar.gz"
    sha256 "0fff0l6i3xfjlm0zkcgyyhwndp8i5d615mydyb21yirsplgfddc7"
    license "AGPL-3.0-only"

    def install
        system ENV.cc, "-O0", "-fPIC", "-c", "predicates.cxx"
        system ENV.cc, "-O3", "-fPIC", "-o", "tetgen", "tetgen.cxx", "predicates.o", "-lm"
        system ENV.cc, "-O3", "-fPIC", "-DTETLIBRARY", "-c", "tetgen.cxx"
        system ENV.ld, "r", "libtet.a", "tetgen.o", "predicates.o"
    end
end