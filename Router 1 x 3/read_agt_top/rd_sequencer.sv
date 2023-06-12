class rd_sequencer extends uvm_sequencer #(read_xtn);

`uvm_component_utils(rd_sequencer)

extern function new(string name = "rd_sequencer",uvm_component parent);

endclass : rd_sequencer

//----------------constructor-----------------//
function rd_sequencer::new(string name = "rd_sequencer",uvm_component parent);
        super.new(name,parent);
endfunction
