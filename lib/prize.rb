# encoding: UTF-8
#
#   Programación y diseño orientado a objetos
#   Grado en Ingeniería Informática
#
#   2013 © Copyleft - All Wrongs Reserved
#
#  Ernesto Serrano <erseco@correo.ugr.es>
#

module Napakalaki
  
  class Prize
    
    #Atributos
    attr_reader :level, :treasures    #Esto es como lo implementa ruby nativamente

    #Constructor
    def initialize(treasures,level)
      @treasures = treasures
      @level = level
    end
    
    #Sobrecarga del método to_s (es similar al toString() de java
    def to_s
      " Earned Treasures: #{@treasures} \n Earned Levels: #{@level}"
    end

  end
  
end