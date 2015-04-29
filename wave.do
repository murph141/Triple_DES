onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_TopLevel/HCLK
add wave -noupdate /tb_TopLevel/HRESET
add wave -noupdate /tb_TopLevel/HREADY
add wave -noupdate /tb_TopLevel/HRESP
add wave -noupdate /tb_TopLevel/HSEL
add wave -noupdate /tb_TopLevel/HWRITE
add wave -noupdate /tb_TopLevel/DUT/A0/pastWrite
add wave -noupdate -radix hexadecimal /tb_TopLevel/HADDR
add wave -noupdate -radix hexadecimal /tb_TopLevel/DUT/A0/pastAddress
add wave -noupdate -radix hexadecimal /tb_TopLevel/HRDATA
add wave -noupdate -radix hexadecimal /tb_TopLevel/encryptedChunk
add wave -noupdate -radix hexadecimal /tb_TopLevel/HWDATA
add wave -noupdate /tb_TopLevel/DUT/outputEnable
add wave -noupdate /tb_TopLevel/DUT/A0/nextEnable
add wave -noupdate /tb_TopLevel/DUT/A0/enable
add wave -noupdate /tb_TopLevel/DUT/encryptionType
add wave -noupdate -radix hexadecimal /tb_TopLevel/DUT/key1
add wave -noupdate -radix hexadecimal /tb_TopLevel/DUT/key2
add wave -noupdate -radix hexadecimal /tb_TopLevel/DUT/key3
add wave -noupdate -radix hexadecimal /tb_TopLevel/DUT/data
add wave -noupdate /tb_TopLevel/DUT/T0/early_done
add wave -noupdate /tb_TopLevel/DUT/T0/done
add wave -noupdate /tb_TopLevel/DUT/T0/enable_DES2
add wave -noupdate /tb_TopLevel/DUT/T0/enable_DES3
add wave -noupdate -radix hexadecimal /tb_TopLevel/DUT/T0/output_data_block1
add wave -noupdate -radix hexadecimal /tb_TopLevel/DUT/T0/output_data_block2
add wave -noupdate -radix hexadecimal /tb_TopLevel/DUT/T0/output_data_block
add wave -noupdate -radix hexadecimal /tb_TopLevel/DUT/outputData
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {79589 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 275
configure wave -valuecolwidth 117
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {553875 ps}
