# encoding: UTF-8
#
#   Programación y diseño orientado a objetos
#   Grado en Ingeniería Informática
#
#   2013 © Copyleft - All Wrongs Reserved
#
#  Ernesto Serrano <erseco@correo.ugr.es>
#

require_relative "card_dealer"
require_relative "player"
require_relative "cultist_player"

module Napakalaki
  
  require "singleton"
  
  class Napakalaki
    #Hacemos que la clase use el patrón Singleton (unica instancia)
    include Singleton
    
    #Atributos
    attr_accessor :current_player, :players, :dealer, :current_monster
    
    #Métodos
    
    #Inicializa el array de jugadores que contiene Napakalaki, creando tantos 
    #jugadores como elementos haya en names, que es el array de String que 
    #contiene el nombre de los jugadores.
    def init_players(names)
      
      @dealer = CardDealer.instance
      
      #Inicializamos el array de jugadores
      @players = Array.new
        
      #Recorremos los nombres pasados y creamos tantos jugadores como nombres
      names.each do |s|

        players << Player.new(s)

      end
      
    end
    
  
  
    # Decide qué jugador es el siguiente en jugar. Se pueden dar dos posibilidades 
    # para calcular el índice que ocupa dicho jugador en la lista de jugadores:
    # 
    # 1) Que sea el primero en jugar, en este caso hay que generar un número alea-
    # torio entre 0 y el numero de jugadores menos 1, este número indicará el índi-
    # ce que ocupa en la lista de jugadores el jugador que comenzará la partida.
    # 
    # 2) Que no sea el primero en jugar, en este caso el índice es el del jugador 
    # que se encuentra en la siguiente posición al jugador actual. Hay que tener en
    # cuenta que si el jugador actual está en la última posición, el siguiente será
    # el que está en la primera posición.
    #
    # Una vez calculado el índice, el jugador que ocupa esa posición se almacenará 
    # en el atributo current_player de la clase Napakalaki.
    
    def next_player

        #Obtenemos el numero total de jugadores
        total_players = @players.length #se puede usar size, que es un alias de length

        #Si no está definido el jugador actual es porque es la primera vez
        if (@current_player == nil) then
            
            #Obtenemos un numero aleatorio con tope el índice maximo del 
            #numero de jugadores
            next_index = rand(total_players)
            
        else

            #Obtenemos el índice del jugador actual
            current_player_index = @players.index(@current_player)

            if current_player_index == total_players then
                #Si es el último seleccionamos el primero
                next_index = 0

            else
                #En caso contrario seleccionamos el siguiente
                next_index = current_player_index + 1
            end

        end

        #Obtenemos el jugador correspondiente al índice aleatorio
        next_player = @players.at(next_index)
        
        #Establecemos el siguiente jugador
        @current_player = next_player

        return @current_player
    end

    def develop_combat
      
        combat = @current_player.combat(@current_monster)
        
        #Comprobamos si el resultado es LoseAndConvert
        if combat == LOSEANDCONVERT then

            #Obtenemos una carta de cultista
            cl = @dealer.next_cultist

            #Creamos un nuevo cultista
            cl_player = CultistPlayer.new(@current_player, cl);

            #Sustituimos el cultista
            @players.delete(@current_player)
            @players << cl_player
        
            @current_player = cl_player
            
        end
      

        @dealer.give_monster_back(@current_monster)

        return combat

    end
    
    def discard_visible_treasures(treasures)
      
        treasures.each do |t|
          
            @current_player.discard_visible_treasure(t) #1.2
            @dealer.give_treasuresBack(t) #1.3

        end

    end
    
    def discard_hidden_treasures(treasures)
      
        treasures.each do |t|

            @current_player.discardHidden_treasure(t) #1.2
            @dealer.give_treasuresBack(t) #1.3

        end
    end
    
    def make_treasures_visible(treasures)
      
        treasures.each do |t| #1.1

            @current_player.make_treasure_visible(t) #1.2

        end
        
    end
    
    def buy_level(visible, hidden)
        return @current_player.buy_levels(visible, hidden)

    end
    
    def init_game(names)
      
        init_players(names) #1.1

        dealer.init_cards #1.2

        next_turn #1.3
    end
    
    #Devuelve el jugador actual (current_player)
    def get_current_player
      return @current_player
    end
    
    #Devuelve el monstruo en juego (current_monster)
    def get_current_monster
      return @current_monster
    end
    
    #Esta función igual no es necesaria
    def can_make_treasure_visible(t)
      return @current_player.can_make_treasure_visible?(t)
    end
    
    def next_turn

        state_ok = next_turn_allowed #1.1

        if state_ok then

            @current_monster = @dealer.next_monster #1.2

            @current_player = next_player #1.3

            dead = @current_player.is_dead? #1.4

            if dead then
              
                @current_player.init_treasures #1.5

            end
            
        else
          
          #NOTA: Agregado por mi, ya que si no, al no permitir cambiar de turno, el monstruo no cambia
          @current_monster =  @dealer.next_monster

        end

        return state_ok #1.6


    end

    # Método que comprueba si el jugador activo (current_player) cumple con las 
    # reglas del juego para poder terminar su turno. Devuelve false si el juga-
    # dor activo no puede pasar de turno y true en caso contrario, para ello 
    # usa el método de _player: validState()
    def next_turn_allowed
        
        if @current_player == nil then
            allowed = true #La primera vez current_player está sin asignar
        else
            allowed = @current_player.valid_state #1.1.1
        end

        return allowed

    end
  
    #Devuelve true si result tiene el valor WinAndWinGame del enumerado 
    #CombatResult, en caso contrario devuelve false.
    def end_of_game(result)
      return result == WINANDWINGAME
    end

    #EXAMEN
    def make_present(treasure)
       
        #Recorremos los jugadores
        @players.each do |pl|
        
            #Nos saltamso el current player
            if pl.name != @current_player.name then
            
                #Si no tiene nada, lo asignamos
                if player_receiver == nil then
                
                    player_receiver = pl;
                
                 #Si tiene menor nivel que el asignado previamente, lo asignamos
                 elsif pl.level < player_receiver.level then
               
                    player_receiver = pl;                
            
                end
            
            end
            
        end
        
        #Comprobamos que hayamos conseguido un player
        if player_receiver == nil then
        
            #Le damos el regalo
           puts player_receiver.receive_present(treasure);
        
        end
        
    end
    #FIN EXAMEN
    
    
    
  end
  
end