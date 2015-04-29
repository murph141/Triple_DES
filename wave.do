onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_TopLevel/HCLK
add wave -noupdate /tb_TopLevel/HRESET
add wave -noupdate /tb_TopLevel/HMASTLOCK
add wave -noupdate /tb_TopLevel/HREADY
add wave -noupdate /tb_TopLevel/HRESP
add wave -noupdate /tb_TopLevel/HSEL
add wave -noupdate /tb_TopLevel/HWRITE
add wave -noupdate /tb_TopLevel/HTRANS
add wave -noupdate /tb_TopLevel/HBURST
add wave -noupdate /tb_TopLevel/HSIZE
add wave -noupdate /tb_TopLevel/HPROT
add wave -noupdate -radix hexadecimal /tb_TopLevel/HADDR
add wave -noupdate -radix hexadecimal /tb_TopLevel/DUT/A0/pastAddress
add wave -noupdate -radix hexadecimal /tb_TopLevel/HRDATA
add wave -noupdate -radix hexadecimal /tb_TopLevel/HWDATA
add wave -noupdate -radix hexadecimal /tb_TopLevel/data
add wave -noupdate -radix hexadecimal /tb_TopLevel/key1
add wave -noupdate -radix hexadecimal /tb_TopLevel/key2
add wave -noupdate -radix hexadecimal /tb_TopLevel/key3
add wave -noupdate -radix hexadecimal /tb_TopLevel/outputData
add wave -noupdate /tb_TopLevel/enable
add wave -noupdate /tb_TopLevel/encryptionType
add wave -noupdate /tb_TopLevel/DUT/A0/nextEnable
add wave -noupdate /tb_TopLevel/DUT/A0/enable
add wave -noupdate /tb_TopLevel/DUT/A0/encryptionType
add wave -noupdate -radix hexadecimal /tb_TopLevel/DUT/A0/key1
add wave -noupdate -radix hexadecimal /tb_TopLevel/DUT/A0/key2
add wave -noupdate -radix hexadecimal /tb_TopLevel/DUT/A0/key3
add wave -noupdate -radix hexadecimal /tb_TopLevel/DUT/A0/data
add wave -noupdate /tb_TopLevel/DUT/A0/HRESP
add wave -noupdate -radix hexadecimal /tb_TopLevel/DUT/A0/HRDATA
add wave -noupdate /tb_TopLevel/DUT/A0/pastWrite
add wave -noupdate -radix hexadecimal /tb_TopLevel/DUT/A0/oldKey1
add wave -noupdate -radix hexadecimal /tb_TopLevel/DUT/A0/oldKey2
add wave -noupdate -radix hexadecimal /tb_TopLevel/DUT/A0/oldKey3
add wave -noupdate -radix hexadecimal /tb_TopLevel/DUT/A0/oldData
add wave -noupdate /tb_TopLevel/DUT/A0/oldEncryptionType
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {29359 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 201
configure wave -valuecolwidth 103
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
WaveRestoreZoom {0 ps} {217875 ps}
