class ahb_agent_config extends uvm_object;

	`uvm_object_utils(ahb_agent_config)

//configuration parameters

	virtual ahb_if vif;//here im declare interface as a ahb_if//

	uvm_active_passive_enum is_active = UVM_ACTIVE;

   //    bit has_functional_coverage = 0;

//       bit has_scoreboard = 1;

	static int mon_rcvd_xtn_cnt =0;
	static int drv_data_sent_cnt =0;

//      int ahb_verbosity;
	extern function new(string name = "ahb_agent_config");

endclass:ahb_agent_config

function ahb_agent_config::new(string name = "ahb_agent_config");
	super.new(name);
endfunction
