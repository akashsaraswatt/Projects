module top;

        bit clock;
        always #5 clock=~clock;

        import router_test_pkg::*;
        import uvm_pkg::*;

        router_if in(clock);
        router_if in0(clock);
        router_if in1(clock);
        router_if in2(clock);

        router_top DUV(.datain(in.data_in),.packet_valid(in.pkt_valid),.clk(clock),.resetn(in.resetn),.err(in.err),.busy(in.busy),
                        .read_enb_0(in0.read_enb),.data_out_0(in0.data_out),.vld_out_0(in0.vld_out),
                        .read_enb_1(in1.read_enb),.data_out_1(in1.data_out),.vld_out_1(in1.vld_out),
                        .read_enb_2(in2.read_enb),.data_out_2(in2.data_out),.vld_out_2(in2.vld_out));


        initial
        begin
                uvm_config_db#(virtual router_if) ::set(null,"*","vif",in);
                uvm_config_db#(virtual router_if) ::set(null,"*","vif[0]",in0);
                uvm_config_db#(virtual router_if) ::set(null,"*","vif[1]",in1);
                uvm_config_db#(virtual router_if) ::set(null,"*","vif[2]",in2);
                run_test();
        end
endmodule
