class wr_agent_config extends uvm_object;

`uvm_object_utils(wr_agent_config)

uvm_active_passive_enum is_active = UVM_ACTIVE;

virtual router_if vif;

static int mon_data_count = 0;

static int drv_data_count = 0;

extern function new(string name = "wr_agent_config");

endclass: wr_agent_config

function wr_agent_config::new(string name = "wr_agent_config");
super.new(name);
endfunction
