# sp_bram

> **version: 1.0**

Single port BRAM. VHDL and Verilog versions.

### Catalogs structure:
- **sp_bram_verilog** - sp_bram verilog version;
  - **hdl** - verilog files;
  - **sim** - script files for modelsim/questasim;
  - **tb** - testbenches;
- **sp_bram_vhdl** - sp_bram vhdl version;
  - **hdl** - vhdl files;
  - **sim** - script files for modelsim/questasim;
  - **tb** - testbenches.

:exclamation: To set the BRAM address width and data width, you must specify **ADDRESS_WIDTH** and **DATA_WIDTH** parameters
in the top project file (**sp_bram.vhd** or **sp_bram.v**).

:exclamation: The external file initializing the BRAM needs to be in bit vector form. External files in integer or hex format
do not work.
