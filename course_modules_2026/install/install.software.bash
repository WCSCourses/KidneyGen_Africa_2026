#mkdir -p ../bin/ && mkdir -p admixture && cd admixture &&wget -c https://dalexander.github.io/admixture/binaries/admixture_linux-1.3.0.tar.gz && tar -xzf admixture_linux-1.3.0.tar.gz && mv dist/admixture_linux-1.3.0/admixture ../../bin/ && cd ../ && rm -rf admixture 
apt-get install -f git wget unzip r r-utils tar 
mkdir -p plink/ && cd plink && wget -c https://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20250819.zip && unzip plink_linux_x86_64_20250819.zip  && mv plink ../../bin/ && cd ../ && rm -rf plink
mkdir -p plink2/ && cd plink2 && wget -c https://s3.amazonaws.com/plink2-assets/alpha6/plink2_linux_avx2_20251026.zip && unzip plink2_linux_avx2_20251026.zip  && mv plink2 ../../bin/ && cd ../ && rm -rf plink2
mkdir -p admixture && cd admixture && wget -c https://dalexander.github.io/admixture/binaries/admixture_linux-1.3.0.tar.gz && tar -xzf admixture_linux-1.3.0.tar.gz && mv dist/admixture_linux-1.3.0/admixture ../../bin/ && cd ../ && rm -rf admixture

