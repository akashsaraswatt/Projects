class base_test extends uvm_test;

	//Register with Factory
	`uvm_component_utils(base_test)

	//Environment Handle
	env env_h;
	
	bit has_scoreboard=1;
	bit has_vsequencer=1;
	bit has_coverage=1;
	bit has_ahb_agt=1;
	bit has_apb_agt=1;
	//Virtual Sequence Handles
//	virtual_sequence r_seqh;

	//Env Configuration Object Handle
	env_config cfg_h;
	ahb_agent_config ahb_cfg;
	apb_agent_config apb_cfg;
	//--------------------------------------------
	// Methods
	// -------------------------------------------
	extern function new(string name = "base_test", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void configuration();
	//extern function void end_of_elaboration_phase(uvm_phase phase);
	//extern function void report_phase(uvm_phase phase);
	
endclass: base_test

//Base Test Constructor
function base_test::new(string name = "base_test", uvm_component parent);
	super.new(name, parent);
endfunction //new

function void base_test::configuration();
	if(has_ahb_agt)
	begin
		ahb_cfg=ahb_agent_config::type_id::create("ahb_cfg");
		
		if(!uvm_config_db#(virtual ahb_if)::get(this, "", "ahb_vif", ahb_cfg.vif))
			`uvm_fatal("BASE_TEST", "Cannot get AHB Virtual Interface from TOP")
		ahb_cfg.is_active=UVM_ACTIVE;
		cfg_h.ahb_cfg=ahb_cfg;
	end
	if(has_apb_agt)
	begin
		apb_cfg=apb_agent_config::type_id::create("apb_cfg");
	
				
		if(!uvm_config_db#(virtual apb_if)::get(this, "", "apb_vif", apb_cfg.vif))
			`uvm_fatal("BASE_TEST", "Cannot get APB Virtual Interface from TOP")
		apb_cfg.is_active=UVM_ACTIVE;
		cfg_h.apb_cfg=apb_cfg;
	end
	
	cfg_h.has_scoreboard = has_scoreboard;
	cfg_h.has_vsequencer = has_vsequencer;
	cfg_h.has_coverage = has_coverage;
	cfg_h.has_ahb_agt=has_ahb_agt;
	cfg_h.has_apb_agt=has_apb_agt;
endfunction
//Base Test Build Phase
function void base_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	//Create Env Configuration Object from TOP
	cfg_h = env_config::type_id::create("cfg_h");

	//Get AHB Virtual Interface from TOP
	if(has_ahb_agt)
		cfg_h.ahb_cfg=new();
	if(has_apb_agt)
		cfg_h.apb_cfg=new();
	configuration();

	//Set Env Configuration Object
	uvm_config_db#(env_config)::set(this, "*", "env_config", cfg_h);

	//Create Env
	env_h = env::type_id::create("env_h", this);

endfunction //build_phase

/*function void base_test::end_of_elaboration_phase(uvm_phase phase);
	print();
endfunction //end_of_elaboration_phase*/
/*function void base_test::report_phase(uvm_phase phase);
	uvm_top.print_topology();
endfunction*/

//----------------------------------------------------------------------------------------
// request Test
// ---------------------------------------------------------------------------------------

/*
class single_ahb_test extends base_test;

	`uvm_component_utils(single_ahb_test)

	single_vseq ahb_seqh;

	extern function new(string name="single_ahb_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	
endclass

function single_ahb_test::new(string name="single_ahb_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void single_ahb_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task single_ahb_test::run_phase(uvm_phase phase);
	
	phase.raise_objection(this);
	ahb_seqh=single_vseq::type_id::create("ahb_seqh");
	ahb_seqh.start(env_h.v_seqr);
	phase.drop_objection(this);
endtask

class ahb_wrap4_test extends base_test;

	`uvm_component_utils(ahb_wrap4_test)

	ahb_wrap4_vseq ahb_seqh;

	extern function new(string name="ahb_wrap4_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function ahb_wrap4_test::new(string name="ahb_wrap4_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void ahb_wrap4_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task ahb_wrap4_test::run_phase(uvm_phase phase);

	phase.raise_objection(this);
	ahb_seqh=ahb_wrap4_vseq::type_id::create("ahb_seqh");
	ahb_seqh.start(env_h.v_seqr);
	phase.drop_objection(this);
endtask


class ahb_incr4_test extends base_test;

	`uvm_component_utils(ahb_incr4_test)

	ahb_incr4_vseq ahb_seqh;

	extern function new(string name="ahb_incr4_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function ahb_incr4_test::new(string name="ahb_incr4_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void ahb_incr4_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task ahb_incr4_test::run_phase(uvm_phase phase);

	phase.raise_objection(this);
	ahb_seqh=ahb_incr4_vseq::type_id::create("ahb_seqh");
	ahb_seqh.start(env_h.v_seqr);
	phase.drop_objection(this);
endtask


class ahb_wrap8_test extends base_test;

	`uvm_component_utils(ahb_wrap8_test)

	ahb_wrap8_vseq ahb_seqh;

	extern function new(string name="ahb_wrap8_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function ahb_wrap8_test::new(string name="ahb_wrap8_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void ahb_wrap8_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task ahb_wrap8_test::run_phase(uvm_phase phase);

	phase.raise_objection(this);
	ahb_seqh=ahb_wrap8_vseq::type_id::create("ahb_seqh");
	ahb_seqh.start(env_h.v_seqr);
	phase.drop_objection(this);
endtask


class ahb_incr8_test extends base_test;

	`uvm_component_utils(ahb_incr8_test)

	ahb_incr8_vseq ahb_seqh;

	extern function new(string name="ahb_incr8_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function ahb_incr8_test::new(string name="ahb_incr8_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void ahb_incr8_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task ahb_incr8_test::run_phase(uvm_phase phase);

	
	phase.raise_objection(this);
	ahb_seqh=ahb_incr8_vseq::type_id::create("ahb_seqh");
	ahb_seqh.start(env_h.v_seqr);
	phase.drop_objection(this);
endtask


class ahb_wrap16_test extends base_test;

	`uvm_component_utils(ahb_wrap16_test)

	ahb_wrap16_vseq ahb_seqh;

	extern function new(string name="ahb_wrap16_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function ahb_wrap16_test::new(string name="ahb_wrap16_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void ahb_wrap16_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task ahb_wrap16_test::run_phase(uvm_phase phase);

	phase.raise_objection(this);
	ahb_seqh=ahb_wrap16_vseq::type_id::create("ahb_seqh");
	ahb_seqh.start(env_h.v_seqr);
	phase.drop_objection(this);
endtask


class ahb_incr16_test extends base_test;

	`uvm_component_utils(ahb_incr16_test)

	ahb_incr16_vseq ahb_seqh;

	extern function new(string name="ahb_incr16_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function ahb_incr16_test::new(string name="ahb_incr16_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void ahb_incr16_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task ahb_incr16_test::run_phase(uvm_phase phase);
	
	phase.raise_objection(this);
	ahb_seqh=ahb_incr16_vseq::type_id::create("ahb_seqh");
	ahb_seqh.start(env_h.v_seqr);
           // #10000;
	phase.drop_objection(this);
endtask



class unspecified_test extends base_test;

	`uvm_component_utils(unspecified_test)

	unspecified_vseq ahb_seqh;

	extern function new(string name="unspecified_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function unspecified_test::new(string name="unspecified_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void unspecified_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task unspecified_test::run_phase(uvm_phase phase);

	phase.raise_objection(this);
	ahb_seqh=unspecified_vseq::type_id::create("ahb_seqh");
	ahb_seqh.start(env_h.v_seqr);
	phase.drop_objection(this);
endtask


class rsingle_ahb_test extends base_test;

	`uvm_component_utils(rsingle_ahb_test)

	rsingle_vseq ahb_seqh;

	extern function new(string name="rsingle_ahb_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	
endclass

function rsingle_ahb_test::new(string name="rsingle_ahb_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void rsingle_ahb_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task rsingle_ahb_test::run_phase(uvm_phase phase);
	
	phase.raise_objection(this);
	ahb_seqh=rsingle_vseq::type_id::create("ahb_seqh");
	ahb_seqh.start(env_h.v_seqr);
	phase.drop_objection(this);
endtask


class rahb_wrap4_test extends base_test;

	`uvm_component_utils(rahb_wrap4_test)

	rahb_wrap4_vseq ahb_seqh;

	extern function new(string name="rahb_wrap4_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function rahb_wrap4_test::new(string name="rahb_wrap4_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void rahb_wrap4_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task rahb_wrap4_test::run_phase(uvm_phase phase);
	
	phase.raise_objection(this);
	ahb_seqh=rahb_wrap4_vseq::type_id::create("ahb_seqh");
	ahb_seqh.start(env_h.v_seqr);
	phase.drop_objection(this);
endtask



class rahb_incr4_test extends base_test;

	`uvm_component_utils(rahb_incr4_test)

	rahb_incr4_vseq ahb_seqh;

	extern function new(string name="rahb_incr4_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function rahb_incr4_test::new(string name="rahb_incr4_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void rahb_incr4_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task rahb_incr4_test::run_phase(uvm_phase phase);
	
	phase.raise_objection(this);
	ahb_seqh=rahb_incr4_vseq::type_id::create("ahb_seqh");
	ahb_seqh.start(env_h.v_seqr);
	phase.drop_objection(this);
endtask


class rahb_wrap8_test extends base_test;

	`uvm_component_utils(rahb_wrap8_test)

	rahb_wrap8_vseq ahb_seqh;

	extern function new(string name="rahb_wrap8_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function rahb_wrap8_test::new(string name="rahb_wrap8_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void rahb_wrap8_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task rahb_wrap8_test::run_phase(uvm_phase phase);
	
	phase.raise_objection(this);
	ahb_seqh=rahb_wrap8_vseq::type_id::create("ahb_seqh");
	ahb_seqh.start(env_h.v_seqr);
	phase.drop_objection(this);
endtask


class rahb_wrap16_test extends base_test;

	`uvm_component_utils(rahb_wrap16_test)

	rahb_wrap16_vseq ahb_seqh;

	extern function new(string name="rahb_wrap16_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function rahb_wrap16_test::new(string name="rahb_wrap16_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void rahb_wrap16_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task rahb_wrap16_test::run_phase(uvm_phase phase);
	
	phase.raise_objection(this);
	ahb_seqh=rahb_wrap16_vseq::type_id::create("ahb_seqh");
	ahb_seqh.start(env_h.v_seqr);
	phase.drop_objection(this);
endtask


class rahb_incr8_test extends base_test;

	`uvm_component_utils(rahb_incr8_test)

	rahb_incr8_vseq ahb_seqh;

	extern function new(string name="rahb_incr8_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function rahb_incr8_test::new(string name="rahb_incr8_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void rahb_incr8_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task rahb_incr8_test::run_phase(uvm_phase phase);
	
	phase.raise_objection(this);
	ahb_seqh=rahb_incr8_vseq::type_id::create("ahb_seqh");
	ahb_seqh.start(env_h.v_seqr);
	phase.drop_objection(this);
endtask


class rahb_incr16_test extends base_test;

	`uvm_component_utils(rahb_incr16_test)

	rahb_incr16_vseq ahb_seqh;

	extern function new(string name="rahb_incr16_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function rahb_incr16_test::new(string name="rahb_incr16_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void rahb_incr16_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

task rahb_incr16_test::run_phase(uvm_phase phase);
	
	phase.raise_objection(this);
	ahb_seqh=rahb_incr16_vseq::type_id::create("ahb_seqh");
	ahb_seqh.start(env_h.v_seqr);
	phase.drop_objection(this);
endtask


class rwahb_incr4_test extends base_test;

        `uvm_component_utils(rwahb_incr4_test)

        rwahb_incr4_vseq ahb_seqh;

        extern function new(string name="rwahb_incr4_test",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass

function rwahb_incr4_test::new(string name="rwahb_incr4_test",uvm_component parent);
        super.new(name,parent);
endfunction

function void rwahb_incr4_test::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

task rwahb_incr4_test::run_phase(uvm_phase phase);

        phase.raise_objection(this);
        ahb_seqh=rwahb_incr4_vseq::type_id::create("ahb_seqh");
        ahb_seqh.start(env_h.v_seqr);
        phase.drop_objection(this);
endtask

class ibahb_incr16_test extends base_test;

        `uvm_component_utils(ibahb_incr16_test)

        ibahb_incr16_vseq ahb_seqh;

        extern function new(string name="ibahb_incr16_test",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
endclass

function ibahb_incr16_test::new(string name="ibahb_incr16_test",uvm_component parent);
        super.new(name,parent);
endfunction

function void ibahb_incr16_test::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

task ibahb_incr16_test::run_phase(uvm_phase phase);

        phase.raise_objection(this);
        ahb_seqh=ibahb_incr16_vseq::type_id::create("ahb_seqh");
        ahb_seqh.start(env_h.v_seqr);
        phase.drop_objection(this);
endtask


*/
