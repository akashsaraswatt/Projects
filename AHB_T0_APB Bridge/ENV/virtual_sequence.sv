class virtual_sequence extends uvm_sequence #(uvm_sequence_item);

        // factory registration
        `uvm_object_utils(virtual_sequence)
        // declare handles for ahb_wr_sequencer,apb_rd_sequencer and ahb2apb_virtual_sequencer
        // as wr_seqrh,rd_seqrh,vsqrh

        ahb_sequencer ahb_seqrh;
        apb_sequencer apb_seqrh;
        virtual_sequencer vsqrh;
	env_config cfg_h;

        // handles for all the sequences
	single_xtn single_ahb;
	ahb_wrap4_seq wrap4_ahb;
	ahb_wrap8_seq wrap8_ahb;
	ahb_wrap16_seq wrap16_ahb;
	ahb_incr4_seq incr4_ahb;
	ahb_incr8_seq incr8_ahb;
	ahb_incr16_seq incr16_ahb;
	single_xtn_read rsingle_ahb;
	ahb_wrap4_seq_read rwrap4_ahb;
	ahb_wrap8_seq_read rwrap8_ahb;
	ahb_wrap16_seq_read rwrap16_ahb;
	ahb_incr4_seq_read rincr4_ahb;
	ahb_incr8_seq_read rincr8_ahb;
	ahb_incr16_seq_read rincr16_ahb;
        unspecified_seq unspec_ahb;
	ahb_incr4_seq_rw rwincr4_ahb;
	ahb_incr16_seqib ibincr16_ahb;

	// standard UVM methods:
        extern function new(string name = "virtual_sequence");
       // extern task body();
endclass

//------------------------------ constructor new method ----------------------------------------------------------

function virtual_sequence::new(string name="virtual_sequence");
super.new(name);
endfunction

/*task virtual_sequence::body();
	if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",cfg_h))
		`uvm_fatal("CONFIG","Cannot get() env_config from uvm_config_db.Is it set?")
	assert($cast(vsqrh,m_sequencer))
	else
	begin
		`uvm_error("BODY","Error in $cast")
	end
	ahb_seqrh=vsqrh.ahb_seqrh;
	apb_seqrh=vsqrh.apb_seqrh;
endtask
*?
/*class request_vseq extends virtual_sequence;

	`uvm_object_utils(request_vseq)

	extern function new(string name="request_vseq");
	extern task body();
endclass

function request_vseq::new(string name="request_vseq");
	super.new(name);
endfunction

task request_vseq::body();
	super.body();
	
endtask	*/

/*class single_vseq extends virtual_sequence;

	`uvm_object_utils(single_vseq)

	extern function new(string name="single_vseq");
	extern task body();
endclass

function single_vseq::new(string name="single_vseq");
	super.new(name);
endfunction

task single_vseq::body();
	super.body();
	single_ahb=single_xtn::type_id::create("single_ahb");
	if(cfg_h.has_ahb_agt)
	begin
		single_ahb.start(ahb_seqrh);
	end
endtask

class ahb_incr4_vseq extends virtual_sequence;

	`uvm_object_utils(ahb_incr4_vseq)

	extern function new(string name="ahb_incr4_vseq");
	extern task body();
endclass

function ahb_incr4_vseq::new(string name="ahb_incr4_vseq");
	super.new(name);
endfunction

task ahb_incr4_vseq::body();
	super.body();
	incr4_ahb=ahb_incr4_seq::type_id::create("incr4_ahb");
	if(cfg_h.has_ahb_agt)
	begin
		incr4_ahb.start(ahb_seqrh);
	end
endtask


class unspecified_vseq extends virtual_sequence;

	`uvm_object_utils(unspecified_vseq)

	extern function new(string name="unspecified_vseq");
	extern task body();
endclass

function unspecified_vseq::new(string name="unspecified_vseq");
	super.new(name);
endfunction

task unspecified_vseq::body();
	super.body();
	unspec_ahb=unspecified_seq::type_id::create("unspec_ahb");
	if(cfg_h.has_ahb_agt)
	begin
		unspec_ahb.start(ahb_seqrh);
	end
endtask

class ahb_wrap4_vseq extends virtual_sequence;

	`uvm_object_utils(ahb_wrap4_vseq)

	extern function new(string name="ahb_wrap4_vseq");
	extern task body();
endclass

function ahb_wrap4_vseq::new(string name="ahb_wrap4_vseq");
	super.new(name);
endfunction

task ahb_wrap4_vseq::body();
	super.body();
	wrap4_ahb=ahb_wrap4_seq::type_id::create("wrap4_ahb");
	if(cfg_h.has_ahb_agt)
	begin
		wrap4_ahb.start(ahb_seqrh);
	end
endtask


class ahb_incr8_vseq extends virtual_sequence;

	`uvm_object_utils(ahb_incr8_vseq)

	extern function new(string name="ahb_incr8_vseq");
	extern task body();
endclass

function ahb_incr8_vseq::new(string name="ahb_incr8_vseq");
	super.new(name);
endfunction


task ahb_incr8_vseq::body();
	super.body();
	incr8_ahb=ahb_incr8_seq::type_id::create("incr8_ahb");
	if(cfg_h.has_ahb_agt)
	begin
		incr8_ahb.start(ahb_seqrh);
	end
endtask


class ahb_wrap8_vseq extends virtual_sequence;

	`uvm_object_utils(ahb_wrap8_vseq)

	extern function new(string name="ahb_wrap8_vseq");
	extern task body();
endclass

function ahb_wrap8_vseq::new(string name="ahb_wrap8_vseq");
	super.new(name);
endfunction


task ahb_wrap8_vseq::body();
	super.body();
	wrap8_ahb=ahb_wrap8_seq::type_id::create("wrap8_ahb");
	if(cfg_h.has_ahb_agt)
	begin
		wrap8_ahb.start(ahb_seqrh);
	end
endtask

class ahb_incr16_vseq extends virtual_sequence;
	`uvm_object_utils(ahb_incr16_vseq)

	extern function new(string name="ahb_incr16_vseq");
	extern task body();
endclass

function ahb_incr16_vseq::new(string name="ahb_incr16_vseq");
	super.new(name);
endfunction

task ahb_incr16_vseq::body();
	super.body();
	incr16_ahb=ahb_incr16_seq::type_id::create("incr16_ahb");
	if(cfg_h.has_ahb_agt)
	begin
		incr16_ahb.start(ahb_seqrh);
	end
endtask

class ahb_wrap16_vseq extends virtual_sequence;

	`uvm_object_utils(ahb_wrap16_vseq)

	extern function new(string name="ahb_wrap16_vseq");
	extern task body();
endclass

function ahb_wrap16_vseq::new(string name="ahb_wrap16_vseq");
	super.new(name);
endfunction

task ahb_wrap16_vseq::body();
	super.body();
	wrap16_ahb=ahb_wrap16_seq::type_id::create("wrap16_ahb");
	if(cfg_h.has_ahb_agt)
	begin
		wrap16_ahb.start(ahb_seqrh);
	end
endtask


class rsingle_vseq extends virtual_sequence;

	`uvm_object_utils(rsingle_vseq)

	extern function new(string name="rsingle_vseq");
	extern task body();
endclass

function rsingle_vseq::new(string name="rsingle_vseq");
	super.new(name);
endfunction

task rsingle_vseq::body();
	super.body();
	rsingle_ahb=single_xtn_read::type_id::create("rsingle_ahb");
	if(cfg_h.has_ahb_agt)
	begin
		rsingle_ahb.start(ahb_seqrh);
	end
endtask

class rahb_wrap4_vseq extends virtual_sequence;

	`uvm_object_utils(rahb_wrap4_vseq)

	extern function new(string name="rahb_wrap4_vseq");
	extern task body();
endclass

function rahb_wrap4_vseq::new(string name="rahb_wrap4_vseq");
	super.new(name);
endfunction

task rahb_wrap4_vseq::body();
	super.body();
	rwrap4_ahb=ahb_wrap4_seq_read::type_id::create("rwrap4_ahb");
	if(cfg_h.has_ahb_agt)
	begin
		rwrap4_ahb.start(ahb_seqrh);
	end
endtask

class rahb_incr4_vseq extends virtual_sequence;

	`uvm_object_utils(rahb_incr4_vseq)

	extern function new(string name="rahb_incr4_vseq");
	extern task body();
endclass

function rahb_incr4_vseq::new(string name="rahb_incr4_vseq");
	super.new(name);
endfunction

task rahb_incr4_vseq::body();
	super.body();
	rincr4_ahb=ahb_incr4_seq_read::type_id::create("rincr4_ahb");
	if(cfg_h.has_ahb_agt)
	begin
		rincr4_ahb.start(ahb_seqrh);
	end
endtask


class rahb_wrap8_vseq extends virtual_sequence;

	`uvm_object_utils(rahb_wrap8_vseq)

	extern function new(string name="rahb_wrap8_vseq");
	extern task body();
endclass

function rahb_wrap8_vseq::new(string name="rahb_wrap8_vseq");
	super.new(name);
endfunction

task rahb_wrap8_vseq::body();
	super.body();
	rwrap8_ahb=ahb_wrap8_seq_read::type_id::create("rwrap8_ahb");
	if(cfg_h.has_ahb_agt)
	begin
		rwrap8_ahb.start(ahb_seqrh);
	end
endtask


class rahb_incr8_vseq extends virtual_sequence;

	`uvm_object_utils(rahb_incr8_vseq)

	extern function new(string name="rahb_incr8_vseq");
	extern task body();
endclass

function rahb_incr8_vseq::new(string name="rahb_incr8_vseq");
	super.new(name);
endfunction

task rahb_incr8_vseq::body();
	super.body();
	rincr8_ahb=ahb_incr8_seq_read::type_id::create("rincr8_ahb");
	if(cfg_h.has_ahb_agt)
	begin
		rincr8_ahb.start(ahb_seqrh);
	end
endtask


class rahb_wrap16_vseq extends virtual_sequence;

	`uvm_object_utils(rahb_wrap16_vseq)

	extern function new(string name="rahb_wrap16_vseq");
	extern task body();
endclass

function rahb_wrap16_vseq::new(string name="rahb_wrap16_vseq");
	super.new(name);
endfunction

task rahb_wrap16_vseq::body();
	super.body();
	rwrap16_ahb=ahb_wrap16_seq_read::type_id::create("rwrap16_ahb");
	if(cfg_h.has_ahb_agt)
	begin
		rwrap16_ahb.start(ahb_seqrh);
	end
endtask


class rahb_incr16_vseq extends virtual_sequence;

	`uvm_object_utils(rahb_incr16_vseq)

	extern function new(string name="rahb_incr16_vseq");
	extern task body();
endclass

function rahb_incr16_vseq::new(string name="rahb_incr16_vseq");
	super.new(name);
endfunction

task rahb_incr16_vseq::body();
	super.body();
	rincr16_ahb=ahb_incr16_seq_read::type_id::create("rincr16_ahb");
	if(cfg_h.has_ahb_agt)
	begin
		rincr16_ahb.start(ahb_seqrh);
	end
endtask


class rwahb_incr4_vseq extends virtual_sequence;

        `uvm_object_utils(rwahb_incr4_vseq)

        extern function new(string name="rwahb_incr4_vseq");
        extern task body();
endclass

function rwahb_incr4_vseq::new(string name="rwahb_incr4_vseq");
        super.new(name);
endfunction

task rwahb_incr4_vseq::body();
        super.body();
        rwincr4_ahb=ahb_incr4_seq_rw::type_id::create("rwincr4_ahb");
        if(cfg_h.has_ahb_agt)
        begin
                rwincr4_ahb.start(ahb_seqrh);
        end
endtask

class ibahb_incr16_vseq extends virtual_sequence;

        `uvm_object_utils(ibahb_incr16_vseq)

        extern function new(string name="ibahb_incr16_vseq");
        extern task body();
endclass

function ibahb_incr16_vseq::new(string name="ibahb_incr16_vseq");
        super.new(name);
endfunction

task ibahb_incr16_vseq::body();
        super.body();
        ibincr16_ahb=ahb_incr16_seqib::type_id::create("ibincr16_ahb");
        if(cfg_h.has_ahb_agt)
        begin
                ibincr16_ahb.start(ahb_seqrh);
        end
endtask
*/

