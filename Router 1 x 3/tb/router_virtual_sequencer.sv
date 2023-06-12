class router_virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);
        `uvm_component_utils(router_virtual_sequencer);

        wr_sequencer w_seqr[];
        router_env_config cfg;
        rd_sequencer r_seqr[];
        extern function new(string name="V_SEQR",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
endclass

function router_virtual_sequencer::new(string name="V_SEQR",uvm_component parent);
        super.new(name,parent);
endfunction

function void router_virtual_sequencer::build_phase(uvm_phase phase);
        if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",cfg))
                `uvm_fatal("VIRTUAL_SEQUENCER","cannot get config data");
        w_seqr=new[cfg.no_of_masters];
        r_seqr=new[cfg.no_of_slaves];
endfunction
