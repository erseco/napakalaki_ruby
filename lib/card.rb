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
  
  class Card

  def basic_value
    raise NotImplementedError.new
  end

  def special_value
    raise NotImplementedError.new
  end

  end
end