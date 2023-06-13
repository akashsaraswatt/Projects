class ahb_xtn extends uvm_sequence_item;

	`uvm_object_utils(ahb_xtn)
	
	rand bit [1:0] HTRANS;
	rand bit HWRITE;
	rand bit HREADYin;
	rand bit [31:0] HADDR;
	rand bit [2:0] HBURST;
	rand bit [31:0] HWDATA;
	rand bit [2:0] HSIZE;
	rand bit [31:0] HRDATA;
	rand bit [2:0] HRESP;
        rand bit [9:0] length ;
        constraint address {HADDR inside {[32'h8000_0000:32'h8000_03ff],[32'h8400_0000:32'h8400_03ff],[32'h8800_0000:32'h8800_03ff],[32'h8c00_0000:32'h8c00_03ff]};}

//	constraint address {HADDR inside {[32'h8000_0000:32'h8C00_0000]};}
	constraint hsize {HSIZE inside {[0:2]};}
	//constraint hwrite {HWRITE == 1'b1;}
	constraint hreadyin {HREADYin == 1'b1;}	
         constraint ADDR { (HSIZE == 1) -> HADDR%2 == 0 ;
			(HSIZE ==2 ) -> HADDR % 4 == 0 ;}
	 constraint valid_legth{(2^HSIZE)*length<=1024;}

	extern function new(string name="ahb_xtn");
	extern function void do_print(uvm_printer printer);

endclass

function ahb_xtn::new(string name="ahb_xtn");
	super.new(name);
endfunction

function void ahb_xtn::do_print(uvm_printer printer);
	super.do_print(printer);
	
	printer.print_field("HWRITE",       this.HWRITE,        1,        UVM_HEX);
	printer.print_field("HADDR",        this.HADDR,        32,        UVM_HEX);
	printer.print_field("HWDATA",       this.HWDATA,       32,        UVM_HEX);
	printer.print_field("HBURST",       this.HBURST,        3,        UVM_HEX);
	printer.print_field("HSIZE",        this.HSIZE,         3,        UVM_HEX);
	printer.print_field("HTRANS",       this.HTRANS,        2,        UVM_HEX);
	printer.print_field("HRDATA",       this.HRDATA,       32,        UVM_HEX);

endfunction


class trans_ext extends ahb_xtn;
constraint address {HADDR inside {[32'h8000_0000:32'h8000_03ff]};}

extern function new(string name = "trans_ext");
endclass

function trans_ext::new(string name="trans_ext");
	super.new(name);
endfunction
