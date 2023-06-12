class router_virtual_sequence extends uvm_sequence#(uvm_sequence_item);
        `uvm_object_utils(router_virtual_sequence)
        router_virtual_sequencer v_seqr;
        wr_sequencer w_seqr[];
        rd_sequencer r_seqr[];
        router_env_config cfg;

        extern function new(string name="router_virtual_sequence");
        extern task body;
endclass

function router_virtual_sequence::new(string name="router_virtual_sequence");
        super.new(name);
endfunction

task router_virtual_sequence::body;
        if(!uvm_config_db#(router_env_config) ::get(null,get_full_name(),"router_env_config",cfg))
                `uvm_fatal("V_SEQ","cannot get cfg");

        w_seqr=new[cfg.no_of_masters];
        r_seqr=new[cfg.no_of_slaves];

        assert ($cast(v_seqr,m_sequencer))
        else
        begin
                `uvm_error("BODY", "Error in $cast of virtual sequencer")
        end
        foreach(w_seqr[i])
                w_seqr[i]=v_seqr.w_seqr[i];

        foreach(r_seqr[i])
                r_seqr[i]=v_seqr.r_seqr[i];
endtask

class router_virtual_sequence_small extends router_virtual_sequence;
`uvm_object_utils(router_virtual_sequence_small)
bit[1:0] addr;
router_wr_seq_small w_seq;
router_rd_seq r_seq;

extern function new(string name="router_virtual_sequence_small");
extern task body;

endclass

function router_virtual_sequence_small::new(string name="router_virtual_sequence_small");
        super.new(name);
endfunction

task router_virtual_sequence_small::body;
        super.body;
if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
        `uvm_fatal(get_type_name(),"getting configuration is failed.Have you set() it?")
if(cfg.has_wagent)
        w_seq=router_wr_seq_small::type_id::create("W_SEQ");
if(cfg.has_ragent)
        r_seq=router_rd_seq::type_id::create("R_SEQ");

        fork
                begin
                w_seq.start(w_seqr[0]);
                end
                begin
                        if(addr == 2'b00)
                                r_seq.start(r_seqr[0]);
                        if(addr == 2'b01)
                                r_seq.start(r_seqr[1]);
                        if(addr == 2'b10)
                                r_seq.start(r_seqr[2]);
                end
        join
endtask


class router_virtual_sequence_medium extends router_virtual_sequence;
`uvm_object_utils(router_virtual_sequence_medium)
bit[1:0] addr;
router_wr_seq_medium w_seq;
router_rd_seq r_seq;

extern function new(string name="V_SEQ_MEDIUM");
extern task body;

endclass

function router_virtual_sequence_medium::new(string name="V_SEQ_MEDIUM");
        super.new(name);
endfunction

task router_virtual_sequence_medium::body;
        super.body;
if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
        `uvm_fatal(get_type_name(),"getting configuration is failed.Have you set() it?")
if(cfg.has_wagent)
        w_seq=router_wr_seq_medium::type_id::create("W_SEQ");
if(cfg.has_ragent)
        r_seq=router_rd_seq::type_id::create("R_SEQ");

        fork
                begin
                w_seq.start(w_seqr[0]);
                end
                begin
                        if(addr == 2'b00)
                                r_seq.start(r_seqr[0]);
                        if(addr == 2'b01)
                                r_seq.start(r_seqr[1]);
                        if(addr == 2'b10)
                                r_seq.start(r_seqr[2]);
                end
        join
endtask


class router_virtual_sequence_large extends router_virtual_sequence;
`uvm_object_utils(router_virtual_sequence_large)
bit[1:0] addr;
router_wr_seq_large w_seq;
router_rd_seq r_seq;

extern function new(string name="V_SEQ_LARGE");
extern task body;

endclass

function router_virtual_sequence_large::new(string name="V_SEQ_LARGE");
        super.new(name);
endfunction

task router_virtual_sequence_large::body;
        super.body;
if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
        `uvm_fatal(get_type_name(),"getting configuration is failed.Have you set() it?")
if(cfg.has_wagent)
        w_seq=router_wr_seq_large::type_id::create("W_SEQ");
if(cfg.has_ragent)
        r_seq=router_rd_seq::type_id::create("R_SEQ");

        fork
                begin
                w_seq.start(w_seqr[0]);
                end
                begin
                        if(addr == 2'b00)
                                r_seq.start(r_seqr[0]);
                        if(addr == 2'b01)
                                r_seq.start(r_seqr[1]);
                        if(addr == 2'b10)
                                r_seq.start(r_seqr[2]);
                end
        join
endtask


class router_virtual_sequence_rand extends router_virtual_sequence;
`uvm_object_utils(router_virtual_sequence_rand)
bit[1:0] addr;
router_wr_seq_rand w_seq;
router_rd_seq r_seq;

extern function new(string name="V_SEQ_RAND");
extern task body;

endclass

function router_virtual_sequence_rand::new(string name="V_SEQ_RAND");
        super.new(name);
endfunction

task router_virtual_sequence_rand::body;
        super.body;
if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
        `uvm_fatal(get_type_name(),"getting configuration is failed.Have you set() it?")
if(cfg.has_wagent)
        w_seq=router_wr_seq_rand::type_id::create("W_SEQ");
if(cfg.has_ragent)
        r_seq=router_rd_seq::type_id::create("R_SEQ");

        fork
                begin
                w_seq.start(w_seqr[0]);
                end
                begin
                        if(addr == 2'b00)
                                r_seq.start(r_seqr[0]);
                        if(addr == 2'b01)
                                r_seq.start(r_seqr[1]);
                        if(addr == 2'b10)
                                r_seq.start(r_seqr[2]);
                end
        join
endtask

class router_time_out_pkt_vseq  extends router_virtual_sequence;
`uvm_object_utils(router_time_out_pkt_vseq);
bit[1:0]addr;
router_wr_seq_rand wxtns;
router_rd_seq1 rxtns;
extern function new(string name="router_time_out_pkt_vseq");
extern task body;

endclass

function router_time_out_pkt_vseq::new(string name="router_time_out_pkt_vseq");
        super.new(name);
endfunction


task router_time_out_pkt_vseq::body;
        super.body;
       if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
        `uvm_fatal(get_type_name(),"getting configuration is failed,check if it set properly")

        if(cfg.has_wagent)
                begin
                wxtns=router_wr_seq_rand::type_id::create("wxtns");
                end
        if(cfg.has_ragent)
                begin
                rxtns=router_rd_seq1::type_id::create("rxtns[%0d]");
                end

fork
                begin

                        wxtns.start(w_seqr[0]);
                end
                begin
                        if(addr == 2'b00)
                                rxtns.start(r_seqr[0]);
                        if(addr == 2'b01)
                                rxtns.start(r_seqr[1]);
                        if(addr == 2'b10)
                                rxtns.start(r_seqr[2]);
                end
join
endtask

class router_bad_pkt_vseq extends router_virtual_sequence;

router_wr_seq_rand rand_wxtns;
router_rd_seq rxtns;

`uvm_object_utils(router_bad_pkt_vseq)
bit[1:0] addr;

extern function new(string name ="router_bad_pkt_vseq");
extern task body();
endclass

function router_bad_pkt_vseq::new(string name ="router_bad_pkt_vseq");
        super.new(name);
endfunction

task router_bad_pkt_vseq::body();
        super.body();
        if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
        `uvm_fatal(get_type_name(),"getting configuration is failed.Have you set() it?")

        if(cfg.has_wagent)
                begin
                rand_wxtns=router_wr_seq_rand::type_id::create("rand_wxtns");
                end
        if(cfg.has_ragent)
                begin
                rxtns=router_rd_seq::type_id::create("rxtns");
                end

        fork
                begin
                        rand_wxtns.start(w_seqr[0]);
                end

                begin
                        if(addr == 2'b00)
                                rxtns.start(r_seqr[0]);
                        if(addr == 2'b01)
                                rxtns.start(r_seqr[1]);
                        if(addr == 2'b10)
                                rxtns.start(r_seqr[2]);
                end
        join

endtask
