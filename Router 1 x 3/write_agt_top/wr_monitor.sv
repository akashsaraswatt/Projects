class wr_monitor extends uvm_monitor;
        `uvm_component_utils(wr_monitor);

        virtual router_if.WMON_MP vif;

        router_env_config cfg;
        wr_agent_config w_cfg;
        uvm_analysis_port #(write_xtn) ap_w;


        extern function new(string name="wr_monitor",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
        extern task collect_data;
endclass

function wr_monitor::new(string name="wr_monitor",uvm_component parent);
        super.new(name,parent);
ap_w=new("ap_w",this);


//ap_w=new[cfg.no_of_masters];
  //      foreach(ap_w[i])
    //            ap_w[i]=new($sformatf("ap_w[%0d]",i),this);
endfunction

function void wr_monitor::build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(wr_agent_config)::get(this,"","wr_agent_config",w_cfg))
                `uvm_fatal("MON","cannot get config data");

endfunction

function void wr_monitor::connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        vif=w_cfg.vif;
endfunction

task wr_monitor::run_phase(uvm_phase phase);
        forever
//repeat(20)
      collect_data;
endtask

task wr_monitor::collect_data;
            write_xtn xtn;
        begin
                        xtn=write_xtn::type_id::create("xtn");
                        @(vif.wmon_cb);
                        wait(!vif.wmon_cb.busy && vif.wmon_cb.pkt_valid)
                        xtn.header=vif.wmon_cb.data_in;
                        xtn.payload_data=new[xtn.header[7:2]];
        @(vif.wmon_cb);
        foreach(xtn.payload_data[i])
                begin
                                wait(!vif.wmon_cb.busy)
                                xtn.payload_data[i]=vif.wmon_cb.data_in;
                                @(vif.wmon_cb);
                end
        wait(!vif.wmon_cb.pkt_valid && !vif.wmon_cb.busy)
        xtn.parity=vif.wmon_cb.data_in;
        repeat(2)@(vif.wmon_cb);
                xtn.err = vif.wmon_cb.err;

                w_cfg.mon_data_count++;
                ap_w.write(xtn);
                `uvm_info("router_wr_monitor",$sformatf("printing from monitor \n %s", xtn.sprint()),UVM_LOW)
                end

endtask
