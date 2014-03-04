# encoding: UTF-8
# 
#   Programación y diseño orientado a objetos
#   Grado en Ingeniería Informática
#
#   2013 © Copyleft - All Wrongs Reserved
# 
#   Ernesto Serrano <erseco@correo.ugr.es>
#

require_relative 'napakalaki'

module Napakalaki 
  
  #Definimos un array con jugadores
  players = Array.new
  players << 'Ernesto'
  players << 'Noureddine'
  players << 'Juan'
  
  #Obtenemos el singleton del juego
  np = Napakalaki.instance
  #Inicializamos el juego
  np.init_game(players)
  
  #Inicializamos la variable result
  result = LOSE

  begin
    #Obtenemos el current player
    pl = np.get_current_player
    
    opcion = 0;

    begin

      puts "Menu por consola"
      puts "1.- Equipar 2 tesoros"
      puts "2.- Descartar 2 tesoros visibles"
      puts "3.- Luchar"
      puts "4.- Mostrar Tesoros Visibles"
      puts "5.- Mostrar Tesoros Ocultos"
      print "Comando: "
      opcion = gets.chomp.to_i
      puts ""

      case opcion
      when 1
        puts "-----------------"
        puts "Equipando tesoros..."

        #Hacemos visible el primer tesoro (si tiene ocultos)
        if !pl.hidden_treasures.empty? then

          # puts pl.hidden_treasures.at(0)
          pl.make_treasure_visible(pl.hidden_treasures.at(0))
          
          #Hacemos visible el segundo tesoro (si tiene ocultos)
          if !pl.hidden_treasures.empty? then

            # puts pl.hidden_treasures.at(0)
            pl.make_treasure_visible(pl.hidden_treasures.at(0))
          end

        end

      when 2
        puts "Descartar tesoros..."

        #Descartamos el 1er tesoro visible (si tiene...)
        #Hacemos visible el primer tesoro (si tiene ocultos)
        if !pl.visible_treasures.empty? then

          # puts pl.hidden_treasures.at(0)
          pl.discard_visible_treasure(pl.visible_treasures.at(0))
          
          #Hacemos visible el segundo tesoro (si tiene ocultos)
          if !pl.visible_treasures.empty? then

            # puts pl.hidden_treasures.at(0)
            pl.discard_visible_treasure(pl.visible_treasures.at(0))
          end
          
        end
                       
      when 3
        puts "-----------------"
        puts "Luchamos..."

        #Luchamos  
        result = np.develop_combat

        #Pintamos el resultado en la pantalla 
        puts "\t Jugador " + np.current_player.to_s
        puts "\t Monstruo " + np.current_monster.to_s
        puts "\t Result: " + result.to_s

        #Siguiente turno
        np.next_turn
        
      when 4
        puts "-----------------"
        puts "Tesoros visibles: " + pl.visible_treasures.size.to_s
        pl.visible_treasures.each do |t|
          puts "\t - " + t.to_s
        end
        puts ""
      when 5
        puts "-----------------"
        puts "Tesoros ocultos: " + pl.hidden_treasures.size.to_s
        pl.hidden_treasures.each do |t|
          puts "\t - " + t.to_s
        end
        puts ""

      else
        puts "-----------------"
        puts "Opcion incorrecta\n"

      end

    end while opcion < 1 || opcion > 5

  end while result != WINANDWINGAME #Mientras no gane el juego (nivel 10)

end

