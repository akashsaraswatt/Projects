class write_xtn extends uvm_sequence_item;

`uvm_object_utils(write_xtn);

rand bit[7:0]header;
rand bit[7:0]payload_data[];
bit [7:0] parity;
bit err;

constraint C1{payload_data.size ==header[7:2];}
constraint C2{header[1:0]!=3;}
constraint C3{header[7:2]!=0;}

extern function new(string name = "write_xtn");
extern function void do_copy(uvm_object rhs);
extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
extern function void do_print(uvm_printer printer);
extern function void post_randomize();
endclass:write_xtn


        function write_xtn::new(string name = "write_xtn");
                super.new(name);
        endfunction:new

  function void write_xtn::do_copy (uvm_object rhs);
    write_xtn rhs_;

    if(!$cast(rhs_,rhs)) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
    end
    super.do_copy(rhs);
    header= rhs_.header;
    foreach(payload_data[i])
        payload_data[i]= rhs_.payload_data[i];
    parity= rhs_.parity;

  endfunction:do_copy

  function bit  write_xtn::do_compare (uvm_object rhs,uvm_comparer comparer);
    write_xtn rhs_;

    if(!$cast(rhs_,rhs)) begin
    `uvm_fatal("do_compare","cast of the rhs object failed")
    return 0;
    end

    return super.do_compare(rhs,comparer) &&
    header== rhs_.header &&
    parity== rhs_.parity;

 endfunction:do_compare


   function void  write_xtn::do_print (uvm_printer printer);
      super.do_print(printer);
      printer.print_field( "header",this.header,8,UVM_BIN);
      foreach(payload_data[i])
      printer.print_field( $sformatf("payload_data[%0d]",i), this.payload_data[i],8,UVM_DEC);
      printer.print_field( "parity",this.parity,8,UVM_DEC);

      endfunction:do_print

function void write_xtn::post_randomize();
        parity= 0^header;
        foreach(payload_data[i])
                begin
                parity=payload_data[i]^parity;
                end
endfunction


class bad_xtn extends write_xtn;

`uvm_object_utils(bad_xtn)
typedef enum bit  {BAD_XTN,GOOD_XTN} xtn_type;

rand xtn_type trans_type;

extern function new(string name="bad_xtn");
extern function void post_randomize();
extern function void do_print(uvm_printer printer);

endclass

function bad_xtn::new(string name="bad_xtn");
        super.new(name);
endfunction

function void bad_xtn::post_randomize();
        parity = $random;
endfunction

function void bad_xtn::do_print(uvm_printer printer);
        super.do_print(printer);
//              string name             bitstream value         size    radix for printing

printer.print_generic("trans_type",             "xtns_type",    $bits(trans_type),      trans_type.name);
endfunction
