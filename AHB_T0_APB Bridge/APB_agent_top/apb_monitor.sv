class apb_monitor extends uvm_monitor;

	`uvm_component_utils(apb_monitor)
	
	virtual apb_if.MON_MP vif;
	uvm_analysis_port #(apb_xtn) monitor_port;
	
	apb_agent_config apb_cfg;
		
	extern function new(string name="apb_monitor",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);
      //  extern task run_phase(uvm_phase phase);
       // extern task collect_data();
endclass

function apb_monitor::new(string name="apb_monitor",uvm_component parent);
        super.new(name,parent);
	monitor_port=new("monitor_port",this);	
//super.new to execute parent new method
endfunction:new

function void apb_monitor::build_phase(uvm_phase phase);
        super.build_phase(phase);//super.build_pahse to execute parent build_phase

                //get the ahb_agent_config and if failed get fatal error
                if(!uvm_config_db #(apb_agent_config)::get(this,"","apb_agent_config",apb_cfg))
                        `uvm_fatal("CONFIG","Cannot get() apb_agent_config from uvm_config_db.Is it set()?")
endfunction:build_phase

function void apb_monitor::connect_phase(uvm_phase phase);
        vif=apb_cfg.vif;//configurations virtual handle is assigned to monitors virtual handle
endfunction

/* task apb_monitor::run_phase(uvm_phase phase);
        forever begin
                collect_data();//collect_data is called in forever loop
end
endtask:run_phase

task apb_monitor::collect_data();

	apb_xtn data_sent;//ahb_xtn handle is created

        data_sent=apb_xtn::type_id::create("data_sent");
	
	@(vif.apb_mon_cb);
//	if(vif.apb_mon_cb.pselx!=0)	
	wait(vif.apb_mon_cb.penable && vif.apb_mon_cb.pselx!=0);
//	@(vif.apb_mon_cb);
               data_sent.pselx = vif.apb_mon_cb.pselx;
                data_sent.paddr = vif.apb_mon_cb.paddr;
                data_sent.penable = vif.apb_mon_cb.penable;
	if(vif.apb_mon_cb.pwrite==0)
	begin
		data_sent.prdata = vif.apb_mon_cb.prdata;
		`uvm_info("APB MONITOR",$sformatf("Printing from monitor.\n The read data=%0d, at address =%0d",data_sent.prdata,data_sent.paddr),UVM_LOW);
	end
	else
	begin
//		@(vif.apb_mon_cb);
		data_sent.pwdata = vif.apb_mon_cb.pwdata;
		`uvm_info("APB MONITOR", $sformatf("Printing from monitor.\n The written data=%0d, at address =%0d",data_sent.pwdata,data_sent.paddr),UVM_LOW);
         //@(vif.apb_mon_cb);
    end	
	`uvm_info("APB MONITOR", $sformatf("printing from monitor.\n %s",data_sent.sprint()),UVM_LOW);
	monitor_port.write(data_sent);

	
endtask
*/
