# encoding: UTF-8
#
#   Programación y diseño orientado a objetos
#   Grado en Ingeniería Informática
#
#   2013 © Copyleft - All Wrongs Reserved
#
#  Ernesto Serrano <erseco@correo.ugr.es>
#

require_relative 'card'

module Napakalaki
  
  class Cultist < Card
    
    #Atributos
    attr_reader :name, :gained_levels

    #Constructor
    def initialize(gained_levels)
      @name = "Sectario"
      @gained_levels = gained_levels

    end
    
    #Métodos
    def basic_value
        return @gained_levels;
    end

    def special_value
      return basic_value * CultistPlayer.total_cultist_players;
    end
    
    #Sobrecarga del método to_s (es similar al toString() de java
    def to_s
      return " Nombre: #{@name} Tipo: #{@type}"
    end

  end
  
end