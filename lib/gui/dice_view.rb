# encoding: UTF-8
# 
# Ernesto Serrano <erseco@correo.ugr.es>
#
#  2014 © Copyleft - All Wrongs Reserved
#

Shoes.app :width => 100, :height => 150, :title => "Dado" do

  stack :margin => 20 do

    @lbl_dice = para "1"
	
	@bt_stop = button "Stop" do

		@bt_stop.hide	
		@animate.stop

	   	@bt_ok = button "OK" do
	 
			alert "Te ha salido:" + @lbl_dice.text

	    end		 

	end

	@animate = animate(10) do
		#Devolvemos random --random(6) va de 0 a 5
		@lbl_dice.text = 1 + rand(6)
	end

  end

end