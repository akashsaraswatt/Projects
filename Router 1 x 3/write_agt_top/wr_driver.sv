class wr_driver extends uvm_driver #(write_xtn);
        `uvm_component_utils(wr_driver);

        virtual router_if.WDR_MP vif;

        wr_agent_config w_cfg;

        extern function new(string name="wr_driver",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
        extern task send_to_dut(write_xtn xtn);
endclass

function wr_driver::new(string name="wr_driver",uvm_component parent);
        super.new(name,parent);
endfunction

function void wr_driver::build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(wr_agent_config)::get(this,"","wr_agent_config",w_cfg))
                `uvm_fatal("DR","cannot get config data");
endfunction

function void wr_driver::connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        vif=w_cfg.vif;
endfunction

task wr_driver::run_phase(uvm_phase phase);
        @(vif.wdr_cb);
        vif.wdr_cb.resetn<=0;
        @(vif.wdr_cb);
        vif.wdr_cb.resetn<=1;

        forever
                begin
                        seq_item_port.get_next_item(req);
                        send_to_dut(req);
                        seq_item_port.item_done();
                end
endtask

task wr_driver::send_to_dut(write_xtn xtn);
`uvm_info("Router_Wr__Driver",$sformatf("printing from driver \n %s",xtn.sprint()),UVM_LOW)
        @(vif.wdr_cb);
        wait(!vif.wdr_cb.busy)
        vif.wdr_cb.pkt_valid<=1;
        vif.wdr_cb.data_in<=xtn.header;
        @(vif.wdr_cb);
        foreach(xtn.payload_data[i])
                begin
                                wait(!vif.wdr_cb.busy)
                                vif.wdr_cb.data_in<=xtn.payload_data[i];
                                @(vif.wdr_cb);
                end
        wait(!vif.wdr_cb.busy)
        vif.wdr_cb.pkt_valid<=0;
        vif.wdr_cb.data_in<=xtn.parity;
        repeat(2)@(vif.wdr_cb);
        xtn.err = vif.wdr_cb.err;

        //seq_item_port.put_response(xtn);

        w_cfg.drv_data_count++;

endtask
