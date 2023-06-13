// scoreboard

/*class scoreboard extends uvm_scoreboard;
	
	`uvm_component_utils(scoreboard);

env_config cfg;    //  check this one

ahb_xtn data_ahb_mon;
apb_xtn data_apb_mon;


ahb_xtn ahb_cov_dt;

uvm_tlm_analysis_fifo #(apb_xtn) fifo_apbh;
uvm_tlm_analysis_fifo #(ahb_xtn) fifo_ahbh;

covergroup bridge_coverage;
option.per_instance=1;

	BURST : coverpoint ahb_cov_dt.HBURST {bins b[]={[0:7]};}
	
	SIZE :coverpoint ahb_cov_dt.HSIZE {bins s[]={[0:2]};}

	WRITE :coverpoint ahb_cov_dt.HWRITE {bins zero={0};bins one={1};}

	TRANS : coverpoint ahb_cov_dt.HTRANS {bins t[]={[0:3]};}

	AHB_FC :cross BURST,SIZE,WRITE,TRANS;

endgroup

extern function new(string name="SCOREBOARD",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task check1();
extern task compare(bit [31:0]HDATA,bit [31:0]PDATA,bit [31:0]HADDR,bit [31:0]PADDR);

endclass


function scoreboard::new(string name="SCOREBOARD",uvm_component parent);
 super.new(name,parent);
endfunction


function void scoreboard::build_phase(uvm_phase phase);
 if(!uvm_config_db #(env_config)::get(this,"","env_config",cfg))
  `uvm_fatal("SB","cannot get config data");

 fifo_apbh=new("fifo_apbh",this);
 fifo_ahbh=new("fifo_ahbh",this);
 super.build_phase(phase);
endfunction


task scoreboard::run_phase(uvm_phase phase);


    forever
        begin
     check1();
       end
endtask
task scoreboard::check1();
        //data_ahb_mon = ahb_xtn::type_id::create("data_ahb_mon");

      //  data_ahb_mon = new data_ahb_mon1;

    if(!(data_ahb_mon.HWRITE))
       begin
            case(data_ahb_mon.HSIZE)

              2'b00:begin
                   if(data_ahb_mon.HADDR[1:0] == 2'b00)
                                 compare(data_ahb_mon.HRDATA[7:0],data_apb_mon.prdata[7:0],data_ahb_mon.HADDR,data_apb_mon.paddr);
                   else if(data_ahb_mon.HADDR[1:0] == 2'b01)
                                compare(data_ahb_mon.HRDATA[7:0],data_apb_mon.prdata[15:8],data_ahb_mon.HADDR,data_apb_mon.paddr);
                   else if(data_ahb_mon.HADDR[1:0] == 2'b10)
                                compare(data_ahb_mon.HRDATA[7:0],data_apb_mon.prdata[23:16],data_ahb_mon.HADDR,data_apb_mon.paddr);
                   else if(data_ahb_mon.HADDR[1:0] == 2'b11)
                               compare(data_ahb_mon.HRDATA[7:0],data_apb_mon.prdata[31:24],data_ahb_mon.HADDR,data_apb_mon.paddr);
                    end

              2'b01:begin
                if(data_ahb_mon.HADDR[1:0] == 2'b00)
                             compare(data_ahb_mon.HRDATA[15:0],data_apb_mon.prdata[15:0],data_ahb_mon.HADDR,data_apb_mon.paddr);
                if(data_ahb_mon.HADDR[1:0] == 2'b10)
                             compare(data_ahb_mon.HRDATA[15:0],data_apb_mon.prdata[31:16],data_ahb_mon.HADDR,data_apb_mon.paddr);
                    end
               2'b10: compare(data_ahb_mon.HRDATA,data_apb_mon.prdata,data_ahb_mon.HADDR,data_apb_mon.paddr);

            endcase

       end


else if(data_ahb_mon.HWRITE)
           begin
            case(data_ahb_mon.HSIZE)

              2'b00:begin
                   if(data_ahb_mon.HADDR[1:0] == 2'b00)
                                 compare(data_ahb_mon.HWDATA[7:0],data_apb_mon.pwdata[7:0],data_ahb_mon.HADDR,data_apb_mon.paddr);
                   else if(data_ahb_mon.HADDR[1:0] == 2'b01)
                                compare(data_ahb_mon.HWDATA[15:8],data_apb_mon.pwdata[7:0],data_ahb_mon.HADDR,data_apb_mon.paddr);
                   else if(data_ahb_mon.HADDR[1:0] == 2'b10)
                                compare(data_ahb_mon.HWDATA[23:16],data_apb_mon.pwdata[7:0],data_ahb_mon.HADDR,data_apb_mon.paddr);
                   else if(data_ahb_mon.HADDR[1:0] == 2'b11)
                               compare(data_ahb_mon.HWDATA[31:24],data_apb_mon.pwdata[7:0],data_ahb_mon.HADDR,data_apb_mon.paddr);
                    end

              2'b01:begin
                if(data_ahb_mon.HADDR[1:0] == 2'b00)
                             compare(data_ahb_mon.HWDATA[15:0],data_apb_mon.pwdata[15:0],data_ahb_mon.HADDR,data_apb_mon.paddr);
                if(data_ahb_mon.HADDR[1:0] == 2'b10)

                             compare(data_ahb_mon.HWDATA[31:16],data_apb_mon.pwdata[15:0],data_ahb_mon.HADDR,data_apb_mon.paddr);
                    end
               2'b10: compare(data_ahb_mon.HWDATA,data_apb_mon.pwdata,data_ahb_mon.HADDR,data_apb_mon.paddr);

            endcase

       end
 endtask


task scoreboard::compare(bit [31:0]HDATA,bit [31:0]PDATA,bit [31:0]HADDR,bit [31:0]PADDR);
     if(HADDR == PADDR)
                  `uvm_info("Scoreboard","ADDRESS COMPARED SUCCESSFULLY",UVM_LOW)

    else
                 `uvm_info("Scoreboard","ADDRESS NOT COMPARED SUCCESSFULLY",UVM_LOW)

     if(HDATA == PDATA)
                  `uvm_info("Scoreboard","DATA COMPARED SUCCESSFULLY",UVM_LOW)

    else
                `uvm_info("Scoreboard","DATA NOT COMPARED SUCCESSFULLY",UVM_LOW)
        
        endtask
*/	

class scoreboard extends uvm_scoreboard;

        `uvm_component_utils(scoreboard);

        uvm_tlm_analysis_fifo#(ahb_xtn) af_ahb_h;
        uvm_tlm_analysis_fifo#(apb_xtn) af_apb_h;
//      uvm_tlm_analysis_fifo#(ahb_xtn) af_r_ahb_h;
//      uvm_tlm_analysis_fifo#(apb_xtn) af_r_apb_h;

        env_config cfg_h;

        ahb_xtn tx;

        apb_xtn tx1;

        ahb_xtn hcov;
        apb_xtn pcov;

        bit [7:0] pass,fail;

covergroup ahb_cg;
   option.per_instance=1;
	HB:         coverpoint hcov.HBURST{bins hburst_bin[]={[0:7]};}//7 bins 
        HS:          coverpoint hcov.HSIZE{bins hsize_bin[]={[0:2]};}//3 bins 
        HT:         coverpoint hcov.HTRANS{bins htrans_bin[]={[2:3]};}
        HW:         coverpoint hcov.HWRITE{bins hwrite_bin = {1};}
        HA:          coverpoint hcov.HADDR{bins haddr_bin1= {[32'h8000_0000:32'h8000_03ff]};//1bin 
							bins haddr_bin2= {[32'h8400_0000:32'h8400_03ff]};
							 bins haddr_bin3= {[32'h8800_0000:32'h8800_03ff]};//1 bin 
							 bins haddr_bin4= {[32'h8c00_0000:32'h8c00_03ff]};
								}

        HWD:         coverpoint hcov.HWDATA{bins hwdata_bin= {[32'h0000_0000:32'hffff_ffff]};}
						
        HR: coverpoint hcov.HRDATA{bins hrdata_bin= {[32'h0000_0000:32'hffff_ffff]};}

    C1: cross HS,HW,HT,HWD;
     C2: cross HS,HW,HR;

        endgroup  covergroup apb_cg;

        ENABLE: coverpoint pcov.penable{bins penable_bin = {1};}
        PWDATA:coverpoint pcov.pwdata{bins pwdata_bin= {[32'h0000_0000:32'hffff_ffff]};}// 1 bin 
        PRDATA: coverpoint pcov.prdata{bins prdata_bin= {[32'h0000_0000:32'hffff_ffff]};}
        PWRITE:    coverpoint pcov.pwrite{bins pwrite_bin = {0};}
         endgroup


	extern function new(string name="bridge_scoreboard",uvm_component parent);
        extern function void build_phase(uvm_phase phase);

	//extern task run_phase(uvm_phase phase);
        //extern function void check_(ahb_xtn tx,apb_xtn tx1);
       // extern function void compare_(bit[31:0] Hdata,[31:0]Pdata,[31:0]Haddr,[31:0]Paddr);
endclass

ahb_xtn tx;
apb_xtn tx1;

           bit [31:0] ahb_addr_write[$];
           bit [31:0] ahb_addr_read[$];
           bit [31:0] ahb_data_write[$];
           bit [31:0] ahb_data_read[$];

           bit [31:0] apb_addr_write[$];
           bit [31:0] apb_addr_read[$];
           bit [31:0] apb_data_write[$];
           bit [31:0] apb_data_read[$];

function scoreboard::new(string name="bridge_scoreboard",uvm_component parent);
        super.new(name,parent);
         af_ahb_h=new("af_ahb_h",this);
   //      af_r_ahb_h=new("af_r_ahb_h",this);
 //      af_w_apb_h=new("af_w_apb_h",this);
         af_apb_h=new("af_apb_h",this);

    ahb_cg=new;
    apb_cg=new;

endfunction

function void scoreboard::build_phase(uvm_phase phase);
        if(!uvm_config_db #(env_config)::get(this,"","env_config",cfg_h))
		`uvm_fatal("SB","cannot get config data");
	
        //       `uvm_info("SB",{get_type_name(),"Succesfully SCOREBOARD created"},UVM_MEDIUM);

        super.build_phase(phase);
endfunction

/*task scoreboard::run_phase(uvm_phase phase);


fork
        forever
        begin
         af_ahb_h.get(tx);                           // get transaction from ahb mon
        `uvm_info("SB","Inside run phase",UVM_LOW)



                 ahb_data_write.push_back(tx.HWDATA);
                ahb_addr_write.push_back(tx.HADDR);

            //  abh_data_read.push_back(tx.HRDATA);

 ahb_data_read.push_back(tx.HRDATA);
ahb_addr_read.push_back(tx.HADDR);



        af_apb_h.get(tx1);

                            // get transaction from apb mon

            apb_data_write.push_back(tx1.pwdata);
        apb_addr_write.push_back(tx1.pwdata);

         //apb_data_read.push_back(tx1.PRDATA);

        apb_data_read.push_back(tx1.prdata);
        apb_addr_read.push_back(tx1.paddr);


         check_(tx,tx1);
 $displayh("apb read add %h",tx1.paddr);
$displayh("apb read  data %h",tx1.prdata);

hcov=tx;

pcov=tx1;
ahb_cg.sample();
apb_cg.sample();
end
join_none
//hcov=tx;
//pcov=tx1;
//ahb_cg.sample();
//apb_cg.sample();

endtask



function void scoreboard::check_(ahb_xtn tx,apb_xtn tx1);

tx.HWDATA=ahb_data_write.pop_front();
tx.HRDATA=ahb_data_read.pop_front();
tx.HADDR=ahb_addr_read.pop_front();
tx.HADDR=ahb_addr_write.pop_front();
tx1.pwdata=apb_data_write.pop_front();
tx1.prdata=apb_data_read.pop_front();
tx1.paddr=apb_addr_write.pop_front();
tx1.paddr=apb_addr_read.pop_front();

if(tx.HWRITE)  //tt                                                   //data_ahb_mon==tx
                                                                                // q==ahb_data_write
   begin
           case(tx.HSIZE)
                2'b00: begin
                    if(tx.HADDR[1:0]==2'b00)
                      compare_(tx.HWDATA[7:0],tx1.pwdata[7:0],tx.HADDR,tx1.paddr);
                    if(tx.HADDR[1:0]==2'b01)
                        compare_(tx.HWDATA[15:8],tx1.pwdata[7:0],tx.HADDR,tx1.paddr);
                        if(tx.HADDR[1:0]==2'b10)
                        compare_(tx.HWDATA[23:16],tx1.pwdata[7:0],tx.HADDR,tx1.paddr);
                          if(tx.HADDR[1:0]==2'b11)
                        compare_(tx.HWDATA[31:24],tx1.pwdata[7:0],tx.HADDR,tx1.paddr);
                         end
         2'b01: begin

                        if(tx.HADDR[1:0]==2'b00)
                      compare_(tx.HWDATA[15:0],tx1.pwdata[15:0],tx.HADDR,tx1.paddr);     //confuse
                    if(tx.HADDR[1:0]==2'b10)
                        compare_(tx.HWDATA[31:16],tx1.pwdata[15:0],tx.HADDR,tx1.paddr);
                  end
        2'b10: begin

        compare_(tx.HWDATA[31:0],tx1.pwdata[31:0],tx.HADDR,tx1.paddr);
        end
        endcase
end
//else
  if(!tx1.pwrite)
         begin

        case(tx.HSIZE)
          2'b00: begin
                if(tx.HADDR[1:0]==2'b00)
                compare_(tx.HRDATA[7:0],tx1.prdata[7:0],tx.HADDR,tx1.paddr);
                if(tx.HADDR[1:0]==2'b01)
                compare_(tx.HRDATA[15:8],tx1.prdata[7:0],tx.HADDR,tx1.paddr);
                if(tx.HADDR[1:0]==2'b10)
                compare_(tx.HRDATA[23:16],tx1.prdata[7:0],tx.HADDR,tx1.paddr);
                if(tx.HADDR[1:0]==2'b11)
                compare_(tx.HRDATA[31:24],tx1.prdata[7:0],tx.HADDR,tx1.paddr);
                 end
        2'b01: begin

                if(tx.HADDR[1:0]==2'b00)
                compare_(tx.HRDATA[15:0],tx1.prdata[15:0],tx.HADDR,tx1.paddr);     //confuse
                if(tx.HADDR[1:0]==2'b10)
                compare_(tx.HRDATA[31:16],tx1.prdata[15:0],tx.HADDR,tx1.paddr);
                end
        2'b10: begin

                compare_(tx.HRDATA[31:0],tx1.prdata[31:0],tx.HADDR,tx1.paddr);
                end
        endcase

        end



else if(!(tx.HWRITE))
       begin
            case(tx.HSIZE)

              2'b00:begin
                   if(tx.HADDR[1:0] == 2'b00)
                                 compare_(tx.HRDATA[7:0],tx1.prdata[7:0],tx.HADDR,tx1.paddr);
                   else if(tx.HADDR[1:0] == 2'b01)
                                compare_(tx.HRDATA[7:0],tx1.prdata[15:8],tx.HADDR,tx1.paddr);
                   else if(tx.HADDR[1:0] == 2'b10)
                                compare_(tx.HRDATA[7:0],tx1.prdata[23:16],tx.HADDR,tx1.paddr);
                   else if(tx.HADDR[1:0] == 2'b11)
                               compare_(tx.HRDATA[7:0],tx1.prdata[31:24],tx.HADDR,tx1.paddr);
                    end

              2'b01:begin
                if(tx.HADDR[1:0] == 2'b00)
                             compare_(tx.HRDATA[15:0],tx1.prdata[15:0],tx.HADDR,tx1.paddr);
                if(tx.HADDR[1:0] == 2'b10)
                             compare_(tx.HRDATA[15:0],tx1.prdata[31:16],tx.HADDR,tx1.paddr);
                    end
               2'b10: compare_(tx.HRDATA,tx1.prdata,tx.HADDR,tx1.paddr);

            endcase

       end

else if(tx1.pwrite)
         begin

        case(tx.HSIZE)
          2'b00: begin
                if(tx.HADDR[1:0]==2'b00)
                compare_(tx.HWDATA[7:0],tx1.pwdata[7:0],tx.HADDR,tx1.paddr);
                if(tx.HADDR[1:0]==2'b01)
                compare_(tx.HWDATA[7:0],tx1.pwdata[15:8],tx.HADDR,tx1.paddr);
                if(tx.HADDR[1:0]==2'b10)
                compare_(tx.HWDATA[7:0],tx1.pwdata[23:16],tx.HADDR,tx1.paddr);
                if(tx.HADDR[1:0]==2'b11)
                compare_(tx.HWDATA[7:0],tx1.pwdata[31:24],tx.HADDR,tx1.paddr);
                 end
        2'b01: begin

                if(tx.HADDR[1:0]==2'b00)
                compare_(tx.HWDATA[15:0],tx1.pwdata[15:0],tx.HADDR,tx1.paddr);     //confuse
                if(tx.HADDR[1:0]==2'b10)
                compare_(tx.HWDATA[15:0],tx1.pwdata[31:16],tx.HADDR,tx1.paddr);
                end
        2'b10: begin

                compare_(tx.HWDATA[31:0],tx1.pwdata[31:0],tx.HADDR,tx1.paddr);
                end
        endcase

        end


endfunction


function void scoreboard::compare_(bit[31:0] Hdata,[31:0]Pdata,[31:0]Haddr,[31:0]Paddr);
//bit [31:0]Hdata,[31:0]Pdata,[31:0]Haddr,[31:0]Paddr;
//bit [7:0]pass,[7:0]fail;
//int pass,fail;

 if((Hdata==Pdata) &&(Haddr==Paddr))
begin
 $display("Transaction successful");
        pass++;
   end
else
  begin
 $display("Failed transaction");
        fail++;
end

$displayh("ahb write add %h",Haddr);
$displayh("apb write add %h",Paddr);
$displayh("ahb write data %h",Hdata);
$displayh("apb write data %h",Pdata);
// ahb_cg.sample();
// apb_cg.sample();
endfunction
*/
