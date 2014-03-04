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
  require "singleton"
  
  class Dice
    #Hacemos que la clase use el patrón Singleton (unica instancia)
    include Singleton
    
    #Métodos
    
    #Genera un número aleatorio entre 1 y 6
    def next_number
     
      #Devolvemos random --random(6) va de 0 a 5
      return 1 + rand(6)
      
    end

  end
  
end