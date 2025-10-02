class Libmeshb < Formula
  desc "A library to handle the *.meshb file format."
  homepage "https://github.com/LoicMarechal/libMeshb"
  url "https://github.com/LoicMarechal/libMeshb/archive/952a157.tar.gz"
  sha256 "db9d3091ecb7fb3478c26f0ca51535cb9f0bbac4beed7f2c9fdb539880f4a957"
  license "MIT"
  version "7.80"

  patch :DATA

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_BUILD_TYPE=Release", "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "true"
  end
end


__END__
diff --git a/sources/CMakeLists.txt b/sources/CMakeLists.txt
--- a/sources/CMakeLists.txt
+++ b/sources/CMakeLists.txt
@@
-if(CMAKE_Fortran_COMPILER)
-  install(DIRECTORY ${CMAKE_Fortran_MODULE_DIRECTORY}/ DESTINATION include)
-endif()
+if(CMAKE_Fortran_COMPILER)
+  if(EXISTS ${CMAKE_Fortran_MODULE_DIRECTORY})
+    install(DIRECTORY ${CMAKE_Fortran_MODULE_DIRECTORY}/
+            DESTINATION include
+            FILES_MATCHING PATTERN "*.mod")
+  endif()
+endif()
