interface router_if(input bit clk);

logic [7:0 ]data_in;
logic pkt_valid;
logic resetn;
logic err,busy;
logic read_enb;
logic [7:0] data_out;
logic vld_out;

clocking wdr_cb@(posedge clk);
default input#1 output  #1;
        input busy;
        input err;
        output pkt_valid;
        output  data_in;
        output resetn;
endclocking

clocking rdr_cb@(posedge clk);
default input#1 output  #1;
        input vld_out;
        output read_enb;
endclocking

clocking wmon_cb@(posedge clk);
default input#1 output  #1;
        input pkt_valid;
        input  data_in;
        input resetn;
        input busy;
        input err;
endclocking

clocking rmon_cb@(posedge clk);
default input#1 output  #1;
        input data_out;
        input read_enb;
        input vld_out;
endclocking

modport WDR_MP(clocking wdr_cb);
modport WMON_MP(clocking wmon_cb);
modport RMON_MP(clocking rmon_cb);
modport RDR_MP(clocking rdr_cb);

endinterface
