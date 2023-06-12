class wr_agent_top extends uvm_env;

`uvm_component_utils(wr_agent_top)

router_env_config cfg;
wr_agent_config w_cfg[];
wr_agent w_ag[];

extern function new(string name ="wr_agent_top",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task  run_phase(uvm_phase phase);

endclass : wr_agent_top

//------------------------constructer---------------------//
function wr_agent_top::new(string name ="wr_agent_top",uvm_component parent);
        super.new(name,parent);
endfunction

//---------------------build_phase----------------------------//
function void wr_agent_top::build_phase(uvm_phase phase);
        if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",cfg))
                `uvm_fatal("AGT_TOP","cannot get config data");

        w_cfg=new[cfg.no_of_masters];
        w_ag=new[cfg.no_of_masters];

        foreach(w_ag[i]) begin
                w_cfg[i]=wr_agent_config::type_id::create($sformatf("W_AGENT_CFG[%0d]",i));
                w_cfg[i]=cfg.w_cfg[i];
                w_ag[i]=wr_agent::type_id::create($sformatf("W_AGENT[%0d]",i),this);
                uvm_config_db#(wr_agent_config)::set(this,$sformatf("W_AGENT[%0d]*",i),"wr_agent_config",cfg.w_cfg[i]);
        end
endfunction

//------------------run_phase--------------------------//
task wr_agent_top::run_phase(uvm_phase phase);
//      uvm_top.print_topology;
endtask
