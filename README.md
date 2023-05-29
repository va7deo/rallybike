
# Toaplan (Rally Bike) FPGA Implementation

FPGA compatible core of Toaplan Version 1 arcade hardware for [**MiSTerFPGA**](https://github.com/MiSTer-devel/Main_MiSTer/wiki) written by [**Darren Olafson**](https://twitter.com/Darren__O). Based on OutZone schematics and verified against Rally Bike (TP-012).

The intent is for this core to be a 1:1 implementation of Toaplan V1 hardware. Currently in beta state, this core is in active development with assistance from [**atrac17**](https://github.com/atrac17).

Horror Story / Demon's World (TP-016), Tatsujin (TP-013B), Hellfire (TP-014), Zero Wing (TP-015), OutZone (TP-018), Vimana (TP-019), and Same! Same! Same! (TP-017) are also Toaplan V1 titles. Separate repositories located [**here**](https://github.com/va7deo?tab=repositories).



## Supported Titles

| Title                                                                   | PCB<br>Number | Status      | Released |
|-------------------------------------------------------------------------|---------------|-------------|----------|
| [**Dash Yarou / Rally Bike**](https://en.wikipedia.org/wiki/Rally_Bike) | TP-012        | Implemented | Yes      |

## External Modules

| Module                                                                                | Function                                                                    | Author                                         |
|---------------------------------------------------------------------------------------|-----------------------------------------------------------------------------|------------------------------------------------|
| [**fx68k**](https://github.com/ijor/fx68k)                                            | [**Motorola 68000 CPU**](https://en.wikipedia.org/wiki/Motorola_68000)      | Jorge Cwik                                     |
| [**t80**](https://opencores.org/projects/t80)                                         | [**Zilog Z80 CPU**](https://en.wikipedia.org/wiki/Zilog_Z80)                | Daniel Wallner                                 |
| [**jtopl2**](https://github.com/jotego/jtopl)                                         | [**Yamaha OPL2**](https://en.wikipedia.org/wiki/Yamaha_OPL#OPL2)            | Jose Tejada                                    |
| [**yc_out**](https://github.com/MikeS11/MiSTerFPGA_YC_Encoder)                        | [**Y/C Video Module**](https://en.wikipedia.org/wiki/S-Video)               | Mike Simone                                    |
| [**mem**](https://github.com/MiSTer-devel/Arcade-Rygar_MiSTer/tree/master/src/mem)    | SDRAM Controller / Rom Downloader                                           | Josh Bassett, modified by Darren Olafson       |
| [**core_template**](https://github.com/MiSTer-devel/Template_MiSTer)                  | MiSTer Framework Template                                                   | sorgelig, modified by Darren Olafson / atrac17 |

# Known Issues / Tasks

- [**OPL2 Audio**](https://github.com/jotego/jtopl/issues/11)  **[Issue]**  

# PCB Check List

### Clock Information

| H-Sync       | V-Sync      | Source    | PCB<br>Number |
|--------------|-------------|-----------|---------------|
| 15.556938kHz | 55.161153Hz | ADALM2000 | TP-012        |

### Crystal Oscillators

| Freq (MHz) | Use                                                            |
|------------|----------------------------------------------------------------|
| 10.00      | M68000 CLK (10 MHz)                                            |
| 28.000     | Z80 CLK (3.5 MHz)<br>YM3812 CLK (3.5 MHz)<br>Pixel CLK (7 MHz) |

**Pixel clock:** 7.00 MHz

**Estimated geometry:**

_(Dash Yarou / Rally Bike)_

    450 pixels/line  
  
    282 lines/frame  

### Main Components

| Chip                                                                   | Function         |
| -----------------------------------------------------------------------|------------------|
| [**Motorola 68000 CPU**](https://en.wikipedia.org/wiki/Motorola_68000) | Main CPU         |
| [**Zilog Z80 CPU**](https://en.wikipedia.org/wiki/Zilog_Z80)           | Sound CPU        |
| [**Yamaha YM3812**](https://en.wikipedia.org/wiki/Yamaha_OPL#OPL2)     | OPL2 Audio       |

### Custom Components

| Chip                            | Function           |
| --------------------------------|--------------------|
| **NEC D65081R077**              | Custom Gate-Array  |
| **12.02 / GXL-02**              | Sprite Counter     |
| **SCU**                         | Sprite Controller  |
| **BCU-02**                      | Tile Map Generator | <br>

# Core Features

### Refresh Rate Compatibility Option

- Video timings can be modified if you experience sync issues with CRT or modern displays; this will alter gameplay from it's original state.

| Refresh Rate      | Timing Parameter     | HTOTAL | VTOTAL |
|-------------------|----------------------|--------|--------|
| 15.56kHz / 55.2Hz | TP-016               | 450    | 282    |
| 15.73kHz / 59.8Hz | NTSC                 | 445    | 264    |

### Audio Options

- There is a toggle to adjust the gain and disable playback of OPL2 audio.

### Overclock Options

- There is a toggle to increase the M68000 frequency from 10MHz to 17.5MHz; this will alter gameplay from it's original state.

### Native Y/C Output

- Native Y/C ouput is possible with the [**analog I/O rev 6.1 pcb**](https://github.com/MiSTer-devel/Main_MiSTer/wiki/IO-Board). Using the following cables, [**HD-15 to BNC cable**](https://www.amazon.com/StarTech-com-Coax-RGBHV-Monitor-Cable/dp/B0033AF5Y0/) will transmit Y/C over the green and red lines. Choose an appropriate adapter to feed [**Y/C (S-Video)**](https://www.amazon.com/MEIRIYFA-Splitter-Extension-Monitors-Transmission/dp/B09N19XZJQ) to your display.

### H/V Adjustments

- There are two H/V toggles, H/V-sync positioning adjust and H/V-sync width adjust. Positioning will move the display for centering on CRT display. The sync width adjust can be used to for sync issues (rolling) without modifying the video timings.

### Scandoubler Options

- Additional toggle to enable the scandoubler without changing ini settings and new scanline option for 100% is available, this draws a black line every other frame. Below is an example.

<table><tr><th>Scandoubler Fx</th><th>Scanlines 25%</th><th>Scanlines 50%</th><th>Scanlines 75%</th><th>Scanlines 100%</th><tr><td><br> <p align="center"><img width="120" height="160" src="FILLME"></td><td><br> <p align="center"><img width="120" height="160" src="FILLME"></td><td><br> <p align="center"><img width="120" height="160" src="FILLME"></td><td><br> <p align="center"><img width="120" height="160" src="FILLME"></td><td><br> <p align="center"><img width="120" height="160" src="FILLME"></td></tr></table>

### Scroll Debug / Level Skip Option

- There is a toggle to enable the third button for "Slow Scroll" in Dash Yarou. You can also skip the level by pressing buttons 1 and 2 simultaneously. See the "PCB Information" section for further information.

# PCB Information / Control Layout

| Title            | Joystick | Service Menu                                                                                               | Dip Switches                                                                                              | Shared Controls | Dip Default | PCB Information |
|------------------|----------|------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------|-----------------|-------------|-----------------|
| **Dash Yarou** | 8-Way    | [**Service Menu**](FILLME) | [**Dip Sheet**](FILLME) | Turn Based              | Upright         | When the "Table Type" dipswitch is toggled to "Upright", Player 1 and Player 2 joystick and buttons are active on the same controller. <br><br> Enabling the "No Death/Stop" dipswitch enables in-game pause by pressing P2 Start; pressing P2 Start returns to game. There is a slow motion debug setting; press P1 and P2 Start simultaneously. The kill player / level skip button combination is button 1 / 2. <br><br> These are mappable inputs. For ease of use, these features are enabled when toggling "Scroll Debug" in the core settings; there is no need to toggle the dipswitch. <br><br> The "Slow Scroll" button (P1/P2 Button 3) is not on hardware; P1 and P2 Start are merged to button 3. |

<br>

### Keyboard Handler

<br>

- Keyboard inputs mapped to mame defaults for Player 1 / Player 2.

<br>

| Services                                                                                                                                                                                           | Coin/Start                                                                                                                                                                                              |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <table> <tr><th>Functions</th><th>Keymap</th></tr><tr><td>Test</td><td>F2</td></tr><tr><td>Reset</td><td>F3</td></tr><tr><td>Service</td><td>9</td></tr><tr><td>Pause</td><td>P</td></tr> </table> | <table><tr><th>Functions</th><th>Keymap</th><tr><tr><td>P1 Start</td><td>1</td></tr><tr><td>P2 Start</td><td>2</td></tr><tr><td>P1 Coin</td><td>5</td></tr><tr><td>P2 Coin</td><td>6</td></tr> </table> |

| Player 1                                                                                                                                                                                                                                                                                             | Player 2                                                                                                                                                                                                                                                                         |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <table> <tr><th>Functions</th><th>Keymap</th></tr><tr><td>P1 Up</td><td>Up</td></tr><tr><td>P1 Down</td><td>Down</td></tr><tr><td>P1 Left</td><td>Left</td></tr><tr><td>P1 Right</td><td>Right</td></tr><tr><td>P1 Bttn 1</td><td>L-CTRL</td></tr><tr><td>P1 Bttn 2</td><td>L-ALT</td></tr> </table> | <table> <tr><th>Functions</th><th>Keymap</th></tr><tr><td>P2 Up</td><td>R</td></tr><tr><td>P2 Down</td><td>F</td></tr><tr><td>P2 Left</td><td>D</td></tr><tr><td>P2 Right</td><td>G</td></tr><tr><td>P2 Bttn 1</td><td>A</td></tr><tr><td>P2 Bttn 2</td><td>S</td></tr> </table> |

# Support

Please consider showing support for this and future projects via [**Darren's Ko-fi**](https://ko-fi.com/darreno) and [**atrac17's Patreon**](https://www.patreon.com/atrac17). While it isn't necessary, it's greatly appreciated.<br>

# Licensing

Contact the author for special licensing needs. Otherwise follow the GPLv2 license attached.
