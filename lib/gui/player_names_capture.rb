# 
# Ernesto Serrano <erseco@correo.ugr.es>
#
#  © Copyleft - All Wrongs Reserved

  
  Shoes.app :width => 420, :height => 420, :title => "Napakalaki" do

    stack :margin => 20 do
      para "Introduzca los nombres de los jugadores:"

        para "Jugador 1:"
        @player1 = edit_line

        para "Jugador 2:"
        @player2 = edit_line
        
        para "Jugador 3:"
        @player3 = edit_line

      stack :margin => 10 do
        button "Jugar" do
          
          @names = [@player1, @player2, @player3]
       
#          Shoes.p [@name.text, @address.text, @phone.text]
        end
      end

    end

  end
