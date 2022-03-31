`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:51:59 11/29/2021 
// Design Name: 
// Module Name:    maze 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module maze#( 
    parameter maze_width = 6
) (
input 		          clk,
input [maze_width - 1:0]  starting_col, starting_row, 	// indicii punctului de start
input  			  maze_in, 			// ofera informa?ii despre punctul de coordonate [row, col]
output reg [maze_width - 1:0] row, col,	 		// selecteaza un rând si o coloana din labirint
output 		reg	  maze_oe,			// output enable (activeaza citirea din labirint la rândul ?i coloana date) - semnal sincron	
output 		reg	  maze_we, 			// write enable (activeaza scrierea în labirint la rândul ?i coloana date) - semnal sincron
output 		reg	  done);		 	// ie?irea din labirint a fost gasita; semnalul ramane activ 

reg [4:0] state, next_state=0;



	 always @(posedge clk) begin
		state <= next_state;
	 end
	 
	 always @(*) begin
		maze_we=0;

	 
	 
		case(state)
			0: begin
			maze_we=0;
			
				row=starting_row;
				col=starting_col;
				maze_oe=1;

				
				next_state=1;
				end
			1: begin	       //venit din stanga
			
				maze_we=0;
				if(maze_in==1) begin

					col=col-1;
					next_state= 2;
				end
				else begin
					maze_we=1;
					
					if(col==63)
					begin
					done=1;
					end
					
				
					next_state=6;
					
					if(done==1)
					next_state=5;
				end
				maze_oe=1;
			end
			
			2: begin			//venit din dreapta
			
			maze_we=0;

				if(maze_in==1) begin
	
					col=col+1;
					next_state= 1;
				end
				else begin
					maze_we=1;
					
					if(col==0)
					begin
					done=1;
					end
					
					
					next_state=7;
					if(done==1)
					next_state=5;
				end
								maze_oe=1;
			end
			3: begin			//venit de sus
			maze_we=0;

				if(maze_in==1) begin

					row=row-1;
					next_state= 4;
				end
				else begin
					maze_we=1;
					
					if(row==63)
					begin
					done=1;
					end
					
					
					next_state=8;
					if(done==1)
					next_state=5;
				end
								maze_oe=1;
			end
			4: begin			//venit de jos
			maze_we=0;

				if(maze_in==1) begin

					row=row+1;
					next_state= 3;
				end
				else begin
					maze_we=1;
					
					if(row==0)
					begin
					done=1;

					end
					

					next_state=9;
					if(done==1)
					next_state=5;
				end
					maze_oe=1;				
			end
			5: begin 
				done=1;
			end
			
			6:begin
				row=row+1;
				next_state=3;	
				maze_oe=1;
			end
			
			7:begin 
				row=row-1;
				next_state=4;
				maze_oe=1;
			end
			
			8: begin
				col=col-1;
				next_state=2;
				maze_oe=1;
			end
			
			9: begin
				col=col+1;
				next_state=1;
				maze_oe=1;
			end
		endcase
		
end

endmodule
