class router_base_test extends uvm_test;

        `uvm_component_utils(router_base_test)

    router_env router_envh;
    router_env_config m_tb_cfg;
    wr_agent_config m_wr_cfg[];
    rd_agent_config m_rd_cfg[];


    int no_of_slaves = 3;
        int no_of_masters =1;
    bit has_ragent = 1;
    bit has_wagent = 1;

        extern function new(string name = "router_base_test" , uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void config_router();
endclass

function router_base_test::new(string name = "router_base_test" , uvm_component parent);
        super.new(name,parent);
endfunction


function void router_base_test::config_router();
    if (has_wagent)
        begin
                        m_wr_cfg = new[no_of_masters];

            foreach(m_wr_cfg[i])
                                begin
                    m_wr_cfg[i]=wr_agent_config::type_id::create($sformatf("m_wr_cfg[%0d]", i));
                    if(!uvm_config_db #(virtual router_if)::get(this,"", "vif",m_wr_cfg[i].vif))
                                                `uvm_fatal("VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?")

                                                m_wr_cfg[i].is_active = UVM_ACTIVE;

                        m_tb_cfg.w_cfg[i] = m_wr_cfg[i];
                end
        end


    if (has_ragent)
        begin
            m_rd_cfg = new[no_of_slaves];

            foreach(m_rd_cfg[i])
                begin
                    m_rd_cfg[i]=rd_agent_config::type_id::create($sformatf("m_rd_cfg[%0d]", i));
                    if(!uvm_config_db #(virtual router_if)::get(this,"", $sformatf("vif[%0d]",i),m_rd_cfg[i].vif))
                        `uvm_fatal("VIF CONFIG","cannot get()interface vif from uvm_config_db. Have you set() it?")

                                        m_rd_cfg[i].is_active = UVM_ACTIVE;
                    m_tb_cfg.r_cfg[i] = m_rd_cfg[i];
                end
        end

    m_tb_cfg.no_of_masters = no_of_masters;
        m_tb_cfg.no_of_slaves = no_of_slaves;
    m_tb_cfg.has_ragent = has_ragent;
    m_tb_cfg.has_wagent = has_wagent;

    m_tb_cfg.has_scoreboard= 1;

endfunction : config_router


function void router_base_test::build_phase(uvm_phase phase);

    m_tb_cfg=router_env_config::type_id::create("m_tb_cfg");
    if(has_wagent)
        m_tb_cfg.w_cfg = new[no_of_masters];

        if(has_ragent)
        m_tb_cfg.r_cfg = new[no_of_slaves];

    config_router;
    uvm_config_db #(router_env_config)::set(this,"*","router_env_config",m_tb_cfg);

    super.build_phase(phase);
        router_envh=router_env::type_id::create("router_envh", this);
endfunction


class router_test_small extends router_base_test;

        `uvm_component_utils(router_test_small)
        bit[1:0] addr;
        router_virtual_sequence_small v_seq;

        extern function new(string name="router_test_small",uvm_component parent);
        extern function void build_phase(uvm_phase);
        extern task run_phase(uvm_phase);

endclass

function router_test_small:: new(string name="router_test_small",uvm_component parent);
        super.new(name,parent);
endfunction

function void router_test_small::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

task router_test_small::run_phase(uvm_phase phase);
       repeat(25)
        begin
        addr={$random}%3;
        uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);
        phase.raise_objection(this);
                        v_seq=router_virtual_sequence_small::type_id::create("V_SEQ");
                        v_seq.start(router_envh.v_seqr);
        phase.drop_objection(this);

                end
endtask

class router_test_medium extends router_base_test;
`uvm_component_utils(router_test_medium)
bit[1:0] addr;
router_virtual_sequence_medium v_seq;

extern function new(string name="TEST",uvm_component parent);
extern function void build_phase(uvm_phase);
extern task run_phase(uvm_phase);

endclass

function router_test_medium:: new(string name="TEST",uvm_component parent);
        super.new(name,parent);
endfunction

function void router_test_medium::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

task router_test_medium::run_phase(uvm_phase phase);
       repeat(25)
        begin
        addr={$random}%3;
        uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);
        phase.raise_objection(this);
                        v_seq=router_virtual_sequence_medium::type_id::create("V_SEQ");
                        v_seq.start(router_envh.v_seqr);
        phase.drop_objection(this);

                end
endtask


class router_test_large extends router_base_test;
`uvm_component_utils(router_test_large)
bit[1:0] addr;
router_virtual_sequence_large v_seq;

extern function new(string name="TEST",uvm_component parent);
extern function void build_phase(uvm_phase);
extern task run_phase(uvm_phase);

endclass

function router_test_large:: new(string name="TEST",uvm_component parent);
        super.new(name,parent);
endfunction

function void router_test_large::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

task router_test_large::run_phase(uvm_phase phase);
       repeat(25)
        begin
        addr={$random}%3;
        uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);
        phase.raise_objection(this);
                        v_seq=router_virtual_sequence_large::type_id::create("V_SEQ");
                        v_seq.start(router_envh.v_seqr);
        phase.drop_objection(this);

                end
endtask


class router_test_rand extends router_base_test;
`uvm_component_utils(router_test_rand)
bit[1:0] addr;
router_virtual_sequence_rand v_seq;

extern function new(string name="TEST",uvm_component parent);
extern function void build_phase(uvm_phase);
extern task run_phase(uvm_phase);

endclass

function router_test_rand:: new(string name="TEST",uvm_component parent);
        super.new(name,parent);
endfunction

function void router_test_rand::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

task router_test_rand::run_phase(uvm_phase phase);
       repeat(25)
        begin
        addr={$random}%3;
        uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);
        phase.raise_objection(this);
                        v_seq=router_virtual_sequence_rand::type_id::create("V_SEQ");
                        v_seq.start(router_envh.v_seqr);
        phase.drop_objection(this);

                end
endtask

class router_time_out_pkt_test extends router_base_test;
`uvm_component_utils(router_time_out_pkt_test)
router_time_out_pkt_vseq  router_timeout;
bit[1:0] addr;
extern function new(string name="router_time_out_pkt_test",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

function router_time_out_pkt_test:: new(string name="router_time_out_pkt_test",uvm_component parent);
        super.new(name,parent);
endfunction

function void router_time_out_pkt_test::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

task router_time_out_pkt_test::run_phase(uvm_phase phase);
                repeat(5)
                begin
                addr={$random}%3;
                uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);
                phase.raise_objection(this);
                        router_timeout=router_time_out_pkt_vseq::type_id::create("router_timeout");
                        router_timeout.start(router_envh.v_seqr);
                phase.drop_objection(this);
end
endtask

class router_bad_pkt_test extends router_base_test;

        `uvm_component_utils(router_bad_pkt_test)
        router_bad_pkt_vseq router_sequ;
        bit[1:0] addr;

        extern function new(string name="router_bad_pkt_test",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);

endclass

function router_bad_pkt_test::new(string name="router_bad_pkt_test",uvm_component parent);
                super.new(name,parent);
endfunction

function void router_bad_pkt_test::build_phase(uvm_phase phase);
        set_type_override_by_type(write_xtn::get_type(),bad_xtn::get_type());
                super.build_phase(phase);
endfunction

task router_bad_pkt_test::run_phase(uvm_phase phase);
        repeat(64)
                begin
                        addr={$random}%3;
                        uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);
                        phase.raise_objection(this);
                                router_sequ=router_bad_pkt_vseq::type_id::create("router_sequ");
                                router_sequ.start(router_envh.v_seqr);
                        phase.drop_objection(this);
                end
endtask
