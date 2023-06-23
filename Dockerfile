FROM arm64v8/ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV ELECTRON_ENABLE_WAYLAND 1

# Update and install required packages
RUN apt-get update && apt-get install -y \
  bash \
  libgtk-3-0 \
  curl \
  libnotify4 \
  xdg-utils \
  libnss3 \
  libnspr4 \
  libasound2 \
  libdbus-1-3 \
  libgbm1 \
  libatk1.0-0 \
  libatk-bridge2.0-0 \
  libc6 \
  libcairo2 \
  libexpat1 \
  libgcc1 \
  libgconf-2-4 \
  libstdc++6 \
  dbus \
  libgl1-mesa-dri \
  libgl1-mesa-glx \
  libegl1-mesa \
  libgles2-mesa \
  tzdata && \
  # Set the timezone to Los Angeles
  ln -fs /usr/share/zoneinfo/America/Los_Angeles /etc/localtime && \
  dpkg-reconfigure --frontend noninteractive tzdata && \
  # Cleanup
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*


# Download the package using curl
# RUN curl -s https://dial-app.meticuloushome.com/spin/meticulous-ui_1.1.0~alpha.7_arm64.deb -o meticulous-ui_1.1.0~alpha.7_arm64.deb
# RUN curl -s https://dial-app.meticuloushome.com/dev/test.tar.gz -o meticulous-ui_1.1.0~alpha.7_arm64.deb 
COPY ./meticulous-ui_1.1.0~alpha.10_arm64.deb meticulous-ui_1.1.0~alpha.7_arm64.deb
# Install the package
RUN apt-get update && \
    apt-get install -y --no-install-recommends ./meticulous-ui_1.1.0~alpha.7_arm64.deb&& \
    # Cleanup
    rm meticulous-ui_1.1.0~alpha.7_arm64.deb && \
    apt-get clean

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["meticulous-ui --no-sandbox --enable-features=UseOzonePlatform --ozone-platform=wayland"]
