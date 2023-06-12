class router_score extends uvm_scoreboard;

        `uvm_component_utils(router_score)

        uvm_tlm_analysis_fifo #(write_xtn) af_w;
        uvm_tlm_analysis_fifo #(read_xtn) af_r[];

        router_env_config       env_cfg;

        write_xtn write_data,mst_cov_data;
        read_xtn read_data,slv_cov_data;

        static int data_verified_count = 0;
        bit [7:0] sb_parity;

        extern function new(string name = "router_score",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase (uvm_phase phase);
        extern function void check_data(read_xtn sd);
        extern function void report_phase(uvm_phase phase);

        covergroup router_fcov1;
                option.per_instance = 1;
                CHANNEL:        coverpoint mst_cov_data.header[1:0] {
                                                                        bins low = {2'b00};
                                                                        bins mid = {2'b01};
                                                                        bins hig = {2'b10};
                                                                    }
                PAYLOAD_SIZE:   coverpoint mst_cov_data.header[7:2] {
                                                                        bins small_pkt  = {[1:15]};
                                                                        bins medium_pkt = {[16:30]};
                                                                        bins big_pkt    = {[30:63]};
                                                                    }
                BAD_PKT:        coverpoint mst_cov_data.err         {   bins bad_pkt = {1};
                                                                    }
                CHANNEL_X_PAYLOAD_SIZE:                 cross CHANNEL,PAYLOAD_SIZE;
                CHANNEL_X_PAYLOAD_SIZE_X_BAD_PKT:       cross CHANNEL,PAYLOAD_SIZE,BAD_PKT;
        endgroup

        covergroup router_fcov2;
                option.per_instance = 1;
                CHANNEL:        coverpoint slv_cov_data.header[1:0] {
                                                                        bins low = {2'b00};
                                                                        bins mid = {2'b01};
                                                                        bins hig = {2'b10};
                                                                    }
                PAYLOAD_SIZE:   coverpoint slv_cov_data.header[7:2] {
                                                                        bins small_pkt  = {[1:15]};
                                                                        bins medium_pkt = {[16:30]};
                                                                        bins big_pkt    = {[30:63]};
                                                                    }
                CHANNEL_X_PAYLOAD_SIZE:                 cross CHANNEL,PAYLOAD_SIZE;
        endgroup

endclass

function router_score::new(string name = "router_score",uvm_component parent);
        super.new(name,parent);
        router_fcov1 = new();
        router_fcov2 = new();
endfunction

function void router_score::build_phase(uvm_phase phase);

        super.build_phase(phase);

        if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",env_cfg))
                `uvm_fatal("SCOREBOARD","cannot get() env_cfg from uvm_config_db. Have you set() it?")

        af_w = new("af_w", this);
        af_r = new[env_cfg.no_of_slaves];


        foreach(af_r[i])
                af_r[i] = new($sformatf("af_r[%0d]", i), this);
endfunction

task router_score::run_phase (uvm_phase phase);
        fork
                begin
                        forever
                                begin
                                        af_w.get(write_data);
                                                `uvm_info("MASTER SCOREBOARD", "Write data", UVM_LOW)
                                        write_data.print;
                                        mst_cov_data = write_data;
                                        router_fcov1.sample();
                                end
                end

                begin
                        forever
                                begin
                                        fork:slave_sb_fork
                                                begin
                                                        af_r[0].get(read_data);
                                                                `uvm_info("SLAVE[0] SCOREBOARD", "Read data", UVM_LOW)
                                                        read_data.print;
                                                        check_data(read_data);
                                                        slv_cov_data = read_data;
                                                        router_fcov2.sample();
                                                end
                                                begin
                                                        af_r[1].get(read_data);
                                                                `uvm_info("SLAVE[1] SCOREBOARD", "Read data", UVM_LOW)
                                                        read_data.print;
                                                        check_data(read_data);
                                                        slv_cov_data = read_data;
                                                        router_fcov2.sample();
                                                end
                                                begin
                                                        af_r[2].get(read_data);
                                                                `uvm_info("SLAVE[2] SCOREBOARD", "Read data", UVM_LOW)
                                                        read_data.print;
                                                        check_data(read_data);
                                                        slv_cov_data = read_data;
                                                        router_fcov2.sample();
                                                end
                                        join_any
                                        disable slave_sb_fork;
                                end
                end
        join
endtask

function void router_score::check_data(read_xtn sd);
        if (write_data.header == sd.header)
                `uvm_info ("SB"," HEADER MATCHED SUCCESSFULLY", UVM_MEDIUM)
        else
                `uvm_error ("SB"," HEADER COMPARISON FAILED")

        foreach(write_data.payload_data[i])
                begin
                        if (write_data.payload_data[i] == sd.payload_data[i])
                                `uvm_info ("SB",$sformatf("%0d - PAYLOAD DATA MATCHED SUCCESSFULLY", i), UVM_MEDIUM)
                        else
                                `uvm_error ("SB",$sformatf("%0d - PAYLOAD DATA COMPARISON FAILED", i))
                end

        this.sb_parity = 0 ^ sd.header;
        foreach (sd.payload_data[i])
                this.sb_parity = this.sb_parity ^ sd.payload_data[i];

        if ((write_data.parity == sb_parity) && (sd.parity == sb_parity))
                `uvm_info ("SB"," PARITY MATCHED SUCCESSFULLY - GOOD PACKET", UVM_MEDIUM)
        else
                `uvm_error ("SB"," PARITY COMPARISON FAILED - BAD PACKET")

        data_verified_count++;

endfunction

function void router_score::report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Report: SB verified %0d Data count",data_verified_count), UVM_LOW)
endfunction
