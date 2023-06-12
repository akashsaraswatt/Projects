class rd_agent extends uvm_agent;

`uvm_component_utils(rd_agent)

rd_agent_config r_cfg;

rd_monitor r_mon;
rd_driver r_dr;
rd_sequencer r_seqr;

extern function new(string name = "rd_agent",uvm_component parent = null);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass : rd_agent
//-------------constructor-----------//
function rd_agent::new(string name = "rd_agent",uvm_component parent = null);
super.new(name,parent);
endfunction
//------------build_phase---------------//
function void rd_agent::build_phase(uvm_phase phase);
        super.build_phase(phase);

if(!uvm_config_db #(rd_agent_config)::get(this,"","rd_agent_config",r_cfg))
`uvm_fatal("CONFIG","cannot get() r_cfg from uvm_config_db.Have you set() it?")

        r_mon = rd_monitor::type_id::create("r_mon",this);

        if(r_cfg.is_active == UVM_ACTIVE)
        begin
        r_dr = rd_driver::type_id::create("r_dr",this);
        r_seqr= rd_sequencer::type_id::create("r_seqr",this);
        end
endfunction
//--------------connect_phase-------------------//
function void rd_agent::connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if(r_cfg.is_active == UVM_ACTIVE)
        begin
                r_dr.seq_item_port.connect(r_seqr.seq_item_export);
        end
endfunction
