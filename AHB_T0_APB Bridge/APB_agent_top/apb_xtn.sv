class apb_xtn extends uvm_sequence_item;

	`uvm_object_utils(apb_xtn)
	
	bit [3:0] pselx;
	bit [31:0] prdata;
	bit [31:0] pwdata;
	bit penable;
	bit pwrite;
	bit [31:0] paddr;
	
	extern function new(string name="apb_xtn");
	extern function void do_print(uvm_printer printer);		

endclass

function apb_xtn::new(string name="apb_xtn");
	super.new(name);
endfunction


function void apb_xtn::do_print(uvm_printer printer);
	super.do_print(printer);

	printer.print_field("pselx",      this.pselx,       1,       UVM_HEX);
	printer.print_field("pwrite",     this.pwrite,      1,       UVM_HEX);
	printer.print_field("penable",    this.penable,     1,       UVM_HEX);
	printer.print_field("paddr",      this.paddr,       32,      UVM_HEX);
	printer.print_field("pwdata",     this.pwdata,      32,      UVM_HEX);
	printer.print_field("prdata",     this.prdata,      32,      UVM_HEX);

endfunction
