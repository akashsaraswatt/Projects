class ahb_monitor extends uvm_monitor;//class ahb_monitor extended from uvm_monitor

        `uvm_component_utils(ahb_monitor)//component registration

        virtual ahb_if.MON_MP vif;//decare virtual interface handle
	uvm_analysis_port #(ahb_xtn) monitor_port; 
        ahb_agent_config ahb_cfg;//declare handle of ahb_agent_config


        //UVM methods
        extern function new(string name="ahb_monitor",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);
        //extern task run_phase(uvm_phase phase);
        //extern task collect_data();
//      extern function  void report_phase(uvm_phase phase);
endclass:ahb_monitor

//constructor method defined
function ahb_monitor::new(string name="ahb_monitor",uvm_component parent);
        super.new(name,parent);//super.new to execute parent new method
	monitor_port=new("monitor_port",this);
endfunction:new


//build phase defined
function void ahb_monitor::build_phase(uvm_phase phase);
        super.build_phase(phase);//super.build_pahse to execute parent build_phase

                //get the ahb_agent_config and if failed get fatal error
                if(!uvm_config_db #(ahb_agent_config)::get(this,"","ahb_agent_config",ahb_cfg))
                        `uvm_fatal("CONFIG","Cannot get() ahb_agent_config from uvm_config_db.Is it set()?")
endfunction:build_phase

//connect phase defined
function void ahb_monitor::connect_phase(uvm_phase phase);
        vif=ahb_cfg.vif;//configurations virtual handle is assigned to monitors virtual handle
endfunction

//run phase define
/* task ahb_monitor::run_phase(uvm_phase phase);
        forever
                collect_data();//collect_data is called in forever loop
endtask:run_phase */

//collect data function is defined
/*task ahb_monitor::collect_data();
	ahb_xtn data_sent;
	
	//`uvm_fatal("MONITOR","Entering run phase")
	data_sent=ahb_xtn::type_id::create("ahb_xtn");
	//@(vif.ahb_mon_cb);
	//wait(vif.ahb_mon_cb.HREADYout && vif.ahb_mon_cb.HWRITE)
	wait((vif.ahb_mon_cb.HTRANS==2'b10)||(vif.ahb_mon_cb.HTRANS==2'b11)&& (vif.ahb_mon_cb.HREADYout))
	data_sent.HTRANS = vif.ahb_mon_cb.HTRANS;
	data_sent.HSIZE = vif.ahb_mon_cb.HSIZE;
	data_sent.HBURST = vif.ahb_mon_cb.HBURST;
	data_sent.HADDR = vif.ahb_mon_cb.HADDR;
	data_sent.HWRITE = vif.ahb_mon_cb.HWRITE;
	//`uvm_info("MONITOR",$sformatf("Print htrans=%0d",data_sent.HTRANS),UVM_LOW)
	@(vif.ahb_mon_cb);
//	wait(vif.ahb_mon_cb.HREADYout);/* && vif.ahb_mon_cb.HWRITE)*/
	if(vif.ahb_mon_cb.HWRITE)
	begin
		data_sent.HWDATA = vif.ahb_mon_cb.HWDATA;
	end
	else
	begin	
		data_sent.HRDATA = vif.ahb_mon_cb.HRDATA;
	end
	      //  @(vif.ahb_mon_cb);
	`uvm_info("AHB MONITOR",$sformatf("Printing from monitor \n %s",data_sent.sprint()),UVM_LOW)
	monitor_port.write(data_sent);
	//repeat(5)
      //	@(vif.ahb_mon_cb);
endtask

*/
