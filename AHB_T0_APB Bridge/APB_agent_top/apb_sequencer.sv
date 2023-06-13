class apb_sequencer extends uvm_sequencer #(apb_xtn);

        //factory registration
        `uvm_component_utils(apb_sequencer)

extern function new(string name = "apb_sequencer",uvm_component parent);

endclass

//-------------------------------------- constructor method ----------------------------

function apb_sequencer::new(string name = "apb_sequencer",uvm_component parent);
        super.new(name,parent);
endfunction


