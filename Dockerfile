FROM debian:stretch
MAINTAINER Caesar Wang "wxt@rock-chips.com"

# setup multiarch enviroment
RUN dpkg --add-architecture armhf
RUN echo "deb-src http://deb.debian.org/debian stretch main" >> /etc/apt/sources.list
RUN echo "deb-src http://deb.debian.org/debian stretch-updates main" >> /etc/apt/sources.list
RUN echo "deb-src http://security.debian.org stretch/updates main" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y crossbuild-essential-armhf

ADD ./overlay/  /

# perpare build dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y sudo locales git fakeroot devscripts cmake vim qemu-user-static:armhf binfmt-support \
        dh-make dh-exec pkg-kde-tools device-tree-compiler:armhf bc cpio parted dosfstools mtools libssl-dev:armhf \
        g++-arm-linux-gnueabihf dpkg-dev meson debhelper pkgconf apt-utils

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get build-dep -y -a armhf libdrm
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get build-dep -y -a armhf xorg-server

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y gstreamer1.0-plugins-bad:armhf gstreamer1.0-plugins-base:armhf gstreamer1.0-tools:armhf \
        gstreamer1.0-alsa:armhf gstreamer1.0-plugins-base-apps:armhf qtmultimedia5-examples:armhf

#Openbox
RUN DEBIAN_FRONTEND=noninteractive apt-get install -f -y debhelper:armhf gettext:armhf libstartup-notification0-dev:armhf libxrender-dev:armhf libglib2.0-dev:armhf libxml2-dev:armhf perl libxt-dev:armhf libxinerama-dev:armhf libxrandr-dev:armhf libpango1.0-dev:armhf libx11-dev:armhf  autoconf:armhf automake:armhf libimlib2-dev:armhf libxcursor-dev:armhf autopoint:armhf librsvg2-dev:armhf libxi-dev:armhf

# rga
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libdrm-dev:armhf

## opencv
#
#RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y libopencv-ts-dev:armhf libopencv-video-dev:armhf libopencv-videostab-dev:armhf
#RUN apt-get download libopencv-dev:armhf
#RUN dpkg -x libopencv*.deb /

# gst-plugins-base
# TODO: Bug: /home/rk/packages/gst-plugins-base1.0-1.14.4/docs/libs/gst-plugins-base-libs-scan: line 117: /home/rk/packages/gst-plugins-base1.0-1.14.4/docs/libs/.libs/gst-plugins-base-libs-scan: Too many levels of symbolic links
#RUN apt-get install -y gnome-pkg-tools libgstreamer1.0-dev:armhf libasound2-dev:armhf libgudev-1.0-dev libwayland-dev:armhf libgbm-dev:armhf #wayland-protocols autotools-dev:armhf automake autoconf libtool dh-autoreconf autopoint cdbs gtk-doc-tools libxv-dev libxt-dev libvorbis-#dev:armhf libcdparanoia-dev:armhf liborc-0.4-dev:armhf libpango1.0-dev:armhf libglib2.0-dev:armhf zlib1g-dev:armhf libvisual-0.4-dev:armhf #iso-codes libgtk-3-dev:armhf libglib2.0-doc gstreamer1.0-doc libgirepository1.0-dev:armhf gobject-introspection gir1.2-glib-2.0 gir1.2-#freedesktop gir1.2-gstreamer-1.0 zlib1g-dev:armhf libopus-dev:armhf libgl1-mesa-dev:armhf libegl1-mesa-dev:armhf libgles2-mesa-dev:armhf #libgraphene-1.0-dev:armhf libpng-dev:armhf libjpeg-dev:armhf

# gstreamer-rockchip
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y autotools-dev:armhf libx11-dev:armhf libdrm-dev:armhf libgstreamer1.0-dev:armhf \
#        libgstreamer-plugins-base1.0-dev:armhf

# libmali
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libstdc++6:armhf libgbm-dev:armhf libdrm-dev:armhf libx11-xcb1:armhf libxcb-dri2-0:armhf libxdamage1:armhf \
#        libxext6:armhf libwayland-client0:armhf

#drm-cursor
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libgbm-dev:armhf libegl1-mesa-dev:armhf libgles2-mesa-dev:armhf

# xserver
# xf86-video-armsoc
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y xserver-xorg-dev:armhf libaudit-dev:armhf xtrans-dev:armhf xfonts-utils:armhf x11proto-dri2-dev:armhf libxdmcp-dev:armhf libxau-dev:armhf libxdmcp-dev:armhf libxfont-dev:armhf libxkbfile-dev:armhf libpixman-1-dev:armhf libpciaccess-dev:armhf libgcrypt-dev:armhf nettle-dev:armhf libudev-dev:armhf libselinux1-dev:armhf libaudit-dev:armhf libgl1-mesa-dev:armhf libunwind-dev:armhf libxmuu-dev:armhf libxext-dev:armhf libx11-dev:armhf libxrender-dev:armhf libxi-dev:armhf libdmx-dev:armhf libxpm-dev:armhf libxaw7-dev:armhf libxt-dev:armhf libxmu-dev:armhf libxtst-dev:armhf libxres-dev:armhf libxfixes-dev:armhf libxv-dev:armhf libxinerama-dev:armhf libxshmfence-dev:armhf libepoxy-dev:armhf libegl1-mesa-dev:armhf libgbm-dev:armhf

RUN cp /usr/lib/pkgconfig/* /usr/lib/arm-linux-gnueabihf/pkgconfig/
RUN apt-get update && apt-get install -y libxtst-dev:armhf

# FFmpeg

#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y doxygen cleancss node-less ladspa-sdk
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y frei0r-plugins-dev:armhf flite1-dev:armhf libzmq3-dev:armhf libass-dev:armhf libbluray-dev:armhf libbs2b-dev:armhf libbz2-dev:armhf libcaca-dev:armhf libxvmc-dev:armhf libcdio-paranoia-dev:armhf libchromaprint-dev:armhf libdc1394-22-dev:armhf libdrm-dev:armhf libfontconfig1-dev:armhf libfreetype6-dev:armhf libfribidi-dev:armhf libgme-dev:armhf libgsm1-dev:armhf libiec61883-dev:armhf libxvidcore-dev:armhf libavc1394-dev:armhf libjack-jackd2-dev:armhf libleptonica-dev:armhf liblzma-dev:armhf libmp3lame-dev:armhf libxcb-xfixes0-dev:armhf libopenal-dev:armhf libopencore-amrnb-dev:armhf libzvbi-dev:armhf libxcb-shm0-dev:armhf libopencore-amrwb-dev:armhf libopencv-imgproc-dev:armhf libopenjp2-7-dev:armhf libopenmpt-dev:armhf libxml2-dev:armhf libopus-dev:armhf libpulse-dev:armhf librubberband-dev:armhf librsvg2-dev:armhf libsctp-dev:armhf libxcb-shape0-dev:armhf libshine-dev:armhf libsnappy-dev:armhf libsoxr-dev:armhf libspeex-dev:armhf libssh-gcrypt-dev:armhf libtesseract-dev:armhf libtheora-dev:armhf libtwolame-dev:armhf libva-dev:armhf libvdpau-dev:armhf libx265-dev:armhf libvo-amrwbenc-dev:armhf libvorbis-dev:armhf libvpx-dev:armhf libwavpack-dev:armhf libwebp-dev:armhf libx264-dev:armhf libgnutls28-dev:armhf libaom-dev:armhf liblilv-dev:armhf libcodec2-dev:armhf libmysofa-dev:armhf libvidstab-dev:armhf libsdl2-dev:armhf liblensfun-dev:armhf libgcrypt-dev:armhf liblept5:armhf libcrystalhd-dev

#RUN apt-get install -y libomxil-bellagio-dev
#RUN rm /var/lib/dpkg/info/libomxil-bellagio*

#RUN rm /usr/include/cdio/version.h

# Mpv
#RUN apt-get update && apt-get install -y libasound2-dev:armhf libass-dev:armhf libavcodec-dev:armhf libavdevice-dev:armhf \
#libavfilter-dev:armhf libavformat-dev:armhf libavresample-dev:armhf libavutil-dev:armhf libbluray-dev:armhf libcaca-dev:armhf \
#libcdio-paranoia-dev:armhf libdvdnav-dev:armhf libdvdread-dev:armhf libegl1-mesa-dev:armhf libgbm-dev:armhf \
#libgl1-mesa-dev:armhf libjack-dev:armhf libjpeg-dev:armhf liblcms2-dev:armhf liblua5.2-dev:armhf libpulse-dev:armhf \
#librubberband-dev:armhf libsdl2-dev:armhf libsmbclient-dev:armhf libsndio-dev:armhf libswscale-dev:armhf \
#libuchardet-dev:armhf libva-dev:armhf libvdpau-dev:armhf libwayland-dev:armhf libx11-dev:armhf libxinerama-dev:armhf \
#libxkbcommon-dev:armhf libxrandr-dev:armhf libxss-dev:armhf libxv-dev:armhf python3 python3-docutils wayland-protocols

# glmark2
#RUN apt-get install -y debhelper-compat libjpeg-dev:armhf libpng-dev:armhf libudev-dev:armhf  libxcb1-dev:armhf python3 wayland-protocols libwayland-dev libwayland-bin

## yocto
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y gawk wget git-core diffstat unzip texinfo chrpath socat xterm locales

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

RUN echo "Update Headers!"
#RUN dpkg -i /packages/armhf/rga/*.deb
#RUN dpkg -i /packages/armhf/mpp/*.deb
#RUN dpkg -i /packages/armhf/gst-rkmpp/*.deb
#RUN dpkg -i /packages/armhf/ffmpeg/*.deb
#RUN dpkg -i /packages/armhf/libmali/libmali-midgard-t86x-r18p0-x11*.deb
#RUN find /packages/armhf/libdrm -name '*.deb' | sudo xargs -I{} dpkg -x {} /

RUN apt-get update && apt-get install -y -f

ENV LANG en_US.UTF-8
ENV ARCH arm
ENV CROSS_COMPILE arm-linux-gnueabihf-
ENV CC "${CROSS_COMPILE}gcc"
ENV CXX "${CROSS_COMPILE}g++"
ENV AR "${CROSS_COMPILE}ar"
ENV RANLIB "${CROSS_COMPILE}ranlib"


# switch to a no-root user
RUN useradd -c 'rk user' -m -d /home/rk -s /bin/bash rk
RUN sed -i -e '/\%sudo/ c \%sudo ALL=(ALL) NOPASSWD: ALL' /etc/sudoers
RUN usermod -a -G sudo rk

USER rk
