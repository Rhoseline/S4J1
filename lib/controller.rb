#require 'bundler'
#Bundler.require


# $:.unshift File.expand_path("./../lib", __FILE__)

require 'csv'
require 'gossip'

class ApplicationController < Sinatra::Base

	# ///// PARTIE GET /////

	# On met en place l'index en définissant sa route
	get '/' do
		erb :index, locals: {gossips: Gossip.all}
	end

	# Même chose pour new gossip
	get '/gossips/new/' do
		erb :new_gossip
	end

	# Permet d'obtenir de récupérer l'info de l'URL dynamique,
	# et de l'affichage dans la page show gossip correspondante.
	get '/gossip/:id' do
		erb :show_gossip
	end

	# Page d'edition des posts
	get '/gossip/:id/edit/' do
		erb :edit
	end

	# ///// PARTIE POST /////

	# On prépare le post de la page new_gossip pour gérer l'envoi du formulaire
	post '/gossips/new/' do
		Gossip.new(params["gossip_author"], params["gossip_content"]).save
		redirect '/'
	end

	# Permet d'afficher dans la console les paramètres entrés sur le formulaire
	# de nouveau gossip.
	post '/gossips/new/' do
		puts "Hash params : #{params}"
		puts "gossip_author : #{params["gossip_author"]}"
		puts "gossip_content :#{params["gossip_content"]}"
	end

	# Permet d'editer les posts
	post '/gossip/:id/edit/' do
		Gossip.update(params["id"], params["gossip_new_author"], params["gossip_new_content"])

		# On affiche un retour dans la console
		puts "Edited Hash params : #{params}"
		puts "Edited gossip_new_author : #{params["gossip_new_author"]}"
		puts "Edited gossip_new_content :#{params["gossip_new_content"]}"
		puts "ID :#{params["id"]}"

		redirect '/'
	end
 #run! if app_file == $0
end

