class apb_driver extends uvm_driver #(apb_xtn);

	`uvm_component_utils(apb_driver)
	
	virtual apb_if.DRV_MP vif;

	apb_agent_config apb_cfg;

	extern function new(string name="apb_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	//extern task run_phase(uvm_phase phase);
	//extern task send_to_dut();

endclass


function apb_driver::new(string name="apb_driver",uvm_component parent);
	super.new(name,parent);
endfunction

function void apb_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	if(!uvm_config_db #(apb_agent_config)::get(this,"","apb_agent_config",apb_cfg))
		`uvm_fatal("CONFIG","Cannot get() apb_agent_config from uvm_config_db. Is it set()?")
endfunction

function void apb_driver::connect_phase(uvm_phase phase);
	vif=apb_cfg.vif;
endfunction	

/* task apb_driver::run_phase(uvm_phase phase);
	forever //begin
              // seq_item_port.get_next_item(req);
		send_to_dut();
               //seq_item_port.item_done();
               // end
endtask

task apb_driver::send_to_dut();
	begin
	//repeat(2)	
	//@(vif.apb_drv_cb);
	//@(vif.apb_drv_cb);
/*
	wait(vif.apb_drv_cb.pselx!=0 && vif.apb_drv_cb.pwrite==0 && vif.apb_drv_cb.penable==1)
		vif.apb_drv_cb.prdata <= $urandom;
		`uvm_info("APB DRIVER",$sformatf("Printing from driver\n The read data =%0d, at address =%0d",vif.apb_drv_cb.prdata,vif.apb_drv_cb.paddr),UVM_LOW)*/
//	@(vif.apb_drv_cb);
	wait(vif.apb_drv_cb.pselx!=0)
             if( vif.apb_drv_cb.pwrite==0)
                begin
                   vif.apb_drv_cb.prdata <= $urandom;
		end
	//wait(vif.apb_drv_cb.penable);
		else
		begin		
                    vif.apb_drv_cb.prdata <= 0;
		end
		//vif.apb_drv_cb.paddr <= xtn.paddr;
		//vif.apb_drv_cb.pwdata <= xtn.pwdata;
//end
		`uvm_info("APB DRIVER",$sformatf("Printing from driver.\n The addr=%0d, Data=%0d",vif.apb_drv_cb.paddr,vif.apb_drv_cb.pwdata),UVM_LOW)		
	//`uvm_info("APB DRIVER",$sformatf("Printing from driver\n %s",xtn.sprint()),UVM_LOW)
	//repeat(2)
	@(vif.apb_drv_cb);
	@(vif.apb_drv_cb);
end
endtask
*/
