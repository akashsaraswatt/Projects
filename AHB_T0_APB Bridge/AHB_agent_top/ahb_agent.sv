class ahb_agent extends uvm_agent;//ahb_agent class extended from uvm_agent

        `uvm_component_utils(ahb_agent)//component registration

        ahb_agent_config ahb_cfg;//ahb_agent_config handle declaration

        ahb_monitor ahb_mon;//ahb_monitor handle declaration
        ahb_driver ahb_drv;//ahb_driver handle declaration
        ahb_sequencer ahb_seqr;//ahb_sequencer handle declaration


        //UVM methods declared
        extern function new(string name="ahb_agent", uvm_component parent=null);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);
	

endclass:ahb_agent


//constructor method defined
function ahb_agent::new(string name="ahb_agent", uvm_component parent=null);
        super.new(name,parent);//super.new to execute the parent constructor method
endfunction:new

//build phase defined
function void ahb_agent::build_phase(uvm_phase phase);
        super.build_phase(phase);//super.build_phase to execute the parent build_phase

        //get the ahb_agent_config and if failed get fatal error
        if(!uvm_config_db #(ahb_agent_config)::get(this,"","ahb_agent_config",ahb_cfg))
                `uvm_fatal("CONFIG","Cannot get() ahb_agent_config from uvm_config_db.Is it set()?")

        //create ahb_monitor without any condition
        ahb_mon=ahb_monitor::type_id::create("ahb_mon",this);

        //if agent is active create ahb_driver and ahb)sequencer
        if(ahb_cfg.is_active==UVM_ACTIVE)
        begin
                ahb_drv=ahb_driver::type_id::create("ahb_drv",this);
                ahb_seqr=ahb_sequencer::type_id::create("ahb_seqr",this);
        end
endfunction:build_phase

//connect phase defined
function void ahb_agent::connect_phase(uvm_phase phase);
        
	//if agent is active connect driver and sequencer
        if(ahb_cfg.is_active==UVM_ACTIVE)
                ahb_drv.seq_item_port.connect(ahb_seqr.seq_item_export);
endfunction:connect_phase


