class router_env extends uvm_env;
        `uvm_component_utils(router_env);

        router_env_config cfg;
        router_score sb;
        router_virtual_sequencer v_seqr;
        wr_agent_top w_ag_t;
        rd_agent_top r_ag_t;

        extern function new(string name="ENV",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);
endclass

function router_env::new(string name="ENV",uvm_component parent);
        super.new(name,parent);
endfunction

function void router_env::build_phase(uvm_phase phase);
        if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",cfg))
                `uvm_fatal("DR","cannot get config data");
        super.build_phase(phase);
        if(cfg.has_scoreboard)
                sb=router_score::type_id::create("SB",this);
        if(cfg.has_virtual_sequencer)
                v_seqr=router_virtual_sequencer::type_id::create("V_SEQR",this);
        if(cfg.has_wagent)
                w_ag_t=wr_agent_top::type_id::create("W_AG_T",this);
        if(cfg.has_ragent)
                r_ag_t=rd_agent_top::type_id::create("R_AG_T",this);
endfunction

function void router_env::connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if(cfg.has_virtual_sequencer)
        begin
        foreach(v_seqr.w_seqr[i])
                v_seqr.w_seqr[i]=w_ag_t.w_ag[i].w_seqr;
        foreach(v_seqr.r_seqr[i])
                v_seqr.r_seqr[i]=r_ag_t.r_ag[i].r_seqr;
        end
        if(cfg.has_scoreboard)
        begin
                foreach(w_ag_t.w_ag[i])
                w_ag_t.w_ag[i].w_mon.ap_w.connect(sb.af_w.analysis_export);
                foreach(r_ag_t.r_ag[i])
                r_ag_t.r_ag[i].r_mon.ap_r.connect(sb.af_r[i].analysis_export);
        end
endfunction
