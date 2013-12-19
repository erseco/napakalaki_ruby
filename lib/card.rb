# encoding: UTF-8
#
#   © Copyleft - All Wrongs Reserved
# 
#  Ernesto Serrano <erseco@correo.ugr.es>
#  Noureddine El Alaoui <nourdine@correo.ugr.es>
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