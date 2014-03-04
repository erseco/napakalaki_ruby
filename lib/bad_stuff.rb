# encoding: UTF-8
# 
#   Programación y diseño orientado a objetos
#   Grado en Ingeniería Informática
#
#   2013 © Copyleft - All Wrongs Reserved
# 
#   Ernesto Serrano <erseco@correo.ugr.es>
#

require_relative 'treasure_kind'

module Napakalaki

  
  class BadStuff
    
    #Atributos
    attr_reader :text, :levels, :nVisibleTreasures, :nHiddenTreasures, :death, :specificVisibleTreasures, :specificHiddenTreasures
    
    #Constructor        
    def initialize(text, some_level= 0, some_visible_treasures = 0, some_hidden_treasures = 0, some_specific_visible_treasures= Array.new, some_specific_hidden_treasures= Array.new, death = false)
      @text = text
      @levels = some_level
      @nVisibleTreasures = some_visible_treasures
      @nHiddenTreasures = some_hidden_treasures
      @specificVisibleTreasures = some_specific_visible_treasures
      @specificHiddenTreasures = some_specific_hidden_treasures
      @death = death
    end
    
    #Métodos (estos métodos sobrecargan el constructor, ya que en ruby solo se puede definir un constructor
    def self.new_level_number_of_treasures (aText, someLevels, someVisibleTreasures, someHiddenTreasures)
      new(aText, someLevels, someVisibleTreasures, someHiddenTreasures)
    end
    
    def self.new_level_specific_treasures (aText, someLevels, someSpecificVisibleTreasures, someSpecificHiddenTreasures)
      new(aText,someLevels,0, 0, someSpecificVisibleTreasures, someSpecificHiddenTreasures)
    end
    
    def self.new_death (aText)
      new(aText, 0, 0, 0, Array.new, Array.new, true)
    end
    
    
    #Devuelve true cuando el mal rollo que tiene que cumplir el jugador está 
    #vacío, eso significa que el conjunto de atributos del mal rollo indican 
    #que no hay mal rollo que cumplir, plánteate qué valores deberán tener.
    def is_empty?
      
        empty = false
      
        if @levels == 0 && @death == false && @nHiddenTreasures == 0 && @nVisibleTreasures == 0  && @specificHiddenTreasures.empty? && @specificVisibleTreasures.empty? then
        
            empty = true
        end
        
        return empty
    end
    
    def kills!
      
    end

    
    def substract_visible_treasure(treasure) 
        #No tengo muy claro que sea esto lo que hay que hacer
        @specificVisibleTreasures.delete(treasure.type);
    end
    
    def substract_hidden_treasure(treasure)
        #No tengo muy claro que sea esto lo que hay que hacer
        @specificHiddenTreasures.delete(treasure.type);      
    end
    
    def adjust_to_fit_treasure_list(v, h)
      
        t_visible = Array.new
        t_hidden = Array.new
        
        #Recorremos los tesoros
        v.each do |t|
            #Si no contiene el TreasureKind lo agregamos
            if t_visible.index(t.type) == nil then
                t_visible << t.type
            end
        end
        
        #Recorremos los tesoros
        h.each do |t|
            #Si no contiene el TreasureKind lo agregamos
            if t_hidden.index(t.type) == nil then
                t_hidden << t.type
            end
        end

         bs = BadStuff.new_level_specific_treasures(@text, 0, t_visible, t_hidden)

        return bs
        
    end
    
    #Devuelve true si es un mal rollo es muerte, false en caso contrario.
    def my_badstuff_is_death
        
      return @death
        
    end
    

    #Sobrecarga del método to_s (es similar al toString() de java
    def to_s
      " Mal rollo: #{@text} \n Pierdes: #{@levels} niveles."
    end
    

  end
  
end