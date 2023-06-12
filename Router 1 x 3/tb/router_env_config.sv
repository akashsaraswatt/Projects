class router_env_config extends uvm_object;

        `uvm_object_utils(router_env_config)

        int no_of_masters=1;
        int no_of_slaves=3;
        bit has_scoreboard=1;
        bit has_virtual_sequencer=1;
        bit has_ragent = 1;
        bit has_wagent = 1;
        wr_agent_config w_cfg[];
        rd_agent_config r_cfg[];

        extern function new(string name="ENV_CONFIG");

endclass

function router_env_config::new(string name="ENV_CONFIG");
        super.new(name);
endfunction