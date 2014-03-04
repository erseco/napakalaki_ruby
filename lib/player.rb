# encoding: UTF-8
#
#   Programación y diseño orientado a objetos
#   Grado en Ingeniería Informática
#
#   2013 © Copyleft - All Wrongs Reserved
#
#  Ernesto Serrano <erseco@correo.ugr.es>
#

require_relative 'treasure'
require_relative 'monster'
require_relative 'treasure_kind'
require_relative 'combat_result'
require_relative 'dice'

module Napakalaki
  
  require_relative 'napakalaki'
  
  class Player
    
    #Atributos
    attr_reader :dead, :name, :level, :visible_treasures, :hidden_treasures, :pending_badstuff  #Esto es como lo implementa ruby nativamente

    #Constructor
    def initialize(name)
      @name = name
      
      @dead = true
      
      @level = 1; #Inicializamos el nivel a 1
      @visible_treasures = Array.new
      @hidden_treasures = Array.new
      
    end
    
    def copy_constructor(player)      
      
      @level = player.level;
      @pending_badstuff = player.pending_badstuff;
      @dead = player.dead;
      @hidden_treasures = player.hidden_treasures;
      @visible_treasures = player.visible_treasures;

    end
    
    #Métodos
    def is_dead?
      return @dead
    end
    
    #Devuelve el nivel de combate del jugador, que viene dado por su nivel más 
    #los bonus que le proporcionan los tesoros que tenga equipados, según las 
    #reglas del juego.
    def combat_level

      lvl = @level
      #Primero comprobamos si tenemos el collar
      has_necklace = false
      @visible_treasures.each do |t|
    
        if t.type == NECKLACE then
          has_necklace = true
          break
        end
        
      end
      #Ahora recorremos los tesoros para obtener el bonus
      #NOTA: podria hacerse un solo if y dos for, en lugar de hacer el
      #if dentro del for, para optimizar
      @visible_treasures.each do |t|
        if has_necklace then
          lvl += t.max_bonus #Si tiene el necklace el maximo
        else 
          lvl += t.min_bonus #En caso contrario el minimo
        end
      end
      return lvl
    end
    
    #Devuelve la vida al jugador, modificando el atributo correspondiente.
    def bring_to_life
      @dead = false
    end
    
    #Incrementa el nivel del jugador en i niveles
    def increment_levels(l)
      @level += l
    end
    
    #Decrementa el nivel del jugador en i niveles
    def decrement_level(l)
      @level -= l
       
      #El nivel mínimo siempre será 1;
      if @level < 1 then
        @level = 1
      end

    end
    
    #Asigna el mal rollo al jugador, dándole valor a su atributo pendingBadStuff.
    def set_pending_bad_stuff(b)
      @pending_badstuff = b
    end
     
    def die!
      #ponemos el nivel a 1
      @level = 1 #1

      dealer = CardDealer.instance #2

      @visible_treasures.each do |t|

        dealer.give_treasure_back(t) #4

      end

      @visible_treasures.clear #5

      @hidden_treasures.each do |t|
          
        dealer.give_treasure_back(t) #7

      end

      @hidden_treasures.clear #8


      #Si no tiene tesoros muere
      die_if_no_treasures #9

    end
    
    #Si el jugador tiene equipado el tesoro tipo NECKLACE, se lo pasa al 
    #CardDealer y lo elimina de sus tesoros visibles
    def discard_necklace_if_visible
      
      @visible_treasures.each do |t| 
          
        if t.type == NECKLACE

          #Le pasamos el tesoro al CardDealer
          dealer = CardDealer.instance
          dealer.give_treasures_back(t)

          #Lo eliminamos de nuestros tesoros visibles (equipados)
          @visible_treasures.delete(t)

          #Salimos del bucle
          break
        end

      end
    end
    
    #Cambia el estado de jugador a muerto si no tiene ni tesoros visibles ni 
    #ocultos, modificandon el correspondiente atributo.
    def die_if_no_treasures
      if @visible_treasures.empty? && @hidden_treasures.empty?
        @dead = true
      end
    end
    
    def compute_gold_coins_value(treasures)
      levels = 0
      coins = 0

      #Obtenemos el total de monedas
      treasures.each do |t|
          
        coins += t.gold_coins

      end

      #Dividimos entre 1000 cogiendo la parte entera, para no devolver cambio
      levels = (coins / 1000).round

      #Devolvemos el valor
      return levels
    end
    
    #Devuelve true si con los niveles que compra no gana la partida y false en caso contrario.
    def can_i_buy_levels(l)
        
      can_i = false

      #Si el nivel del jugador mas los niveles a comprar es menor de 10
      if @level + l < 10 then

        can_i = true

      end

      return can_i
    end
    
    def apply_prize(current_monster)
      
      n_levels = current_monster.get_levels_gained

      increment_levels(n_levels)

      n_treasures = current_monster.get_treasures_gained

      if n_treasures > 0 then

        dealer = CardDealer.instance

        #Agregamos tantas cartas como hemos ganado
        n_treasures.times do 

          t = dealer.next_treasure
          @hidden_treasures << t

        end

      end
    end
    
    def combat(monster)

      my_level = combat_level #1.1.1

      monster_level = monster.combat_level #1.1.2
      
      if my_level > monster_level then

        apply_prize(monster)

        if @level >= 10 then
          result = WINANDWINGAME
        else
          result = WIN
        end

      else

        dice = Dice.instance
        escape = dice.next_number #1.1.4

        if escape < 5 then

          am_i_dead = monster.kills? #1.1.5

          if am_i_dead then

            die!

            result = LOSEANDDIE
            
          elsif should_convert then
                    
            result = LOSEANDCONVERT
                    
            
          else 

            bad = monster.bad_stuff

            result = LOSE

            apply_bad_stuff(bad)
          end

        else 

          result = LOSEANDESCAPE

        end
      end
            
      discard_necklace_if_visible

      return result
    end
    
    def apply_bad_stuff(bad)
      
      n_levels = @level #1

      decrement_level(n_levels) #2

      @pendingBadStuff = bad.adjust_to_fit_treasure_list(@visible_treasures, @hidden_treasures) #3

      set_pending_bad_stuff(@pendingBadStuff) #4

    end
    
    def make_treasure_visible(t)
      
      can_i = can_make_treasure_visible?(t) #1.2.1

      if can_i then
        @visible_treasures << t #1.2.2
        @hidden_treasures.delete(t) #1.2.3
      end
        
    end

    def can_make_treasure_visible?(t)

      result = false

      case t.type

      when ONEHAND #En el caso de los de una mano hay que comprar algunas cosas

        #Si está equipado con dos manos no puede agregar un tesoro de una mano
        if is_treasure_kind_in_use(BOTHHAND) then
          result = false
        else

          #Recorremos los tesoros visibles para ver si ya tiene alguno de una mano (0, 1 o 2)
          i = 0
          @visible_treasures.each do |tv|
            if tv.type == ONEHAND then
              i += 1
            end
                        
          end

          if i == 2 then
            #Si están las dos manos ocupadas no puede
            result = false
          else
            #En caso contrario si que puede
            result = true
          end
        end

      else  #El resto de casos, si esta en uso false, si no true
        result = !is_treasure_kind_in_use(t.type)

      end

      return result
    end
    
    #Este método lo he hecho personalmente para no duplicar codigo en el método anterior
    def is_treasure_kind_in_use(type) 

      result = false
      @visible_treasures.each do |tv|
        if type == tv.type then

          result = true
          break

        end

      end
      return result
        
    end
            
    def discard_visible_treasure(t)
      
      @visible_treasures.delete(t) #1.2.1

      if @pendingBadStuff != nil && !@pendingBadStuff.is_empty? then

        @pendingBadStuff.substract_visible_treasure(t) #1.2.2

      end

      die_if_no_treasures #1.2.3
        
    end
    
    def discard_hidden_treasure(t)
      
      @hidden_treasures.delete(t) #1.2.1

      if @pendingBadStuff != nil && !@pendingBadStuff.is_empty? then

        @pendingBadStuff.substract_hidden_treasure(t) #1.2.2

      end

      die_if_no_treasures #1.2.3
        
    end
    
    def buy_levels(visible, hidden)
      
      levels_may_bought = 0;
      levels_may_boughtlevels_may_bought += compute_gold_coins_values(visible) #1.1.1
      levels_may_boughtlevels_may_bought += compute_gold_coins_values(hidden) #1.1.2

      can_i = can_i_buy_levels(levels_may_bought) #1.1.3

      if can_i then
        increment_levels(levels_may_bought) #1.1.4

      end

      @visible_treasures.delete(visible) #1.1.5
      @hidden_treasures.delete(hidden) #1.1.6


      dealer = CardDealer.instance #1.1.7

      visible.each do |t|
        dealer.give_treasures_back(t) #1.1.9
      end

      hidden.each do |t|
        dealer.give_treasures_back(t) #1.1.11
      end

      return can_i
    end
    
    #Devuelve true cuando el jugador no tiene que cumplir con ningún mal rollo 
    #que cumplir (pendingBadStuff.isEmpty() == true) y no tiene más de 4 tesoros 
    #ocultos y false en caso contrario.
    def valid_state
    
      return @pending_badStuff != nil && @hidden_treasures.lenght <= 4
    
    end
    
    def init_treasures

      dealer = CardDealer.instance #1

      dice = Dice.instance #2

      bring_to_life #3

      #Por defecto robamos 1
      treasure = dealer.next_treasure #4
      @hidden_treasures <<  treasure #5

      number = dice.next_number #6

      #NOTA: Le he dado la vuelta, porque segun el esquema siempre entaría en > 1
      if number == 6 then

        # == 6 roba 3 (1+2)
        treasure = dealer.next_treasure #9
        @hidden_treasures <<  treasure #10

        #NOTA: Aunque no está en el diagrama, se supone que en el GuionP3.pdf
        #Dice que en el caso de == 6 se roban 3 tesoros asi que hay
        #que robar uno mas
        treasure = dealer.next_treasure #9
        @hidden_treasures <<  treasure #10

      elsif number > 1 then

        # > 1 roba 2 (1+1)
        treasure = dealer.next_treasure #7
        @hidden_treasures <<  treasure #8

      end
    end
    
    #Devuelve true cuando el jugador tiene algún tesoro visible y false en caso contrario.
    def has_visible_treasures?
      
      return !@visible_treasures.empty?
    end
    
  
    #Devuelve el número de tesoros visibles que tiene del tipo tKind.
    def how_many_visible_treasures(t_kind)

      i = 0
      @visible_treasures.each do |t|

        if t.type == t_kind then
              
          #Incrementamos el numero (ruby no soporta i++)
          i = i + 1

        end

      end
        
      return i
        
    end
    
    def should_convert
      
      dice = Dice.instance
      n = dice.next_number
      shold_c = false
        
      #Si el dado da 6 debe convertirse
      if n == 6 then
        shold_c = true
        
      end
   
      return shold_c
    end
    
    def oponent_level(monster) 

      return monster.basic_value

    end

    
    #Sobrecarga del método to_s (es similar al toString() de java
    def to_s
      " Nombre: #{@name} Nivel: #{combat_level}"
    end

    #EXAMEN
    def receive_present(treasure)
      
        #Agregamos el tesoro
        @hidden_treasures << treasure
        
        #Damos las gracias
        @name + " dice: Muchas Gracias!!"

    end
    #FIN EXAMEN
    
    
  end
  
end
