# encoding: UTF-8
# 
#   Programación y diseño orientado a objetos
#   Grado en Ingeniería Informática
#
#   2013 © Copyleft - All Wrongs Reserved
# 
#   Ernesto Serrano <erseco@correo.ugr.es>
#
require_relative 'prize'
require_relative 'bad_stuff'
require_relative 'card'

module Napakalaki
 
  class Monster < Card
    
    #Atributos
    attr_reader :name, :combat_level, :prize, :bad_stuff, :level_change_against_cultist_player
    
    #Constructor
    def initialize(name, level, badstuff, prize, level_change_against_cultist_player = 0)
        @name = name
        @combat_level = level
        @prize = prize
        @bad_stuff = badstuff
        @level_change_against_cultist_player = level_change_against_cultist_player
    end
    
    def get_levels_gained
        @prize.level
    end
    
    def get_treasures_gained
        @prize.treasures
    end
    
    #Devuelve true cuando el mal rollo del monstruo es muerte y false en caso contrario.
    def kills?
        return @bad_stuff.my_badstuff_is_death
    end
    
    
    def basic_value
      return get_levels_gained
    end
    
    def special_value
      return get_levels_gained + @level_change_against_cultist_player
    end
    
    #Sobrecarga del método to_s (es similar al toString() de java
    def to_s
       " Nombre: #{@name} Nivel de combate: #{@combat_level.to_s}"
    end
    
    
  end
  
end
