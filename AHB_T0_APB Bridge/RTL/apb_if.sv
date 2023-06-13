interface apb_if (input bit clock);
logic [3:0] pselx;
logic penable;
logic pwrite;
logic [31:0]prdata;
logic [31:0]pwdata;
logic [31:0]paddr;

clocking apb_drv_cb @(posedge clock);
	default input #1 output #1;
	input penable;
	input pwrite;
	input paddr;
	input pwdata;
	output prdata;
	input pselx;
endclocking

clocking apb_mon_cb @(posedge clock);
	default input #1 output #1;
	input penable;
	input pwrite;
	input paddr;
	input pwdata;
	input pselx;
	input prdata;
endclocking

modport DR_MP(clocking apb_drv_cb);
modport MON_MP(clocking apb_mon_cb);

endinterface

