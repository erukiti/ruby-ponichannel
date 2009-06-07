#! /usr/bin/env ruby

load "ponichannel/ponichannel.rb"
require 'ponichannel_webrick'

PoniChannel.webrick(:Port => 80, :AccessLog => [[File.new("data/log/access.log","a"), WEBrick::AccessLog::COMBINED_LOG_FORMAT]])

