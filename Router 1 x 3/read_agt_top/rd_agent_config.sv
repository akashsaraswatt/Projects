class rd_agent_config extends uvm_object;

`uvm_object_utils(rd_agent_config)

uvm_active_passive_enum is_active = UVM_ACTIVE;

virtual router_if vif;

static int mon_data_count = 0;
static int drv_data_count = 0;

extern function new(string name = "rd_agent_config");

endclass: rd_agent_config

function rd_agent_config::new(string name = "rd_agent_config");
super.new(name);
endfunction
