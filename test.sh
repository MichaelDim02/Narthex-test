#!/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

test_command () {
	hash=$($1 | ${2} | md5sum | cut -d' ' -f1)

	if [ "$hash" == ${3} ]; then
		printf "${GREEN}[+] OK:${NC} ${2}\n"
	else
		printf "${RED}[!] FAILED:${NC} ${2}\n"
	fi
}

echo "Testing ninc"
test_command "echo -e a\nb"	"ninc 1 2"		"aee6e812fa70111e386f1aa5ad1b1ad4"
test_command "echo -e a\nb\n2"	"ninc 1 2"		"f1688266d10432a86850e81adcee06b8"
test_command "echo -e a\nb\n2"	"ninc -n 1 2"		"f7450b5a2c9a3f6e302339e7e0a15000"
test_command "echo -e a\nb"	"ninc 1 2 -d .:"	"70b5d7d876eb8305547ea9b514f70eb3"

echo -e "\nTesting nhance"
test_command "echo -e aa\nbb"	"nhance"		"99b02b4852b269e081bb2fad5c7252b0"
test_command "echo -e aa\nbb"	"nhance -f"		"ca8492ad34f21ec4a1542724844388be"

echo -e "\nTesting ncom"
test_command "echo -e a\nb"	"ncom"			"51a85671317927784219535440355d6b"
test_command "echo -e a\nb"	"ncom -d .:"		"2b5c519d1b72f6aadffe4f270b2552f0"
test_command "echo -e a\nb\n2"	"ncom"			"8f8e96d33d4ac52e3f05eb96850ca771"
test_command "echo -e a\nb\n2"	"ncom -n"		"2346353f5608b6818e28884f39ce9823"
test_command "echo -e a\nb\n2"	"ncom -b"		"7132a24bb66c632beedbae04141b417a"

echo -e "\nTesting napp"
test_command "echo -e a\nb"	"napp -c cd"		"d46d7f663729565c892c44c50166f030"
test_command "echo -e a\nb"	"napp -c cd -f"		"241bf9f51ac4419778a0bd1df2fb9bca"
test_command "echo -e a\nb"	"napp -c cd -s"		"97aca28a92af73fec7565456035dde7d"
echo -e "c\nd" > test1.txt
test_command "echo -e a\nb"	"napp -w test1.txt"	"d46d7f663729565c892c44c50166f030"
test_command "echo -e a\nb"	"napp -w test1.txt -f"	"241bf9f51ac4419778a0bd1df2fb9bca"
test_command "echo -e a\nb"	"napp -w test1.txt -s"	"97aca28a92af73fec7565456035dde7d"
rm test1.txt

echo -e "\nTesting nleet"
test_command "echo -e a\nb"	"nleet"			"7990504f02b00a8045b5cd2752e773de"
test_command "echo -e a\ne\nc"	"nleet"			"be92c2647733cdb973a953b37b8e6e03"
test_command "echo -e a\ne\nc"	"nleet e:3"		"c0fd48c787c16890fa86a5fd440812de"
test_command "echo -e a\ne\ni"	"nleet e:3 a:@"		"dbe4fb4d4b7104c9010cd14191aa790d"

echo -e "\nTesting nrev"
test_command "echo -e ab\nel"	"nrev"			"ca72652b1ee0ed271c8b88f1f536307e"
test_command "echo -e a\ne"	"nrev"			"52edd9fb52756053c2d606bd8753e627"

echo -e "\nTesting nclean"
test_command "echo -e A\nb"	"nclean -c"		"bf072e9119077b4e76437a93986787ef"
test_command "echo -e 1\nb"	"nclean -n"		"b026324c6904b2a9cb4b88d6d61c81d1"
test_command "echo -e a\n#b"	"nclean -s"		"54eede55d7d99c4a3c50d71104de8f5a"
test_command "echo -e a\n#b"	"nclean -l 2"		"54eede55d7d99c4a3c50d71104de8f5a"
