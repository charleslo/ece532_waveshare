set_param board.repoPaths ./board_files
create_project project_1 ./project_1 -part xc7a100tcsg324-1
set_property board_part digilentinc.com:nexys4_ddr:part0:1.1 [current_project]
add_files -norecurse {./ov5640_capture.v ./simple_top.v}
add_files -fileset constrs_1 -norecurse ./nexys4ddr.xdc
update_compile_order -fileset sources_1
source blockd.tcl
update_compile_order -fileset sources_1
make_wrapper -files [get_files ./project_1/project_1.srcs/sources_1/bd/design_1/design_1.bd] -top
add_files -norecurse ./project_1/project_1.srcs/sources_1/bd/design_1/hdl/design_1_wrapper.v
update_compile_order -fileset sources_1
launch_runs impl_1 -to_step write_bitstream -jobs 2
