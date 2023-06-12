class router_wbase_seq extends uvm_sequence #(write_xtn);

`uvm_object_utils(router_wbase_seq)

extern function new(string name = "router_wbase_seq");

endclass : router_wbase_seq

//---------------------constructor--------------------------//
function router_wbase_seq::new(string name = "router_wbase_seq");
        super.new(name);
endfunction

class router_wr_seq_small extends router_wbase_seq;
`uvm_object_utils(router_wr_seq_small);
bit[1:0]addr;
extern function new(string name="router_wr_seq_small");
extern task body;
endclass

function router_wr_seq_small::new(string name ="router_wr_seq_small");
        super.new(name);
endfunction

task router_wr_seq_small::body;
if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
      `uvm_fatal(get_type_name(),"getting the configuration faile, check if it set properly")

        req=write_xtn::type_id::create("W_REQ");
        start_item(req);
        assert(req.randomize with {header[7:2] inside {[1:15]} && header[1:0]==addr;});
`uvm_info("router_wr_sequence",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
        finish_item(req);
endtask

class router_wr_seq_medium extends router_wbase_seq;
`uvm_object_utils(router_wr_seq_medium);
bit[1:0]addr;
extern function new(string name="W_SEQ_MEDIUM");
extern task body;
endclass

function router_wr_seq_medium::new(string name ="W_SEQ_MEDIUM");
        super.new(name);
endfunction

task router_wr_seq_medium::body;
if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
      `uvm_fatal(get_type_name(),"getting the configuration faile, check if it set properly")

        req=write_xtn::type_id::create("W_REQ");
        start_item(req);
        assert(req.randomize with {header[7:2] inside {[16:30]} && header[1:0]==addr;});
`uvm_info("router_wr_sequence",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
        finish_item(req);
endtask


class router_wr_seq_large extends router_wbase_seq;
`uvm_object_utils(router_wr_seq_large);
bit[1:0]addr;
extern function new(string name="W_SEQ_LARGE");
extern task body;
endclass

function router_wr_seq_large::new(string name ="W_SEQ_LARGE");
        super.new(name);
endfunction

task router_wr_seq_large::body;
if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
      `uvm_fatal(get_type_name(),"getting the configuration faile, check if it set properly")


        req=write_xtn::type_id::create("W_REQ");
        start_item(req);
        assert(req.randomize with {header[7:2] inside {[31:63]} && header[1:0]==addr;});
`uvm_info("router_wr_sequence",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
        finish_item(req);
endtask


class router_wr_seq_rand extends router_wbase_seq;
`uvm_object_utils(router_wr_seq_rand);
bit[1:0]addr;
extern function new(string name="W_SEQ_RAND");
extern task body;
endclass

function router_wr_seq_rand::new(string name ="W_SEQ_RAND");
        super.new(name);
endfunction

task router_wr_seq_rand::body;
if(!uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
      `uvm_fatal(get_type_name(),"getting the configuration faile, check if it set properly")


        req=write_xtn::type_id::create("W_REQ");
        start_item(req);
        assert(req.randomize() with {header[1:0]==addr;});
`uvm_info("router_wr_sequence",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
        finish_item(req);
endtask
