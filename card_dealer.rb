# encoding: UTF-8
#
#   Programación y diseño orientado a objetos
#   Grado en Ingeniería Informática
#
#   2013 © Copyleft - All Wrongs Reserved
#
#  Ernesto Serrano <erseco@correo.ugr.es>
#

require_relative 'cultist'

module Napakalaki
 
  require "singleton"
  
  class CardDealer
    #Hacemos que la clase use el patrón Singleton (unica instancia)
    include Singleton
    
    #Atributos
    attr_accessor :used_monsters, :unused_monsters, :used_treasures, :unused_treasures, :unused_cultists
    
    
    #Métodos
    def init_treasure_card_deck
      
      #Definimos un array donde almacenar los tesoros
      @unused_treasures = Array.new
      @used_treasures = Array.new #inicializamos los dos array


      #Creamos los tesoros
      
      #El constructor de Treasure pide: nombre, gold, min, max y type
      
      @unused_treasures << Treasure.new("¡Śı mi amo!", 0, 4, 7, HELMET)
      @unused_treasures << Treasure.new("Botas de investigación", 600, 3, 4, SHOE)
      @unused_treasures << Treasure.new("Capucha de Cthulhu", 500, 3, 5, HELMET)
      @unused_treasures << Treasure.new("A prueba de babas", 400, 2, 5, ARMOR)
      @unused_treasures << Treasure.new("Botas de lluvia ácida", 800, 1, 1, BOTHHAND)
      @unused_treasures << Treasure.new("Casco minero", 400, 2, 4, HELMET)
      @unused_treasures << Treasure.new("Ametralladora Thompson", 600, 4, 8, BOTHHAND)
      @unused_treasures << Treasure.new("Camiseta de la UGR", 100, 1, 7, ARMOR)
      @unused_treasures << Treasure.new("Clavo de rail ferroviario", 400, 3, 6, ONEHAND)
      @unused_treasures << Treasure.new("Cuchillo de sushi arcano", 300, 2, 3, ONEHAND)
      @unused_treasures << Treasure.new("Fez alópodo", 700, 3, 5, HELMET)
      @unused_treasures << Treasure.new("Hacha prehistórica", 500, 2, 5, ONEHAND)
      @unused_treasures << Treasure.new("El aparato del Pr. Tesla", 900, 4, 8, ARMOR)
      @unused_treasures << Treasure.new("Gaita", 500, 4, 5, BOTHHAND)
      @unused_treasures << Treasure.new("Insecticida", 300, 2, 3, ONEHAND)
      @unused_treasures << Treasure.new("Escopeta de 3 cañones", 700, 4, 6, BOTHHAND)
      @unused_treasures << Treasure.new("Garabato Mistico", 300, 2, 2, ONEHAND)
      @unused_treasures << Treasure.new("La fuerza de Mr. T", 1000, 0, 0, NECKLACE)
      @unused_treasures << Treasure.new("La rebeca metálica", 400, 2, 3, ARMOR)
      @unused_treasures << Treasure.new("Mazo de los antiguos", 200, 3, 4, ONEHAND)
      @unused_treasures << Treasure.new("Necro-playboycon", 300, 3, 5, ONEHAND)
      @unused_treasures << Treasure.new("Lanzallamas", 800, 4, 8, BOTHHAND)
      @unused_treasures << Treasure.new("Necro-comicón", 100, 1, 1, ONEHAND)
      @unused_treasures << Treasure.new("Necronomicón", 800, 5, 7, BOTHHAND)
      @unused_treasures << Treasure.new("Linterna a 2 manos", 400, 3, 6, BOTHHAND)
      @unused_treasures << Treasure.new("Necro-gnomicón", 200, 2, 4, ONEHAND)
      @unused_treasures << Treasure.new("Necrotelecom", 300, 2, 3, HELMET)
      @unused_treasures << Treasure.new("Porra preternatural", 200, 2, 3, ONEHAND)
      @unused_treasures << Treasure.new("Tentácula de pega", 200, 0, 1, HELMET)
      @unused_treasures << Treasure.new("Zapato deja-amigos", 500, 0, 1, SHOE)
      @unused_treasures << Treasure.new("Shogulador", 600, 1, 1, BOTHHAND)
      @unused_treasures << Treasure.new("Varita de atizamiento", 400, 3, 4, ONEHAND)
      
    end
    
    def init_monster_card_deck
      
      
      #Definimos un array donde almacenar los monstruos
      @unused_monsters = Array.new
      @used_monsters = Array.new #inicializamos los dos array

      #Creamos los monstruos

      #Monstruo de prueba
      bad_stuff = BadStuff.new_death("Desapareces, feneces, te caes al mar y te comen los peces")
      prize = Prize.new(1, 2)
      @unused_monsters<< Monster.new("El Chapulín Colorado", 8, bad_stuff, prize)

      #Monstruo 1
      tvp = [ARMOR]
      top = [ARMOR]
      bad_stuff = BadStuff.new_level_specific_treasures("Pierdes tu armadura visible y otra oculta", 0, tvp, top)
      prize = Prize.new(2, 1)
      @unused_monsters<< Monster.new("3 Byakhees de bonanza", 8, bad_stuff, prize)

      #Monstruo 2
      tvp = [HELMET]
      top = []
      bad_stuff = BadStuff.new_level_specific_treasures("Embobados con el lindo primigenio te descartas de tu casco visible", 0, tvp, top)
      prize = Prize.new(1, 1)
      @unused_monsters<< Monster.new("Chibithulhu", 2, bad_stuff, prize)

      #Monstruo 3
      tvp = [SHOE]
      top = []
      bad_stuff = BadStuff.new_level_specific_treasures("El primordial bostezo contagioso. Pierdes el calzado visible", 0, tvp, top)
      prize = Prize.new(1, 1)
      @unused_monsters<< Monster.new("El sopor de Dunwich", 2, bad_stuff, prize)

      #Monstruo 4
      tvp = [ONEHAND]
      top = [ONEHAND]
      bad_stuff = BadStuff.new_level_specific_treasures("Te atrapan para llevarte de fiesta y te dejan caer en mitad del vuelo. Descarta 1 mano visible y 1 mano oculta", 0, tvp, top)
      prize = Prize.new(4, 1)
      @unused_monsters<< Monster.new("Ángeles de la noche ibicenca", 14, bad_stuff, prize)


      #Monstruo 5
      tvp = [SHOE,ONEHAND,NECKLACE,HELMET,BOTHHAND,ARMOR]
      top = []
      bad_stuff = BadStuff.new_level_specific_treasures("Pierdes todos tus tesoros visibles", 0, tvp, top)
      prize = Prize.new(3, 1)
      @unused_monsters<< Monster.new("El gorrón en el umbral", 10, bad_stuff, prize)

      #Monstruo 6
      tvp = [ARMOR]
      top = []
      bad_stuff = BadStuff.new_level_specific_treasures("Pierdes la armadura visible", 0, tvp, top)
      prize = Prize.new(2, 1)
      @unused_monsters<< Monster.new("H.P. Munchcraft", 6, bad_stuff, prize)

      #Monstruo 7
      tvp = [ARMOR]
      top = []
      bad_stuff = BadStuff.new_level_number_of_treasures("Sientes bichos bajo la ropa. Descarta la armadura visible", 0, tvp, top)
      prize = Prize.new(1, 1)
      @unused_monsters<< Monster.new("Bichgooth", 2, bad_stuff, prize)

      #Monstruo 8
      bad_stuff = BadStuff.new_level_number_of_treasures("Pierdes 5 niveles", 5, 0, 0)
      prize = Prize.new(4, 2)
      @unused_monsters<< Monster.new("El rey de rosa", 13, bad_stuff, prize)

      #Monstruo 9
      bad_stuff = BadStuff.new_level_number_of_treasures("Toses los pulmones y pierdes 2 niveles", 2,0,0)
      prize = Prize.new(1, 1)
      @unused_monsters<< Monster.new("La que redacta en las tinieblas", 2, bad_stuff, prize)

      #Monstruo 10
      bad_stuff = BadStuff.new_death("Estos monstruos resultan bastante superciales y te aburren mortalmente. Estas muerto")
      prize = Prize.new(2, 1);
      @unused_monsters<< Monster.new("Los hondos", 8, bad_stuff, prize)

      #Monstruo 11
      bad_stuff = BadStuff.new_level_number_of_treasures("Pierdes 2 niveles y 2 tesoros ocultos.", 2, 0, 2)
      prize = Prize.new(2, 1)
      @unused_monsters<< Monster.new("Semillas Cthulhu", 4, bad_stuff, prize)

      #Monstruo 12
      tvp = [ONEHAND]
      top = []
      bad_stuff = BadStuff.new_level_specific_treasures("Te intentas escaquear. Pierdes una mano visible.", 0, tvp, top)
      prize = Prize.new(2, 1)
      @unused_monsters<< Monster.new("Dameargo", 1, bad_stuff, prize)

      #Monstruo 13
      tvp = []
      top = []
      bad_stuff = BadStuff.new_level_specific_treasures("Da mucho asquito, Pierdes 3 niveles", 3, tvp, top)
      prize = Prize.new(1, 1)
      @unused_monsters<< Monster.new("Pollipolipo volante", 3, bad_stuff, prize)

      #Monstruo 14
      bad_stuff = BadStuff.new_death("No le hace gracia que pronuncien mal su nombre. Estas muerto")
      prize = Prize.new(3, 1)
      @unused_monsters<< Monster.new("Yskhtihyssg-Goth", 12, bad_stuff, prize)

      #Monstruo 15
      bad_stuff = BadStuff.new_death("La familia te atrapa. Estas muerto")
      prize = Prize.new(4, 1)
      @unused_monsters<< Monster.new("Familia feliz", 1, bad_stuff, prize)

      #Monstruo 16
      tvp = [BOTHHAND]
      top = []
      bad_stuff = BadStuff.new_level_specific_treasures("La quinta directiva primaria te obliga a perder 2 niveles y un tesoro 2 manos visible", 2, tvp, top)
      prize = Prize.new(2, 1)
      @unused_monsters<< Monster.new("Roboggoth", 8, bad_stuff, prize)

      #Monstruo 17
      tvp = [HELMET]
      top = []
      bad_stuff = BadStuff.new_level_specific_treasures("Te asusta en la noche. Pierdes un casco visible.", 0, tvp, top)
      prize = Prize.new(1, 1)
      @unused_monsters<< Monster.new("El espia", 5, bad_stuff, prize)

      #Monstruo 18
      bad_stuff = BadStuff.new_level_number_of_treasures("Menudo susto te llevas. Pierdes 2 niveles y 5 tesoros visibles", 2, 5, 0)
      prize = Prize.new(1, 1)
      @unused_monsters<< Monster.new("El lenguas", 20, bad_stuff, prize)

      #Monstruo 19
      tvp = [BOTHHAND]
      top = []
      bad_stuff = BadStuff.new_level_specific_treasures("Te faltan manos para tanta cabeza. Pierdes 3 niveles y tus tesoros visibles de las manos.", 3, tvp, top)
      prize = Prize.new(1, 1)
      @unused_monsters<< Monster.new("Bicefalo", 20, bad_stuff, prize)
      
      
      #Montruos contra sectarios

      v = [ONEHAND]
      h = Array.new
      bad_stuff = BadStuff.new_level_specific_treasures("Pierdes 1 mano visible.",0, v, h);
      prize = Prize.new(3,1)
      @unused_monsters << Monster.new("El mal indecible impronunciable", 10, bad_stuff, prize, -2)
        
        
      v =  [SHOE,ONEHAND,NECKLACE,HELMET,BOTHHAND,ARMOR]
      h = Array.new
        
      bad_stuff = BadStuff.new_level_specific_treasures("Pierdes tus tesoros visibles. Jajaja.",0, v, h)
      prize = Prize.new(2,1)
      @unused_monsters << Monster.new("Testigos Oculares", 6, bad_stuff, prize, +2)
        
        
      bad_stuff = BadStuff.new_death("Hoy no es tu dia de suerte. Mueres.")
      prize = Prize.new(2,5)
      @unused_monsters << Monster.new("El gran cthulhu", 20, bad_stuff, prize, +4)
 
        
      v = Array.new
      h = Array.new
        
      bad_stuff = BadStuff.new_level_specific_treasures("Tu gobierno te recorta 2 niveles.", 2, v, h)
      prize = Prize.new(2,1)
      @unused_monsters << Monster.new("Serpiente Político", 8, bad_stuff, prize, -2)
        
        
      v = [HELMET, ARMOR]
      h = [BOTHHAND, ONEHAND]

      bad_stuff = BadStuff.new_level_specific_treasures("Pierdes tu casco y tu armadura visible. Pierdes tus manos ocultas.", 0, v, h)
      prize = Prize.new(1,1)
      @unused_monsters << Monster.new("Felpuggoth", 2, bad_stuff, prize, +5)
        
        
      v = Array.new
      h = Array.new
        
      bad_stuff = BadStuff.new_level_specific_treasures("Pierdes 2 niveles.", 2, v, h)
      prize = Prize.new(4,2);
      @unused_monsters << Monster.new("Shoggoth", 16, bad_stuff, prize, -4)
        
      v = Array.new
      h = Array.new
        
      bad_stuff = BadStuff.new_level_specific_treasures("Pintalabios negro. Pierdes 2 niveles.", 2, v, h)
      prize = Prize.new(1,1)
      @unused_monsters << Monster.new("Lolitagooth", 2, bad_stuff, prize, +3) 
      
      
  
    end
    
    def init_cultist_card_deck
      
      #Definimos un array donde almacenar los tesoros
      @unused_cultists = Array.new

      #Creamos los cultistas
      
      #El constructor de Cultist pide: gainedLevels
      
      @unused_cultists << Cultist.new(1)
      @unused_cultists << Cultist.new(2)
      @unused_cultists << Cultist.new(1)
      @unused_cultists << Cultist.new(2)
      @unused_cultists << Cultist.new(1)
      @unused_cultists << Cultist.new(1)
      
    end
    
    #Baraja el mazo de cartas de tesoros unusedTreasures
    def shuffle_treasures
      
      #A partir de ruby 1.8.7
      @unused_treasures = @unused_treasures.shuffle
      
      #Anteriores
      @unused_treasures = @unused_treasures.sort_by { rand }
      
    end
    
    #Baraja el mazo de cartas de monstruos @unused_monsters
    def shuffle_monsters
      
      #A partir de ruby 1.8.7
      @unused_monsters = @unused_monsters.shuffle
      
      #Anteriores
      @unused_monsters  = @unused_monsters.sort_by { rand }
    end
    
    #Baraja el mazo de cartas de monstruos @unused_monsters
    def shuffle_cultists
      
      #A partir de ruby 1.8.7
      @unused_cultists = @unused_cultists.shuffle
      
      #Anteriores
      @unused_cultists  = @unused_cultists.sort_by { rand }
    end

    #Devuelve el siguiente tesoro que hay en el mazo de tesoros (unusedTreasures) 
    #y lo elimina de él. Si el mazo está vacío, pasa el mazo de descartes 
    #(usedTreasures) al mazo de tesoros y lo baraja, dejando el mazo de descartes vacío.
    def next_treasure
    
      #Comprobamos si tenemos cartas en el mazo
      if @unused_treasures.empty?
            
        #Recorremos las cartas descartadas
        @used_treasures.each do |t| 
                
          #Las agregamos al mazo sin usar
          @unused_treasures<<t
        
        end
            
        #Las barajamos
        shuffle_treasures
            
        #Limpiamos el mazo de descartes
        @used_treasures.clear
        
      end
        
      #Obtengo la primera carta del mazo
      t = @unused_treasures.at(0)
        
      #La agregamos al mazo de descartes
      @used_treasures<<t
        
      #La eliminamos del mazo
      @unused_treasures.delete(t);
        
      #Devolvemos la carta
      return t
        
    end

    #Igual que la anterior pero con el mazo de monstruos.
    def next_monster
      
      #Comprobamos si tenemos cartas en el mazo
      if @unused_monsters.empty?
            
        #Recorremos las cartas descartadas
        @used_monsters.each do |m| 
                
          #Las agregamos al mazo sin usar
          @unused_monsters<<m
        
        end
            
        #Las barajamos
        shuffle_monsters
            
        #Limpiamos el mazo de descartes
        @used_treasures.clear
        
      end
        
      #Obtengo la primera carta del mazo
      m = @unused_monsters.at(0)
        
      #La agregamos al mazo de descartes
      @used_monsters<<m
        
      #La eliminamos del mazo
      @unused_monsters.delete(m);
        
      #Devolvemos la carta
      return m
    end
    
    #Igual que la anterior pero con el mazo de cultista.
    def next_cultist
      
      #Comprobamos si tenemos cartas en el mazo
      if @unused_cultists.empty?
            
        #Recorremos las cartas descartadas
        init_cultist_card_deck
            
        #Las barajamos
        shuffle_monsters
        
      end
        
      #Obtengo la primera carta del mazo
      c = @unused_cultists.at(0)
        
      #La eliminamos del mazo
      @unused_cultists.delete(c);
        
      #Devolvemos la carta
      return c
    end
    
    #Introduce en el mazo de descartes de tesoros (usedTreasures) el tesoro t.
    def give_treasure_back(treasure)
      @used_treasures<<treasure
    end
    
    #Introduce en el mazo de descartes de monstruos (usedMonsters) al monstruo m.
    def give_monster_back(monster)
      @used_monsters<<monster
    end
    
    def init_cards
      init_treasure_card_deck #1.2.1
      shuffle_treasures
        
      init_monster_card_deck  #1.2.2
      shuffle_monsters
        
      init_cultist_card_deck  #1.2.3
      shuffle_cultists
    end
    
  end
  
end