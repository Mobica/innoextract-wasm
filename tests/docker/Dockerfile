FROM dorowu/ubuntu-desktop-lxde-vnc

# Set environment variables.
ENV HOME /home
ENV EMSDK /home/emsdk
ENV EMSCRIPTEN_VERSION latest
ENV INNOEXTRACT /root/innoextract
ENV GECKODRIVER_VERSION v0.33.0

# Install all necessary dependencies
WORKDIR /home
RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4EB27DB2A3B88B8B
RUN add-apt-repository -y http://pl.archive.ubuntu.com/ubuntu/

RUN \
    apt install -y rclone \
    xdotool \
    git \
    python3-pip  \
    p7zip-full \
    vim

COPY requirements.txt /home/requirements.txt
RUN pip3 install -r requirements.txt

#Install fiirefox and gecko driver
RUN \
    sudo apt upgrade -y firefox && \
    wget https://github.com/mozilla/geckodriver/releases/download/${GECKODRIVER_VERSION}/geckodriver-${GECKODRIVER_VERSION}-linux-aarch64.tar.gz && \
    tar -xvzf geckodriver* && \
    chmod +x geckodriver && \
    export PATH=$PATH:/home/


RUN sudo apt install -y cmake

# Install Emscripten
RUN \
  git clone https://github.com/emscripten-core/emsdk.git && \
  cd ${EMSDK} && \
  ./emsdk install ${EMSCRIPTEN_VERSION} && \
  echo "## Done"

RUN  \
  cd ${EMSDK} && \
  echo "## Generate standard configuration" && \
  ./emsdk activate ${EMSCRIPTEN_VERSION} && \
  chmod 777 ${EMSDK}/upstream/emscripten && \
  chmod -R 777 ${EMSDK}/upstream/emscripten/cache && \
  echo "int main() { return 0; }" > hello.c && \
  ${EMSDK}/upstream/emscripten/emcc -c hello.c && \
  cat ${EMSDK}/upstream/emscripten/cache/sanity.txt && \
  echo "## Done"

# Cleanup Emscripten installation and strip some symbols
RUN \
  echo "## Aggressive optimization: Remove debug symbols" && \
  cd ${EMSDK} && . ./emsdk_env.sh && \
  # Remove debugging symbols from embedded node (extra 7MB&& )
  strip -s `which node` && \
  # Tests consume ~80MB disc spac&& e
  rm -fr ${EMSDK}/upstream/emscripten/tests && \
  # Fastcomp is not supporte&& d
  rm -fr ${EMSDK}/upstream/fastcomp && \
  # strip out symbols from clang (~extra 50MB disc space&& )
  find ${EMSDK}/upstream/bin -type f -exec strip -s {} + || true && \
  echo "## Done"

# Add Emscripten to PATH and set umask
ENV EMSDK=${EMSDK} \
  EMSDK_NODE=${EMSDK}/node/15.14.0_64bit/bin/node \
  PATH="${EMSDK}:${EMSDK}/upstream/emscripten:${EMSDK}/upstream/bin:${EMSDK}/node/15.14.0_64bit/bin:${PATH}"

# Create folder for artifacts
RUN mkdir /artifacts

# Install innoextract
RUN \
    git clone https://github.com/Mobica/innoextract-wasm.git && \
    cd innoextract-wasm && git checkout wasm-main && ./build.sh

# Switch to tests branch on github
RUN \
    cd innoextract-wasm && \
    git checkout tests && \
    git pull

# Copy scripts to docker container
COPY start_innoextract.sh /home/start_innoextract.sh
RUN chmod +x /home/start_innoextract.sh

COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT /run.sh