# encoding: UTF-8
# 
# Ernesto Serrano <erseco@correo.ugr.es>
#
#  2014 © Copyleft - All Wrongs Reserved
#

module Napakalaki 
  
  @@names = Array.new
  
  require 'player_names_capture'
  
  
  alert @@names
  
  #Definimos un array con jugadores
  players = Array.new
  players << 'Ernesto'
  players << 'Noureddine'
  players << 'Juan'

  require '../napakalaki'
  
  #Obtenemos el singleton del juego
  np = Napakalaki.instance
  #Inicializamos el juego
  np.init_game(players)
  
  #Inicializamos la variable result
  result = LOSE

    #Obtenemos el current player
    pl = np.get_current_player
    

end

