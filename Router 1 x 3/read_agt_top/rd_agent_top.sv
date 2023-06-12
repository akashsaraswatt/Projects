class rd_agent_top extends uvm_env;

`uvm_component_utils(rd_agent_top)

router_env_config cfg;
rd_agent r_ag[];

extern function new(string name ="rd_agent_top",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task  run_phase(uvm_phase phase);

endclass : rd_agent_top

//------------------------constructer---------------------//
function rd_agent_top::new(string name ="rd_agent_top",uvm_component parent);
        super.new(name,parent);
endfunction

//---------------------build_phase----------------------------//
function void rd_agent_top::build_phase(uvm_phase phase);
        if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",cfg))
                `uvm_fatal("AGT_TOP","cannot get config data");
        r_ag=new[cfg.no_of_slaves];
        foreach(r_ag[i]) begin
        r_ag[i]=rd_agent::type_id::create($sformatf("R_AGENT[%0d]",i),this);
        uvm_config_db#(rd_agent_config)::set(this,$sformatf("R_AGENT[%0d]*",i),"rd_agent_config",cfg.r_cfg[i]);
        end
endfunction

//------------------run_phase--------------------------//
task rd_agent_top::run_phase(uvm_phase phase);
//      uvm_top.print_topology;
endtask
