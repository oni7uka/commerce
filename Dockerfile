FROM ruby:2.4.1
MAINTAINER onizuka1229@gamil.com

# == Debian Mirror on Aliyun for China network
RUN \
    echo "deb http://mirrors.aliyun.com/debian jessie main contrib non-free" > /etc/apt/sources.list && \
    echo "deb-src http://mirrors.aliyun.com/debian jessie main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/debian jessie-updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.aliyun.com/debian jessie-updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/debian-security jessie/updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.aliyun.com/debian-security jessie/updates main contrib non-free" >> /etc/apt/sources.list && \
    apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /commerce
WORKDIR /commerce
ADD Gemfile /commerce/Gemfile
ADD Gemfile.lock /commerce/Gemfile.lock
RUN gem sources --add http://gems.ruby-china.org/ --remove https://rubygems.org/ && gem update rake
RUN bundle install

EXPOSE 3000

ADD . /commerce
