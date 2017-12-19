FROM izone/freecad:nvidia-xenial
MAINTAINER Leonardo Loures <luvres@hotmail.com>

## References:
# https://github.com/open-anatomy/SfM_gui_for_openMVG/blob/master/BUILD_UBUNTU_16_04.md

RUN \
  # Prepare and empty machine for building:
	apt-get update \
	&& apt-get install -y \
		git \
		mercurial \
		cmake \
		libpng-dev \
		libjpeg-dev \
		libtiff-dev \
		libglu1-mesa-dev \
		libboost-iostreams-dev \
		libboost-program-options-dev \
		libboost-system-dev \
		libboost-serialization-dev \
		libopencv-dev \
		libcgal-dev \
		libatlas-base-dev \
		libsuitesparse-dev \
		qt5-default \
		libxxf86vm1 \
		libxxf86vm-dev \
		libxi-dev \
		libxrandr-dev \
		graphviz \
		libcgal-qt5-dev \
  \
  # VCGLib (Required)
	&& cd \
	&& git clone https://github.com/cdcseacave/VCG.git vcglib \
  \
  # Eigen (Required)
	&& cd \
	&& hg clone https://bitbucket.org/eigen/eigen#3.2 \
	&& mkdir eigen_build \
	&& cd eigen_build \
	&& cmake . ../eigen \
	&& make -j$(nproc) \
	&& make install \
  \
  # Ceres (Required)
	&& cd \
	&& git clone https://ceres-solver.googlesource.com/ceres-solver ceres-solver \
	&& mkdir ceres_build \
	&& cd ceres_build/ \
	&& cmake . ../ceres-solver/ \
		-DMINIGLOG=ON \
		-DBUILD_TESTING=OFF \
		-DBUILD_EXAMPLES=OFF \
  \
	&& make -j$(nproc) \
	&& make install \
  \
  # CMVS / PMVS (Optional)
	&& cd \
	&& git clone https://github.com/open-anatomy/CMVS-PMVS.git \
	&& mkdir CMVS-PMVS_build \
	&& cd CMVS-PMVS_build \
	&& cmake ../CMVS-PMVS/program \
	&& make \
	&& make install \
  \
  # OpenMVS (Recommended)
	&& cd \
	&& git clone https://github.com/open-anatomy/openMVS.git openMVS \
	&& mkdir openMVS_build \
	&& cd openMVS_build \
	&& cmake . ../openMVS \
		-DCMAKE_BUILD_TYPE=Release \
		-DVCG_DIR="~/vcglib" \
	&& make -j$(nproc) \
	&& make install \
  \
  # OpenMVG + GUI (Required)
	&& cd \
	&& git clone --recursive https://github.com/open-anatomy/SfM_gui_for_openMVG.git openMVG \
	&& mkdir openMVG_build \
	&& cd openMVG_build \
	&& cmake . ../openMVG/src/ \
		-DCMAKE_BUILD_TYPE=RELEASE \
		-DCMAKE_INSTALL_PREFIX=$HOME/openMVG_build/openMVG_install \
		-DBUILD_SFM_GUI=ON \
		-DOPENMVG_PMVS_PATH=$HOME/CMVS-PMVS_build \
		-DBUILD_GUI_PREVIEW=OFF \
	&& make -j$(nproc) \
	&& make install


#ln -s /root/openMVG_build/openMVG_install/bin/openMVG_SfM_gui /usr/bin/openmvg



