class apb_base_seq extends uvm_sequence #(apb_xtn);

        //factory registration
        `uvm_object_utils(apb_base_seq)
        // standard UVM methos

extern function new(string name = "apb_base_seq");
endclass

//---------------------------------constructor new method --------------------------------------------------------
function apb_base_seq::new(string name = "apb_base_seq");
        super.new(name);
endfunction


