require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)
require './controller.rb'

Controller.new
