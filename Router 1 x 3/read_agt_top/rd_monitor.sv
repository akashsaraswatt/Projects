class rd_monitor extends uvm_monitor ;

`uvm_component_utils(rd_monitor)

virtual router_if.RMON_MP vif;

rd_agent_config r_cfg;

uvm_analysis_port #(read_xtn) ap_r;
read_xtn xtn;

extern function new(string name = "rd_monitor",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();
extern function void report_phase(uvm_phase phase);

endclass

//--------------------------constructor---------------------------------------//
function rd_monitor::new(string name = "rd_monitor",uvm_component parent);
        super.new(name,parent);
ap_r=new("ap_r",this);


endfunction

//--------------------------build_phase-------------------------------------//
function void rd_monitor::build_phase(uvm_phase phase);
        super.build_phase(phase);

if(!uvm_config_db #(rd_agent_config)::get(this,"","rd_agent_config",r_cfg))
`uvm_fatal("CONFIG","cannot get() r_cfg from uvm_config_db.Have you set() it?")
endfunction

//---------------------------connect_phase--------------------------------//
function void rd_monitor::connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        vif = r_cfg.vif;
endfunction

//-----------------------run_phase----------------------------------------//
task rd_monitor::run_phase(uvm_phase phase);
        forever
                        collect_data();
endtask

task rd_monitor::collect_data;

read_xtn mon_data;
        mon_data=read_xtn::type_id::create("mon_data");

        @(vif.rmon_cb);
        wait(vif.rmon_cb.read_enb)
        @(vif.rmon_cb);
        mon_data.header = vif.rmon_cb.data_out;
        mon_data.payload_data = new[mon_data.header[7:2]];

        @(vif.rmon_cb);
        foreach(mon_data.payload_data[i])
                begin
                        mon_data.payload_data[i] = vif.rmon_cb.data_out;
                        @(vif.rmon_cb);
                end

        mon_data.parity = vif.rmon_cb.data_out;
        @(vif.rmon_cb);

        `uvm_info("rd_monitor",$sformatf("printing from monitor \n %s",mon_data.sprint()),UVM_LOW);
        r_cfg.mon_data_count++;
        ap_r.write(mon_data);


endtask

function void rd_monitor::report_phase(uvm_phase phase);
        super.report_phase(phase);
endfunction
