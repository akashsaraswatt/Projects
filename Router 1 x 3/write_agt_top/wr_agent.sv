class wr_agent extends uvm_agent;
        `uvm_component_utils(wr_agent);

        wr_monitor w_mon;
        wr_driver w_dr;
        wr_agent_config w_cfg;
        wr_sequencer w_seqr;

        extern function new(string name="W_AGENT",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass

function wr_agent::new(string name="W_AGENT",uvm_component parent);
        super.new(name,parent);
endfunction

function void wr_agent::build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(wr_agent_config)::get(this,"","wr_agent_config",w_cfg))
                `uvm_fatal("W_AGENT","cannot get config data");

        w_mon=wr_monitor::type_id::create("W_MON",this);
        if(w_cfg.is_active==UVM_ACTIVE)
                begin
                w_dr= wr_driver::type_id::create("W_DR",this);
                w_seqr= wr_sequencer::type_id::create("W_SEQR",this);
                end
endfunction

function void wr_agent::connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if(w_cfg.is_active == UVM_ACTIVE)
        begin
                w_dr.seq_item_port.connect(w_seqr.seq_item_export);
        end

endfunction

task wr_agent::run_phase(uvm_phase phase);
        uvm_top.print_topology;
endtask
