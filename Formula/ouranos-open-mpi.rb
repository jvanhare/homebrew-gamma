class OuranosOpenMpi < Formula
    desc "OpenMPI Message Passing Library - 4.1.6"
    homepage "https://www.open-mpi.org/"
    url "https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.6.tar.gz"
    sha256 "44da277b8cdc234e71c62473305a09d63f4dcca292ca40335aab7c4bf0e6a566"
  
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
    depends_on "hwloc"
    depends_on "libevent"
  
    def install
      system "./configure", "--enable-mpi-fortran=no", *std_configure_args
      system "make", "all"
      system "make", "check"
      system "make", "install"
    end
  
    test do
      (testpath/"hello.c").write <<~EOS
        #include <mpi.h>
        #include <stdio.h>
  
        int main()
        {
          int size, rank, nameLen;
          char name[MPI_MAX_PROCESSOR_NAME];
          MPI_Init(NULL, NULL);
          MPI_Comm_size(MPI_COMM_WORLD, &size);
          MPI_Comm_rank(MPI_COMM_WORLD, &rank);
          MPI_Get_processor_name(name, &nameLen);
          printf("[%d/%d] Hello, world! My name is %s.\\n", rank, size, name);
          MPI_Finalize();
          return 0;
        }
      EOS
      system bin/"mpicc", "hello.c", "-o", "hello"
      system "./hello"
      system bin/"mpirun", "./hello"
    end
  end