require 'csv'
require 'pry'

class Gossip

	attr_accessor :author, :content

	def initialize(author, content)
		@author = author
		@content = content
	end

	# Permet de stocker tous les gossips du CSV dans un array
	def self.all
		all_gossips = []

		CSV.read("./db/gossip.csv").each do |csv_line|
			all_gossips << Gossip.new(csv_line[0], csv_line[1])
		end

		return all_gossips
	end

	# Permet d'enregistrer un nouveau Gossip dans le CSV
	def save
		CSV.open("./db/gossip.csv", "ab") do |csv|
			csv << [@author, @content]
		end
	end

	# Permet de de stocker le contenu du CSV dans un array
	# d'arrays appelé db_content.
	def self.find(id)
		db_content = CSV.read("./db/gossip.csv")
		db_content[id]
	end

	# Méthode pour mettre à jour les gossips
	def self.update(id, author, content)
		# On va chercher le fichier CSV correspondant et
		# on stock son contenu dans une variable sous forme
		# d'array, contenant un array par ligne.
		csv_file = CSV.read("./db/gossip.csv")

		# On parcourt le tableau, each_index renvoie 
		# l'index de chaque ligne du CSV (qui sont des arrays)
		csv_file.each_index do |index| 
    	# Si l'index correspond au nombre qu'on demande,
    	# On modifie le tableau (csv_file[index])
    	# Attention, bien prendre en compte que c'est un array
    	# et que l'index commence à 0.
    	if index == id.to_i # On récupère l'id pour obtenir l'index, ne pas oublier to_i !
    		# Modifier l'auteur
    		csv_file[index][0] = author
    		# Modifier le contenu
    		csv_file[index][1] = content
    	end
		end

		# On ouvre le fichier CSV et on remplace son contenu
		# par le nouveau
		CSV.open('./db/gossip.csv', 'wb') do |csv| 
			# On reprend chaque row de la version modifiée
			# précédemment, et on la met dans le fichier csv
			csv_file.each do |row|
				csv << row
			end
		end
	end

end

   
