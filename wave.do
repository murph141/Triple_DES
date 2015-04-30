onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_TopLevel_top/HCLK
add wave -noupdate /tb_TopLevel_top/HRESET
add wave -noupdate /tb_TopLevel_top/HMASTLOCK
add wave -noupdate /tb_TopLevel_top/HREADY
add wave -noupdate /tb_TopLevel_top/HRESP
add wave -noupdate /tb_TopLevel_top/HSEL
add wave -noupdate /tb_TopLevel_top/HWRITE
add wave -noupdate /tb_TopLevel_top/HTRANS
add wave -noupdate /tb_TopLevel_top/HBURST
add wave -noupdate /tb_TopLevel_top/HSIZE
add wave -noupdate /tb_TopLevel_top/HPROT
add wave -noupdate -radix hexadecimal /tb_TopLevel_top/HADDR
add wave -noupdate -radix hexadecimal /tb_TopLevel_top/HWDATA
add wave -noupdate -radix hexadecimal /tb_TopLevel_top/DUT/outputData
add wave -noupdate -radix hexadecimal /tb_TopLevel_top/DUT/HRDATA
add wave -noupdate -radix hexadecimal /tb_TopLevel_top/encryptedChunk
add wave -noupdate /tb_TopLevel_top/DUT/outputEnable
add wave -noupdate /tb_TopLevel_top/DUT/enable
add wave -noupdate /tb_TopLevel_top/DUT/encryptionType
add wave -noupdate -radix hexadecimal /tb_TopLevel_top/DUT/key1
add wave -noupdate -radix hexadecimal /tb_TopLevel_top/DUT/key2
add wave -noupdate -radix hexadecimal /tb_TopLevel_top/DUT/key3
add wave -noupdate -radix hexadecimal /tb_TopLevel_top/DUT/data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {28500 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 260
configure wave -valuecolwidth 115
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
WaveRestoreZoom {0 ps} {720579 ps}
