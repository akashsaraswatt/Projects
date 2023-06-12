class router_rbase_seq extends uvm_sequence #(read_xtn);

`uvm_object_utils(router_rbase_seq)

extern function new(string name = "router_rbase_seq");


endclass : router_rbase_seq

//---------------------constructor--------------------------//
function router_rbase_seq::new(string name = "router_rbase_seq");
        super.new(name);
endfunction

class router_rd_seq  extends router_rbase_seq;
`uvm_object_utils(router_rd_seq);
extern function new(string name="R_SEQ");
extern task body;
endclass:router_rd_seq

function router_rd_seq::new(string name="R_SEQ");
        super.new(name);
endfunction


task router_rd_seq::body;
        req=read_xtn::type_id::create("REQ");
        start_item(req);
        assert(req.randomize () with {no_of_cycles inside {[1:28]};});
`uvm_info("router_rd_sequence",$sformatf("printing from sequence \n %s",req.sprint()),UVM_HIGH)
        finish_item(req);
`uvm_info(get_type_name(),"after finish item inside sequence",UVM_HIGH)
endtask

class router_rd_seq1  extends router_rbase_seq;
`uvm_object_utils(router_rd_seq1);
extern function new(string name="R_SEQ");
extern task body;
endclass:router_rd_seq1

function router_rd_seq1::new(string name="R_SEQ");
        super.new(name);
endfunction


task router_rd_seq1::body;
        req=read_xtn::type_id::create("REQ");
        start_item(req);
        assert(req.randomize () with {no_of_cycles inside {[35:40]};});
                `uvm_info("router_rd_sequence",$sformatf("printing from sequence \n %s",req.sprint()),UVM_HIGH)
        finish_item(req);
                `uvm_info(get_type_name(),"after finish item inside sequence",UVM_HIGH)
endtask
