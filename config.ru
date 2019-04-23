require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__) # afin de dire dire à notre fichier config.ru de prendre en compte tous les fichiers dans le dossier lib

require './controller'

run ApplicationController #on demande simplement au serveur d'exécuter le contenu de la classe ApplicationController