# encoding: UTF-8
# 
# Ernesto Serrano <erseco@correo.ugr.es>
#
#  2014 © Copyleft - All Wrongs Reserved
#

Shoes.app :width => 600, :height => 420, :title => "Napakalaki" do

	stack :margin => 10 do
		border black, strokewidth: 1 
		@player = para "Jugador: "
		@nivel = para "Nivel: "


		flow margin: 10 do
			@bt_buy_levels = button "Comprar Niveles"
			@bt_make_visible = button "Hacer Visible"
			@bt_discard_treasure = button "Descartar Tesoros"
		end

	end



	stack :margin => 10 do
		border black, strokewidth: 1
		@monster = para "Monstruo: "
		@monster_level = para "Nivel: "
	end

	@bt_combat = button "Combatir"
	@bt_next_turn = button "Siguiente Turno"
	@result = para "Resultado: "

end