class env_config extends uvm_object;

        `uvm_object_utils(env_config)

        bit has_scoreboard=1;
        bit has_ahb_agt=1;
        bit has_apb_agt=1;
        bit has_vsequencer=1;
	bit has_coverage=1;
        ahb_agent_config ahb_cfg;
        apb_agent_config apb_cfg;


        extern function new(string name="env_config");
endclass:env_config

function env_config::new(string name="env_config");
        super.new(name);
endfunction

