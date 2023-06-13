class env extends uvm_env;

        `uvm_component_utils(env)

        ahb_agent ahb_agt;
        apb_agent apb_agt;

        virtual_sequencer v_seqr;

        scoreboard sb;

        env_config cfg_h;

        extern function new(string name="env",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);
endclass

function env::new(string name="env",uvm_component parent);
        super.new(name,parent);
endfunction

function void env::build_phase(uvm_phase phase);
        if(!uvm_config_db #(env_config)::get(this,"","env_config",cfg_h))
                `uvm_fatal("CONFIG","Cannot get() env_config from uvm_config_db.Is it set()?");

        super.build_phase(phase);

        if(cfg_h.has_ahb_agt)
        begin

                uvm_config_db #(ahb_agent_config)::set(this,"ahb_agt*","ahb_agent_config",cfg_h.ahb_cfg);

                ahb_agt=ahb_agent::type_id::create("ahb_agt",this);
        end

        if(cfg_h.has_apb_agt)
        begin
             
                uvm_config_db #(apb_agent_config)::set(this,"apb_agt*","apb_agent_config",cfg_h.apb_cfg);
                apb_agt=apb_agent::type_id::create("apb_agt",this);
        end

        if(cfg_h.has_vsequencer)
                v_seqr=virtual_sequencer::type_id::create("v_seqr",this);

       if(cfg_h.has_scoreboard)
        begin
                sb=scoreboard::type_id::create("sb",this);
        end
endfunction

function void env::connect_phase(uvm_phase phase);
        if(cfg_h.has_vsequencer)
        begin
                if(cfg_h.has_ahb_agt)
                        v_seqr.ahb_seqrh=ahb_agt.ahb_seqr;
                if(cfg_h.has_apb_agt)
                        v_seqr.apb_seqrh=apb_agt.apb_seqr;
        end

        if(cfg_h.has_scoreboard)
		begin
                ahb_agt.ahb_mon.monitor_port.connect(sb.af_ahb_h.analysis_export);

             	apb_agt.apb_mon.monitor_port.connect(sb.af_apb_h.analysis_export);
        end
endfunction

