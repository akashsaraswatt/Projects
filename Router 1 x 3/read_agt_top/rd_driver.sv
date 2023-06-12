class rd_driver extends uvm_driver #(read_xtn);

`uvm_component_utils(rd_driver)

virtual router_if.RDRV_MP vif;

rd_agent_config r_cfg;

extern function new(string name = "rd_driver",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task send_to_dut(read_xtn xtn);
extern function void report_phase(uvm_phase phase);

endclass : rd_driver

//---------------------------constructor-------------------------//
function rd_driver::new(string name = "rd_driver",uvm_component parent);
        super.new(name,parent);
endfunction

//------------------------------build_phase-------------------------------//
function void rd_driver::build_phase(uvm_phase phase);
        super.build_phase(phase);

if(!uvm_config_db #(rd_agent_config)::get(this,"","rd_agent_config",r_cfg))
`uvm_fatal("CONFIG","cannot get() r_cfg from uvm_config_db.Have you set() it?")
endfunction

//------------------------connect_phase---------------------------------//
function void rd_driver::connect_phase(uvm_phase phase);
        vif = r_cfg.vif;
endfunction

//---------------------------run_phase---------------------//
task rd_driver::run_phase(uvm_phase phase);
    forever
                        begin
                                seq_item_port.get_next_item(req);
                                send_to_dut(req);
                                seq_item_port.item_done();
                        end
endtask

task rd_driver::send_to_dut(read_xtn xtn);


begin
                `uvm_info("rd_driver",$sformatf("printing from driver \n %s",xtn.sprint()),UVM_LOW)

                @(vif.rdr_cb);
                wait(vif.rdr_cb.vld_out)
                        repeat(xtn.no_of_cycles)
                        @(vif.rdr_cb);
                        vif.rdr_cb.read_enb<= 1;
                                wait(!vif.rdr_cb.vld_out)
                                vif.rdr_cb.read_enb <= 0;

                        r_cfg.drv_data_count++;
                        @(vif.rdr_cb);
                end
endtask

function void rd_driver::report_phase(uvm_phase phase);
        super.report_phase(phase);
endfunction
