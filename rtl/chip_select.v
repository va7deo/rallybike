//

module chip_select
(
    input  [7:0] pcb,

    input [23:0] cpu_a,
    input        cpu_as_n,

    input [15:0] z80_addr,
    input        MREQ_n,
    input        IORQ_n,

    // M68K selects
    output       prog_rom_cs,
    output       ram_cs,
    output       scroll_ofs_x_cs,
    output       scroll_ofs_y_cs,
    output       frame_done_cs,
    output       int_en_cs,
    output       crtc_cs,
    output       tile_ofs_cs,
    output       tile_attr_cs,
    output       tile_num_cs,
    output       scroll_cs,
    output       shared_ram_cs,
    output       vblank_cs,
    output       tile_palette_cs,
    output       bcu_flip_cs,
    output       sprite_palette_cs,
    output       sprite_ofs_cs,
    output       sprite_cs,
    output       sprite_size_cs,
    output       sprite_ram_cs,
    output       fcu_flip_cs,
    output       reset_z80_cs,
    output       dsp_ctrl_cs,

    // Z80 selects
    output       z80_p1_cs,
    output       z80_p2_cs,
    output       z80_dswa_cs,
    output       z80_dswb_cs,
    output       z80_system_cs,
    output       z80_tjump_cs,
    output       z80_sound0_cs,
    output       z80_sound1_cs,

    // other params
    output reg [15:0] scroll_y_offset
    
);

localparam pcb_truxton       = 4;
localparam pcb_rallybike     = 7;

function m68k_cs;
        input [23:0] base_address;
        input  [7:0] width;
begin
    m68k_cs = ( cpu_a >> width == base_address >> width ) & !cpu_as_n;
end
endfunction

function z80_cs;
        input [7:0] address_lo;
begin
    z80_cs = ( IORQ_n == 0 && z80_addr[7:0] == address_lo );
end
endfunction

always @ (*) begin

    scroll_y_offset = ( pcb == pcb_rallybike ) ? 16 : 0 ;

    prog_rom_cs       = m68k_cs( 'h000000, 19 );
    ram_cs            = m68k_cs( 'h080000, 14 );
    bcu_flip_cs       = m68k_cs( 'h100000,  1 );
    tile_ofs_cs       = m68k_cs( 'h100002,  1 );
    tile_attr_cs      = m68k_cs( 'h100004,  1 );
    tile_num_cs       = m68k_cs( 'h100006,  1 );
    scroll_cs         = m68k_cs( 'h100010,  4 );
    scroll_ofs_x_cs   = m68k_cs( 'h1c0000,  1 );
    scroll_ofs_y_cs   = m68k_cs( 'h1c0002,  1 );


    vblank_cs         = m68k_cs( 'h140000,  1 );
    tile_palette_cs   = m68k_cs( 'h144000, 11 );
    sprite_palette_cs = m68k_cs( 'h146000, 11 );

    int_en_cs         = m68k_cs( 'h140002,  1 );
    crtc_cs           = m68k_cs( 'h140008,  3 );

    shared_ram_cs     = m68k_cs( 'h180000, 12 );
    
    z80_p1_cs         = z80_cs( 8'h00 );
    z80_p2_cs         = z80_cs( 8'h10 );
    z80_system_cs     = z80_cs( 8'h20 );
    z80_dswa_cs       = z80_cs( 8'h40 );
    z80_dswb_cs       = z80_cs( 8'h50 );
    z80_sound0_cs     = z80_cs( 8'h60 );
    z80_sound1_cs     = z80_cs( 8'h61 );
    z80_tjump_cs      = z80_cs( 8'h70 );    
    
    // Setup lines depending on pcb
    case (pcb)
        pcb_truxton: begin
            frame_done_cs     = m68k_cs( 'h0c0000,  1 );

            sprite_ram_cs     = 0 ;
            
            sprite_ofs_cs     = m68k_cs( 'h0c0002,  1 );
            sprite_cs         = m68k_cs( 'h0c0004,  1 );
            sprite_size_cs    = m68k_cs( 'h0c0006,  1 );

            fcu_flip_cs       = m68k_cs( 'h1c0006,  1 );

            reset_z80_cs      = m68k_cs( 'h1d0000,  1 );
        end

        pcb_rallybike: begin
            frame_done_cs     = 1'b0;

            sprite_ram_cs     = m68k_cs( 'h0c0000, 12 );
            
            sprite_ofs_cs     = 0 ;
            sprite_cs         = 0 ;
            sprite_size_cs    = 0 ;

            fcu_flip_cs       = 0 ;
          
            reset_z80_cs      = m68k_cs( 'h1c8000,  1 );
        end

        default:;
    endcase
end

endmodule
