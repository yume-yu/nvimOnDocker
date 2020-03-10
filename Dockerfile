FROM alpine:3.11.3

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    curl \
    npm \
    gcc \
    git \
    linux-headers \
    musl-dev\
    neovim \
    python-dev \
    py-pip \
    python3-dev \
    ruby-dev \
    make \
    py3-pip && \
    rm -rf /var/cache/apk/*

ENV LANG="ja_JP.UTF-8" LANGUAGE="ja_JP:ja" LC_ALL="ja_JP.UTF-8"

COPY .config /root/.config

RUN pip3 install --upgrade pip neovim python-language-server && \
    pip2 install --upgrade pip neovim && \
    npm install -g yarn && \
    gem install neovim && \
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/installer.sh && \
    sh ~/installer.sh ~/.cache/dein && \
    yarn global add neovim


RUN nvim; exit 0

WORKDIR /usr/src/nvim

ENTRYPOINT ["nvim"]
