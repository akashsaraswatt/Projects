class ahb_base_seq extends uvm_sequence #(ahb_xtn);
        //factory registration
        `uvm_object_utils(ahb_base_seq)
        
	bit [31:0]ha;
	bit [2:0] hb;
	bit [2:0] hs;
	bit hw;
	// standard UVM methods
extern function new(string name = "ahb_base_seq");

endclass

//-------------------------------------------------- constructor new method--------------------------------
/*function ahb_base_seq ::new(string name = "ahb_base_seq");
        super.new(name);
endfunction

class single_xtn extends ahb_base_seq;
	`uvm_object_utils(single_xtn)

	extern function new(string name = "single_xtn");
	extern task body();

endclass

function single_xtn::new(string name = "single_xtn");
	super.new(name);
endfunction

task single_xtn::body();
begin
	req=ahb_xtn::type_id::create("req");
	start_item(req);
	//assert(req.randomize() with {HWRITE==1;HBURST==0;HSIZE==0;HTRANS==2;});
	assert(req.randomize() with {HWRITE==1;HADDR[0]!=0;HSIZE==0;HTRANS==2;});
	finish_item(req);

	start_item(req);
	assert(req.randomize()with {HWRITE==1;HTRANS==2'b00;HSIZE==3'b010;HBURST==3'd0;})
	finish_item(req);
end
endtask
//-------------------------------------------------------------------------------------------------

class ahb_wrap4_seq extends ahb_base_seq;//wrap4 and incr4

	`uvm_object_utils(ahb_wrap4_seq)
	
	extern function new(string name="ahb_wrap4_seq");
	extern task body();
endclass

function ahb_wrap4_seq::new(string name="ahb_wrap4_seq");
	super.new(name);
endfunction

task ahb_wrap4_seq::body();
bit [31:0] ha;
bit [2:0] hb;
bit [2:0] hs;
bit hw;

begin
	req=ahb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {HREADYin==1;HWRITE==1;HTRANS==2'b10;HBURST==3'b010;})
	finish_item(req);
      $display("***********************FROM NON_SEQUENTIAL TRANSFER ****************");
	ha=req.HADDR;
	hs=req.HSIZE;
	hb=req.HBURST;
	repeat(3)	
	begin	
		start_item(req);
		if(hs==0)
                   begin
			assert(req.randomize() with {HREADYin==1;HWRITE==1;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR=={ha[31:2],ha[1:0]+1'b1};})
 $display("***********display inside hsize =0 ***************");
   end
		if(hs==1)
         begin
			assert(req.randomize() with {HREADYin==1;HWRITE==1;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR=={ha[31:3],ha[2:1]+1'b1,ha[0]};})
$display("***********display inside hsize =1 ***************");	
end
	if(hs==2)
begin 
			assert(req.randomize() with {HREADYin==1;HWRITE==1;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR=={ha[31:4],ha[3:2]+1'b1,ha[1:0]};})
$display("***********display inside hsize =2 ***************");
end
		finish_item(req);
	$display("**************************************FROM SEQUENTIAL TRANSFER *********************");
	ha=req.HADDR;
	hs=req.HSIZE;
	end

	start_item(req);
	assert(req.randomize() with {HREADYin==1;HWRITE==1;HTRANS==0;})
	finish_item(req);
	
end
endtask

	
class ahb_incr4_seq extends ahb_base_seq;

	`uvm_object_utils(ahb_incr4_seq)
	
	extern function new(string name="ahb_incr4_seq");
	extern task body();
endclass

function ahb_incr4_seq::new(string name="ahb_incr4_seq");
	super.new(name);
endfunction

task ahb_incr4_seq::body();
bit [31:0] ha;
bit [2:0] hb;
bit [2:0] hs;
bit hw;

begin
	req=ahb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {HWRITE==1;HTRANS==2'b10;HBURST==3'b011;})
	finish_item(req);
	 $display("***********************FROM NON_SEQUENTIAL TRANSFER ****************");
	ha=req.HADDR;
	hs=req.HSIZE;
	hb=req.HBURST;
	
	repeat(3)
	begin	
		start_item(req);
		if(hs==0)
		begin
			assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR==(ha+1'b1);})
			$display("***********display inside hsize =0 ***************");
		end
		if(hs==1)
		begin
			assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR==(ha+2'b10);})
			$display("***********display inside hsize =1 ***************");
		end
		if(hs==2)
		begin	
			assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR==(ha+3'b100);})
			$display("***********display inside hsize =2 ***************");
		end
		finish_item(req);
	 $display("**************************************FROM SEQUENTIAL TRANSFER *********************");
	ha=req.HADDR;
	hs=req.HSIZE;
	end
	start_item(req);
	assert(req.randomize() with {HWRITE==1;HTRANS==0;})
	finish_item(req);
end
endtask
	

class unspecified_seq extends ahb_base_seq;

	`uvm_object_utils(unspecified_seq)
	
	extern function new(string name="unspecified_seq");
	extern task body();
endclass

function unspecified_seq::new(string name="unspecified_seq");
	super.new(name);
endfunction

task unspecified_seq::body();
bit [31:0] ha;
bit [2:0] hb;
bit [2:0] hs;
bit hw;
int i;

begin
	req=ahb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {HWRITE==1;HTRANS==2'b10;HBURST==3'b001;})
	finish_item(req);
	 $display("***********************FROM NON_SEQUENTIAL TRANSFER ****************");
	ha=req.HADDR;
	hs=req.HSIZE;
	hb=req.HBURST;
	
	//repeat(6)
	for(i=0;i<1024;i=i+1) // unspecified length defined in constraint
	begin	
		start_item(req);
		if(hs==0)
		begin
			assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR==(ha+1'b1);})
			$display("***********display inside hsize =0 ***************");
		end
		if(hs==1)
		begin
			assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR==(ha+2'b10);})
			$display("***********display inside hsize =1 ***************");
		end
		if(hs==2)
		begin	
			assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR==(ha+3'b100);})
			$display("***********display inside hsize =2 ***************");
		end
		finish_item(req);
	 $display("**************************************FROM SEQUENTIAL TRANSFER *********************");
	ha=req.HADDR;
	hs=req.HSIZE;
	end
	start_item(req);
	assert(req.randomize() with {HWRITE==1;HTRANS==0;})
	finish_item(req);
end
endtask

//--------------------------------------------------------------------------------------------------------------------------------------	
	
class ahb_wrap8_seq extends ahb_base_seq;

	`uvm_object_utils(ahb_wrap8_seq)
	
	extern function new(string name="ahb_wrap8_seq");
	extern task body();
endclass

function ahb_wrap8_seq::new(string name="ahb_wrap8_seq");
	super.new(name);
endfunction

task ahb_wrap8_seq::body();
bit [31:0] ha;
bit [2:0] hb;
bit [2:0] hs;
bit hw;

begin
	req=ahb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {HWRITE==1;HTRANS==2'b10;HBURST==3'b100;})
	finish_item(req);
	 $display("***********************FROM NON_SEQUENTIAL TRANSFER ****************");

	ha=req.HADDR;
	hs=req.HSIZE;
	hb=req.HBURST;
	
	repeat(7)
	begin	
		start_item(req);
		if(hs==0)
		begin
			assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR=={ha[31:3],ha[2:0]+1'b1};})
			$display("***********display inside hsize =0 ***************");
		end
		if(hs==1)
		begin
			assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR=={ha[31:4],ha[3:1]+1'b1,ha[0]};})
			$display("***********display inside hsize =2 ***************");
		end
		if(hs==2)
		begin
			assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR=={ha[31:5],ha[4:2]+1'b1,ha[1:0]};})
		$display("***********display inside hsize =2 ***************");
		end
		finish_item(req);
	 $display("***********************FROM SEQUENTIAL TRANSFER ****************");
	ha=req.HADDR;
	hs=req.HSIZE;
	end
	start_item(req);
	assert(req.randomize() with {HWRITE==1;HTRANS==0;})
	finish_item(req);
end
endtask


class ahb_incr8_seq extends ahb_base_seq;

	`uvm_object_utils(ahb_incr8_seq)
	
	extern function new(string name="ahb_incr8_seq");
	extern task body();
endclass

function ahb_incr8_seq::new(string name="ahb_incr8_seq");
	super.new(name);
endfunction

task ahb_incr8_seq::body();
bit [31:0] ha;
bit [2:0] hb;
bit [2:0] hs;
bit hw;

begin
	req=ahb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {HWRITE==1;HTRANS==2'b10;HBURST==3'b101;})
	finish_item(req);
	 $display("***********************FROM NON_SEQUENTIAL TRANSFER ****************");
	ha=req.HADDR;
	hs=req.HSIZE;
	hb=req.HBURST;
	

	repeat(7)
	begin	
		start_item(req);
		if(hs==0)
		begin
			assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR==(ha+1'b1);})
			$display("***********display inside hsize =0 ***************");
		end
		if(hs==1)
		begin
			assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR==(ha+2'b10);})
			$display("***********display inside hsize =1 ***************");
		end
		if(hs==2)
		begin
			assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR==(ha+3'b100);})
			$display("***********display inside hsize =2 ***************");
		end
		finish_item(req);
	 $display("***********************FROM SEQUENTIAL TRANSFER ****************");
	ha=req.HADDR;
	hs=req.HSIZE;
	end
	start_item(req);
	assert(req.randomize() with {HWRITE==1;HTRANS==0;})
	finish_item(req);
end
endtask	

class ahb_wrap16_seq extends ahb_base_seq;

	`uvm_object_utils(ahb_wrap16_seq)
	
	extern function new(string name="ahb_wrap16_seq");
	extern task body();
endclass

function ahb_wrap16_seq::new(string name="ahb_wrap16_seq");
	super.new(name);
endfunction

task ahb_wrap16_seq::body();
bit [31:0] ha;
bit [2:0] hb;
bit [2:0] hs;
bit hw;

begin
	req=ahb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {HWRITE==1;HTRANS==2'b10;HBURST==3'b110;})
	finish_item(req);
	 $display("***********************FROM NON_SEQUENTIAL TRANSFER ****************");
	ha=req.HADDR;
	hs=req.HSIZE;
	hb=req.HBURST;
	
	repeat(15)
	begin	
		start_item(req);
		if(hs==0)
		begin
			assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR=={ha[31:4],ha[3:0]+1'b1};})
			 $display("***********display inside hsize =0 ***************");
		end
		if(hs==1)
		begin
			assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR=={ha[31:5],ha[4:1]+1'b1,ha[0]};})
		 	$display("***********display inside hsize =1 ***************");
		end
		if(hs==2)
		begin
			assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR=={ha[31:6],ha[5:2]+1'b1,ha[1:0]};})
			 $display("***********display inside hsize =2 ***************");
		end
		finish_item(req);
	 $display("***********************FROM SEQUENTIAL TRANSFER ****************");

	ha=req.HADDR;
	hs=req.HSIZE;
	end
	start_item(req);
	assert(req.randomize() with {HWRITE==1;HTRANS==0;})
	finish_item(req);
end
endtask


class ahb_incr16_seq extends ahb_base_seq;

	`uvm_object_utils(ahb_incr16_seq)
	
	extern function new(string name="ahb_incr16_seq");
	extern task body();
endclass

function ahb_incr16_seq::new(string name="ahb_incr16_seq");
	super.new(name);
endfunction

task ahb_incr16_seq::body();
bit [31:0] ha;
bit [2:0] hb;
bit [2:0] hs;
bit hw;

begin
	req=ahb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {HWRITE==1;HTRANS==2'b10;HBURST==3'b111;})
	finish_item(req);
	 $display("***********************FROM NON_SEQUENTIAL TRANSFER ****************");
	ha=req.HADDR;
	hs=req.HSIZE;
	hb=req.HBURST;
	
	repeat(15)
	begin	
		start_item(req);
		if(hs==0)
		begin
			assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR==(ha+1'b1);})
			 $display("***********display inside hsize =0 ***************");
		end
		if(hs==1)
		begin
			assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR==(ha+2'b10);})
			 $display("***********display inside hsize =0 ***************");
		end
		if(hs==2)
		begin
			assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR==(ha+3'b100);})
			 $display("***********display inside hsize =0 ***************");
		end
		finish_item(req);
	 $display("***********************FROM SEQUENTIAL TRANSFER ****************");
	ha=req.HADDR;
	hs=req.HSIZE;
	end
	start_item(req);
	assert(req.randomize() with {HWRITE==1;HTRANS==0;})
	finish_item(req);
end
endtask
//---------------------------------- READ SEQUENCE-------------------------------------------------------
class single_xtn_read extends ahb_base_seq;
        `uvm_object_utils(single_xtn_read)

        extern function new(string name = "single_xtn_read");
        extern task body();

endclass

function single_xtn_read::new(string name = "single_xtn_read");
        super.new(name);
endfunction

task single_xtn_read::body();
begin
        req=ahb_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {HWRITE==0;HBURST==0;HSIZE==0;HTRANS==2;});
        finish_item(req);

        start_item(req);
        assert(req.randomize()with {HWRITE==0;HTRANS==2'b00;HSIZE==3'b010;HBURST==3'd0;})
        finish_item(req);
end
endtask

class ahb_incr4_seq_read extends ahb_base_seq;

        `uvm_object_utils(ahb_incr4_seq_read)

        extern function new(string name="ahb_incr4_seq_read");
        extern task body();
endclass

function ahb_incr4_seq_read::new(string name="ahb_incr4_seq_read");
        super.new(name);
endfunction

task ahb_incr4_seq_read::body();
bit [31:0] ha;
bit [2:0] hb;
bit [2:0] hs;
bit hw;

begin
        req=ahb_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {HWRITE==0;HTRANS==2'b10;HBURST==3'b011;})
        finish_item(req);
          $display("***********************FROM NON_SEQUENTIAL TRANSFER ****************");
        ha=req.HADDR;
        hs=req.HSIZE;
        hb=req.HBURST;

        repeat(3)
        begin
                start_item(req);
                if(hs==0)
                begin
                        assert(req.randomize() with {HWRITE==0;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR==(ha+1'b1);})
                        $display("------------------hsize=0---------------------------------------------------");
                end
                if(hs==1)
                begin
                        assert(req.randomize() with {HWRITE==0;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR==(ha+2'b10);})
                        $display("----------------------hsize=1--------------------------------------------------");
                end
                if(hs==2)
                begin
                        assert(req.randomize() with {HWRITE==0;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR==(ha+3'b100);})
                        $display("------------------------hsize=2----------------------------------------------");
                end
                finish_item(req);
                        $display("-------------------------end----------------------------------------------------");
        ha=req.HADDR;
        hs=req.HSIZE;
        end
        start_item(req);
        assert(req.randomize() with {HWRITE==0;HTRANS==0;})
        finish_item(req);
end
endtask


class ahb_wrap4_seq_read extends ahb_base_seq;//wrap4 and incr4

        `uvm_object_utils(ahb_wrap4_seq_read)

        extern function new(string name="ahb_wrap4_seq_read");
        extern task body();
endclass

function ahb_wrap4_seq_read::new(string name="ahb_wrap4_seq_read");
        super.new(name);
endfunction

task ahb_wrap4_seq_read::body();
bit [31:0] ha;
bit [2:0] hb;
bit [2:0] hs;
bit hw;

begin
        req=ahb_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {HREADYin==1;HWRITE==0;HTRANS==2'b10;HBURST==3'b010;})
        finish_item(req);
        ha=req.HADDR;
        hs=req.HSIZE;
        hb=req.HBURST;
        repeat(3)
        begin
                start_item(req);
                if(hs==0)
                begin
                 assert(req.randomize() with {HWRITE==0;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR=={ha[31:2],ha[1:0]+1'b1};})
                $display("---------------------------hsize=0-----------------------------------------------");
                end
                if(hs==1)
                begin
                        assert(req.randomize() with {HWRITE==0;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR=={ha[31:3],ha[2:1]+1'b1,ha[0]};})
                $display("-------------------------------hsize=1---------------------------------------------------");
                end
                if(hs==2)
                begin
                        assert(req.randomize() with {HWRITE==0;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR=={ha[31:4],ha[3:2]+1'b1,ha[1:0]};})
                $display("---------------------------------hsize=2---------------------------------------------------");
                end
                finish_item(req);
                $display("--------------------------------end-----------------------------------------------------------");

        ha=req.HADDR;
        hs=req.HSIZE;
        end
        start_item(req);
        assert(req.randomize() with {HWRITE==0;HTRANS==0;})
        finish_item(req);
end
endtask



class ahb_incr8_seq_read extends ahb_base_seq;

        `uvm_object_utils(ahb_incr8_seq_read)

        extern function new(string name="ahb_incr8_seq_read");
        extern task body();
endclass

function ahb_incr8_seq_read::new(string name="ahb_incr8_seq_read");
        super.new(name);
endfunction

task ahb_incr8_seq_read::body();
bit [31:0] ha;
bit [2:0] hb;
bit [2:0] hs;
bit hw;

begin
        req=ahb_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {HWRITE==0;HTRANS==2'b10;HBURST==3'b101;})
        finish_item(req);
        ha=req.HADDR;
        hs=req.HSIZE;
        hb=req.HBURST;


        repeat(7)
        begin
                start_item(req);
                if(hs==0)
                begin
                        assert(req.randomize() with {HWRITE==0;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR==(ha+1'b1);})
                        $display("---------------------------hsize=0--------------------------------------------");
                end
                if(hs==1)
                begin
                        assert(req.randomize() with {HWRITE==0;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR==(ha+2'b10);})
                        $display("----------------------------------hsize=1--------------------------------------");
                end

                if(hs==2)
                begin
                        assert(req.randomize() with {HWRITE==0;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR==(ha+3'b100);})
                        $display("--------------------------------hsize=2-----------------------------------------");
                end
                finish_item(req);
                        $display("-------------------------------end-----------------------------------------------");
        ha=req.HADDR;
        hs=req.HSIZE;
        end
        start_item(req);
        assert(req.randomize() with {HWRITE==0;HTRANS==0;})
        finish_item(req);
end
endtask


class ahb_wrap16_seq_read extends ahb_base_seq;

        `uvm_object_utils(ahb_wrap16_seq_read)

        extern function new(string name="ahb_wrap16_seq_read");
        extern task body();
endclass

function ahb_wrap16_seq_read::new(string name="ahb_wrap16_seq_read");
        super.new(name);
endfunction

task ahb_wrap16_seq_read::body();
bit [31:0] ha;
bit [2:0] hb;
bit [2:0] hs;
bit hw;

begin
        req=ahb_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {HWRITE==0;HTRANS==2'b10;HBURST==2'b110;})
        finish_item(req);
        ha=req.HADDR;
        hs=req.HSIZE;
        hb=req.HBURST;

        repeat(15)
        begin
                start_item(req);
                if(hs==0)
                begin
                        assert(req.randomize() with {HWRITE==0;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR=={ha[31:4],ha[3:0]+1'b1};})
                        $display("---------------------------------hsize=0--------------------------------------------");
                end
                if(hs==1)
                begin
                        assert(req.randomize() with {HWRITE==0;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR=={ha[31:5],ha[4:1]+1'b1,ha[0]};})
                        $display("-----------------------------hsize=1--------------------------------------------------");
                end
                if(hs==2)
                begin
                        assert(req.randomize() with {HWRITE==0;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR=={ha[31:6],ha[5:2]+1'b1,ha[1:0]};})
                        $display("---------------------------hsize=2----------------------------------------------------");
                end
                 finish_item(req);
                        $display("------------------------------------end-----------------------------------------------");
        ha=req.HADDR;
        hs=req.HSIZE;
        end
        start_item(req);
        assert(req.randomize() with {HWRITE==0;HTRANS==0;})
        finish_item(req);

end
endtask


class ahb_incr16_seq_read extends ahb_base_seq;

        `uvm_object_utils(ahb_incr16_seq_read)

        extern function new(string name="ahb_incr16_seq_read");
        extern task body();
endclass

function ahb_incr16_seq_read::new(string name="ahb_incr16_seq_read");
        super.new(name);
endfunction

task ahb_incr16_seq_read::body();
bit [31:0] ha;
bit [2:0] hb;
bit [2:0] hs;
bit hw;

begin
        req=ahb_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {HWRITE==0;HTRANS==2'b10;HBURST==2'b111;})
        finish_item(req);
        ha=req.HADDR;
        hs=req.HSIZE;
        hb=req.HBURST;

        repeat(15)
        begin
                start_item(req);
                if(hs==0)
                begin
                        assert(req.randomize() with {HWRITE==0;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR==(ha+1'b1);})
                        $display("----------------------hsize=0-------------------------------------------");
                end
                if(hs==1)
                begin
                         assert(req.randomize() with {HWRITE==0;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR==(ha+2'b10);})
                        $display("--------------------------hsize=1-------------------------------------------------------");
                end
                if(hs==2)
                begin
                        assert(req.randomize() with {HWRITE==0;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR==(ha+3'b100);})
                        $display("------------------------hsize=2-------------------------------------------------------");
                end
                finish_item(req);
                        $display("-----------------------end------------------------------------------------------");
        ha=req.HADDR;
        hs=req.HSIZE;
        end
        start_item(req);
        assert(req.randomize() with {HWRITE==0;HTRANS==0;})
        finish_item(req);
end
endtask


class ahb_wrap8_seq_read extends ahb_base_seq;

	`uvm_object_utils(ahb_wrap8_seq_read)
	
	extern function new(string name="ahb_wrap8_seq_read");
	extern task body();
endclass

function ahb_wrap8_seq_read::new(string name="ahb_wrap8_seq_read");
	super.new(name);
endfunction



task ahb_wrap8_seq_read::body();
bit [31:0] ha;
bit [2:0] hb;
bit [2:0] hs;
bit hw;

begin
	req=ahb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with {HWRITE==0;HTRANS==2'b10;HBURST==3'b100;})
	finish_item(req);
	 $display("***********************FROM NON_SEQUENTIAL TRANSFER ****************");

	ha=req.HADDR;
	hs=req.HSIZE;
	hb=req.HBURST;
	
	repeat(7)
	begin	
		start_item(req);
		if(hs==0)
		begin
			assert(req.randomize() with {HWRITE==0;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR=={ha[31:3],ha[2:0]+1'b1};})
			$display("***********display inside hsize =0 ***************");
		end
		if(hs==1)
		begin
			assert(req.randomize() with {HWRITE==0;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR=={ha[31:4],ha[3:1]+1'b1,ha[0]};})
			$display("***********display inside hsize =2 ***************");
		end
		if(hs==2)
		begin
			assert(req.randomize() with {HWRITE==0;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR=={ha[31:5],ha[4:2]+1'b1,ha[1:0]};})
		$display("***********display inside hsize =2 ***************");
		end
		finish_item(req);
	 $display("***********************FROM SEQUENTIAL TRANSFER ****************");
	ha=req.HADDR;
	hs=req.HSIZE;
	end
	start_item(req);
	assert(req.randomize() with {HWRITE==1;HTRANS==0;})
	finish_item(req);
end
endtask



class ahb_incr4_seq_rw extends ahb_base_seq;

        `uvm_object_utils(ahb_incr4_seq_rw)

        extern function new(string name="ahb_incr4_seq_rw");
        extern task body();
endclass

function ahb_incr4_seq_rw::new(string name="ahb_incr4_seq_rw");
        super.new(name);
endfunction

task ahb_incr4_seq_rw::body();
bit [31:0] ha;
bit [2:0] hb;
bit [2:0] hs;
bit hw;

begin
        req=ahb_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {HTRANS==2'b10;HBURST==3'b011;})
        finish_item(req);
         $display("***********************FROM NON_SEQUENTIAL TRANSFER ****************");
        ha=req.HADDR;
        hs=req.HSIZE;
        hb=req.HBURST;
	hw=req.HWRITE;

        repeat(3)
        begin
                start_item(req);
                if(hs==0)
                begin
                        assert(req.randomize() with {HTRANS==2'b11;HSIZE==hs;HBURST==hb;HWRITE==hw; HADDR==(ha+1'b1);})
			 $display("***********display inside hsize =0 ***************");
                end
                if(hs==1)
                begin
                        assert(req.randomize() with {HTRANS==2'b11;HSIZE==hs;HBURST==hb;HWRITE==hw;HADDR==(ha+2'b10);})
                        $display("***********display inside hsize =1 ***************");
                end
                if(hs==2)
                begin
                        assert(req.randomize() with {HTRANS==2'b11;HSIZE==hs;HBURST==hb;HWRITE==hw;HADDR==(ha+3'b100);})
                        $display("***********display inside hsize =2 ***************");
                end
                finish_item(req);
         $display("**************************************FROM SEQUENTIAL TRANSFER *********************");
        ha=req.HADDR;
        hs=req.HSIZE;
        end
        start_item(req);
        assert(req.randomize() with {HTRANS==0;})
        finish_item(req);
end
endtask


class ahb_incr16_seqib extends ahb_base_seq;

        `uvm_object_utils(ahb_incr16_seqib)

        extern function new(string name="ahb_incr16_seqib");
        extern task body();
endclass

function ahb_incr16_seqib::new(string name="ahb_incr16_seqib");
        super.new(name);
endfunction

task ahb_incr16_seqib::body();
bit [31:0] ha;
bit [2:0] hb;
bit [2:0] hs;
bit hw;

begin
        req=ahb_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {HWRITE==1;HTRANS==2'b10;HBURST==3'b111;})
        finish_item(req);
         $display("***********************FROM NON_SEQUENTIAL TRANSFER ****************");
        ha=req.HADDR;
        hs=req.HSIZE;
        hb=req.HBURST;

        repeat(15)
        begin
                start_item(req);
                if(hs==0)
                begin
                        assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR==(ha+1'b1);})
                         $display("***********display inside hsize =0 ***************");
                   end
                if(hs==1)
                begin
                        assert(req.randomize() with {HWRITE==1;HTRANS==2'b01;HSIZE==hs;HBURST==hb;HADDR==(ha+2'b10);})
                         $display("***********display inside hsize =0 ***************");
                end
                if(hs==2)
                begin
                        assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==hs;HBURST==hb;HADDR==(ha+3'b100);})
                         $display("***********display inside hsize =0 ***************");
                end
                finish_item(req);
         $display("***********************FROM SEQUENTIAL TRANSFER ****************");
        ha=req.HADDR;
        hs=req.HSIZE;
        end
        start_item(req);
        assert(req.randomize() with {HWRITE==1;HTRANS==0;})
        finish_item(req);
end
endtask


	
*/







































/*


class ahb_wrap4_seq extends ahb_base_seq;

	`uvm_object_utils(ahb_wrap4_seq)

	extern function new(string name="ahb_wrap4_seq");
	extern task body();
endclass

function ahb_wrap4_seq::new(string name="ahb_wrap4_seq");
	super.new(name);
endfunction

task ahb_wrap4_seq::body();
	begin
		req=ahb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {HTRANS==2'b10;HREADYin==1;HBURST==3'd2;HWRITE==1;HSIZE==0;})
		ha=req.HADDR;
		hw=req.HWRITE;
		hs=req.HSIZE;
		finish_item(req);
	
		repeat(3)
		begin
		ha=ha+(2**hs);
		/*if(hs==0) ha={ha[31:2],ha[1:0]+1'b1};
		else if(hs==1) ha={ha[31:3],ha[2:1]+1'b1,ha[0]};
		else if(hs==2) ha={ha[31:4],ha[3:2]+1'b1,ha[1:0]};*/
		
/*		
		start_item(req);
		assert(req.randomize()with {HWRITE==hw;HTRANS==2'b11;HSIZE==hs;HADDR==ha;HREADYin==1;HBURST==3'd2;})
		$display("******************this is AHB_WRITE_SEQUENCE**********************");
		req.print;
		finish_item(req);
		//end
		
	//	start_item(req);
		//assert(req.randomize() with {HWRITE==hw;HTRANS==2'b00;HSIZE==hs;HREADYin==1;HBURST==3'd2;})
	//	finish_item(req);

		
		
//end
//endtask*/
