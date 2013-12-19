# To change this template, choose Tools | Templates
# and open the template in the editor.

Shoes.app :width => 320, :height => 420 do

  stack :margin => 40 do
    stack :margin => 10 do
      para "Nombre"
      @name = list_box :items => ["Ernesto", "Norudin", "Juan"]
    end
    stack :margin => 10 do
      para "Direccion"
      @address = edit_line
    end
    stack :margin => 10 do
      para "Telefono"
      @phone = edit_line
    end
    stack :margin => 10 do
      button "Save" do
        Shoes.p [@name.text, @address.text, @phone.text]
      end
    end

   edit_line
   edit_line width: 400

  end

end
