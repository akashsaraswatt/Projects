class ahb_sequencer extends uvm_sequencer #(ahb_xtn);
        // factory registration

        `uvm_component_utils(ahb_sequencer)

        // standard UVM methods:
extern function new(string name = "ahb_sequencer",uvm_component parent);

endclass

//----------------------------------constructor new method -----------------------------------
function ahb_sequencer::new(string name = "ahb_sequencer",uvm_component parent);
        super.new(name,parent);
endfunction
