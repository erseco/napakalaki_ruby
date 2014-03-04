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
  
  class Treasure < Card
    
    #Atributos
    attr_reader :name, :gold_coins, :min_bonus, :max_bonus, :type    #Esto es como lo implementa ruby nativamente

    #Constructor
    def initialize(n, g, min, max, t)
      @name = n
      @gold_coins = g
      @min_bonus = min
      @max_bonus = max
      @type = t

    end
    
    #Métodos
    def basic_value
      return min_bonus
    end
    
    def special_value
      return max_bonus
    end
    
    #Sobrecarga del método to_s (es similar al toString() de java
    def to_s
      return " Nombre: #{@name} Tipo: #{@type}"
    end

  end
  
end