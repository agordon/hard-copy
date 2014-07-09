#!/bin/sh

## Copyright (C) 2014 by Assaf Gordon (assafgordon@gmail.com)
## LICENSE: MIT
## More information: https://github.com/agordon/hard-copy

##
## Generates a PDF file containing a hard-copy of important data
## (e.g. a private key file)
##

# QR Version 17 = 85x85 modules
QR_VERSION=17
QR_WIDTH_MODULES=85
QR_QUALITY=M
# Count of 8-bit numbers storable in version 17,Quality 'M'
QR_BYTES_PER_IMAGE=500
# 6 pixels per module
QR_MODULE_SIZE=6
QR_PNG_DPI=300
# Default margin = 4 modules
QR_MARGIN=4
QR_IMAGE_PIXELS=$(( (QR_WIDTH_MODULES + QR_MARGIN * 2)*QR_MODULE_SIZE ))

# Global variable, set by 'ask_for_password()'
GPG_PASSWORD=""

## Terminate with an error message and non-zero exit code
die()
{
	NAME=$(basename "$0")
	echo "$NAME: error: $@" >&2
	exit 1
}


## Use the old 'cksum' utility to calculate a checksum
## on EACH LINE of STDIN.
cksum_line()
{
while read n
do
	CKSUM=$(printf "%s" "$n" | tr -d ' ' | cksum)
	# NOTE: $CKSUM contains two values, and is NOT quoted.
	#       After field splitting it will provide two parameters to 'printf'
	printf "%-84s %12s %3s\n" "$n" $CKSUM
done
}


## Ask for a password (twice) directly from the controlling terminal,
## bypassing any STDIN redirection. If there's no terminal available,
## exit with an error.
## NOTE: Sets a global variable 'GPG_PASSWORD' .
ask_for_password()
{
	if ! test -t 0 </dev/tty ; then
		echo "Error: can't find terminal (/dev/tty) to ask for a password" >&2
		exit 1
	fi
	SAVE=$(stty -g </dev/tty)
	stty -echo </dev/tty
	printf "NOTE!\nThe following password will be required to restore the original file.\n" >/dev/tty
	printf "     KEEP IT SAFE. DO NOT FORGET IT...\n" >/dev/tty
	printf "Enter password: " >/dev/tty
	read -r PASS1 </dev/tty || die "password not entered, canceling"
	printf "\n" >/dev/tty
	printf "Repeat password: " >/dev/tty
	read -r PASS2 </dev/tty || die "password not entered, canceling"
	printf "\n" >/dev/tty
	stty "$SAVE" </dev/tty

	[ -z "$PASS1" ] && die "empty passwords are not allowed"
	[ "$PASS1" = "$PASS2" ] || die "Passwords do not match"

	#TODO:
	# Protect against tricky-passwords (e.g. non-ascii, UTF-8, ^M, etc.)
	# BUT WITHOUT exposing the password in an executed program.

	GPG_PASSWORD="$PASS1"
}

## Encrypts STDIN to STDOUT, using gpg v1, symmetric encryption,
## with the password given previously by the user.
gpg_encrypt()
{
	gpg --quiet --batch --yes --no-tty -c --passphrase-fd=4 4<<EOF
$GPG_PASSWORD
EOF
}

## Encodes STDIN to STDOUT in Base64, using fixed output width of 65 chars.
encode_base64()
{
	base64 --wrap=65
}

## Reads lines from STDIN, prints to STDOUT, removes any whitespace,
## then inserts a space every 5 charaeters. Example:
##     $ echo "helloworldaaabbb" | split_fifths
##     hello world aaabb b
##
split_fifths()
{
	while read a
	do
		echo "$a" | tr -d ' \t\n' | sed 's/\(.....\)/\1 /g'
		printf "\n"
	done
}

## Reads lines from STDIN, prints to STDOUT, adds a 3-digit line number
## prefix to every line.  Example:
##   $ printf "hello\nworld\n" | add_lines
##   001 hello
##   002 world
add_lines()
{
	awk '{ printf "%03d ", NR ; print $_ }'
}

## Creates QR-Code images from STDIN .
## STDIN is assumed to be textual (with line-endings).
## STDIN will be split into several smaller files (each upto '$QR_BYTES_PER_IMAGE
## bytes in size), then a QR-Code image will be created from each chunk.
## PNG files will be created in the current directory.
## Example (creating qr_images for 2000 bytes of data):
##    $ seq 1000 | head --bytes 2000 | create_qr_images
## Will create:
##    qr_001.png
##    qr_002.png
##    qr_003.png
##    qr_004.png
## Each file with a QR-Code encoding 500 bytes of the input data.
create_qr_images()
{
	QR_COMMAND="qrencode -s $QR_MODULE_SIZE -v $QR_VERSION -d $QR_PNG_DPI -l $QR_QUALITY -t PNG -o qr_\$FILE.png"
	split -C "$QR_BYTES_PER_IMAGE" --numeric-suffixes=1 --filter="$QR_COMMAND" - 0
}

## Generates a LATEX file (to STDOUT),
## which includes the encoded base64/gpg'd file,
## all the QR-Code images, and decoding instructions.
create_latex()
{
	COUNT=$1
	TEXT=$2
	ENCODED_MD5=$3
	ENCODED_SHA256=$4
	ORIG_FILE_NAME=$5
	ORIG_MD5=$6
	ORIG_SHA256=$7
	ENCRYPTED=$8

	echo "\\\\documentclass{report}
\\\\usepackage{datetime}
\\\\usepackage{fancyhdr}
\\\\usepackage{graphicx}
\\\\usepackage[margin=2cm]{geometry}
\\\\usepackage{subcaption}
\\\\usepackage{upquote} % to convert funny quotes to straight quotes
\\\\usepackage{bera}
\\\\usepackage{lastpage}
\\\\usepackage{datetime}
\\\\usepackage{hyperref}

\\\\pagestyle{fancy}

\\\\lhead{Encoding of file \\\\texttt{$ORIG_FILE_NAME}}
\\\\rhead{Generated on \\\\today}

\\\\lfoot{\\\\thepage\\\\ of \\\\pageref{LastPage}}
\\\\cfoot{}
\\\\rfoot{Created with \\\\textsf{Hard-Copy} by A. Gordon ~ ~ \\\\url{https://github.com/agordon/hard-copy}}


\\\\begin{document}

\\\\section*{Hard-Copy of \\\\texttt{$ORIG_FILE_NAME}}

Below is the \\\\texttt{base64} encoded content of \\\\texttt{$ORIG_FILE_NAME}.

\\\\footnotesize
\\\\begin{verbatim}
$TEXT
\\\\end{verbatim}
\\\\small

If you need to type it manually, enter the first number (line number),
and the 5-letter-words in each line in a file named \\\\texttt{restore.txt}.
Then follow the decoding instructions starting at \\\\textbf{step 4}.

\\\\newpage

\\\\section*{Decoding Instructions}

To restore the content of \\\\texttt{$ORIG_FILE_NAME} using the QR-code images below,
follow these instructions:
\\\\begin{enumerate}

\\\\item Use a QR-Code decoder software to extract the text from each image.

\\\\begin{enumerate}

\\\\item If the page is clean and flat (i.e. not stained or crimpled), try to
scan the entire page using a scanner (using at least 300 DPI black/white settings).
Save the scanned document as JPG.

\\\\item Alternatively, take a picture of each QR-Code square (e.g. using a mobile
phone's camera) and save it as a JPG file. When taking each picture, ensure the
QR-Code square is in focus, and as flat and straight as possible.

\\\\item Use \\\\texttt{zbarimg} (or other QR-Code software) to decode text from the images.
Using multiple images is fine (order of images doesn't matter, since the decoded text will
be sorted by line numbers):
\\\\begin{verbatim}
$ zbarimg -q --raw *.jpg | \\\\
          grep -v '^$' | \\\\
          sort -k1n,1 > restore.txt
\\\\end{verbatim}

\\\\item If the page is crimpled or stained, a desktop QR-Code images might not
be able to decode the QR-Code. As a fall-back, try to use one of the many free QR-Decoder
apps available for mobile phones. These apps can sometimes
extract text from a messy QR-Code (as they repeatedly try to refocus and decode the
image shown in their view-finder). When these app extract the text,
manually add the text to a file named \\\\texttt{restore.txt}.

\\\\end{enumerate}

\\\\item The \\\\texttt{restore.txt} file should contain the same information as shown
in the previous page (line numbers and groups of 5 letters, without the checksums).

\\\\item Verify the restored text (compare with the values shown below):
\\\\begin{verbatim}
$ md5sum < restore.txt
$ENCODED_MD5

$ sha256sum < restore.txt
$ENCODED_SHA256
\\\\end{verbatim}

\\\\item \\\\textbf{if} the checksums above don't match, or if you've entered 
file's content manually, or if some of the QR-Code images failed to decode and some lines are missing, calculate checksum on each line, and manually correct the offending/missing lines:
\\\\begin{verbatim}
$ cat restore.txt | \\\\
     while read n ; do
        printf \"%s\\\\t\" \"\$n\" ;
        printf \"%s\" \"\$n\" | tr -d ' ' | cksum ;
     done
\\\\end{verbatim}
The last two numbers in each line are the checksum and number-of-characters.
They should match the values shown in the previous page.

\\\\item Decode the file (remove the line numbers, whitespace, then decode with base64):

\\\\begin{verbatim}
$ cut -c4- restore.txt | tr -d ' ' | base64 -d > $ORIG_FILE_NAME
\\\\end{verbatim}

\\\\item Verify the original file's content:
\\\\begin{verbatim}
$ md5sum < $ORIG_FILE_NAME
$ORIG_MD5

$ sha256sum < $ORIG_FILE_NAME
$ORIG_SHA256
\\\\end{verbatim}
"

## If the file is encrypted by this script,
## mention an additional decryption step.
if [ ! -z "$ENCRYPTED" ] ; then
	echo "
\\\\item Decrypt the file:
\\\\begin{verbatim}
$ gpg -d $ORIG_FILE_NAME
Enter passphrase: [********]
\\\\end{verbatim}
"
fi

echo "
\\\\end{enumerate}

\\\\newpage

These are the QR-Code images of the encoded content of \\\\texttt{$ORIG_FILE_NAME}.
Follow the decoding instructions to restore the file's content.

\\\\begin{figure}
"
	col=1
	for i in $(seq 1 $COUNT) ;
	do
		PNG_NUM=$(printf "%03d" $i)
		echo "    \\\\begin{subfigure}[b]{0.30\\\\textwidth}%
	\\\\centering%
       \\\\includegraphics[]{qr_${PNG_NUM}.png} \\
       $i~of~$COUNT%
    \\\\end{subfigure}"
		col=$((col+1))
		if [ "$col" -eq 4 ]; then
			col=1
			echo "
\\\\end{figure}
\\\\begin{figure}
"
		fi
	done

	echo "
\\\\end{figure}
\\\\end{document}
"
}


show_help_and_exit()
{
BASE=$(basename "$0")
cat<<EOF
Hard-Copy: Generates PDF for saving hard-copies of important data
           (Using QR-Codes for easy restoration)

Copyright (C) 2014 by Assaf Gordon (assafgordon@gmail.com)
LICENSE: MIT
More information: https://github.com/agordon/hard-copy

Usage:
   $BASE [OPTIONS] FILE

Options:
   -c    =  Store FILE in the clear (as-is), do not encrypt.
            Default operation is to ask for a password and encrypt the file
            using gpg.
   -t    =  Save temporary files. The name of the temporary directory will
            be printed to STDOUT when the script is done.
   -h    =  This help screen.

This script will read 'FILE', and generate 'FILE.pdf' .

EOF
exit 0
}


##################################################################
### Script starts here
##################################################################

##
## Command-line argument processing
##
show_help=
encrypt=y
save_temp=

while getopts cth name
do
	case $name in
	## Clear-text - don't encrypt
	c)	encrypt=
		;;
	t)	save_temp=y
		;;
	h)	show_help=y
		;;
	?)	die "Try -h for help."
	esac
done
[ ! -z "$show_help" ] && show_help_and_exit;

shift $(($OPTIND - 1))
INPUT=$1
[ -z "$INPUT" ] && die "missing input file name. Try -h for help."



##
## Processing starts here.
##
[ ! -z "$encrypt" ] && ask_for_password

DIR=$(mktemp -d --tmpdir hardcopy.XXXXXXX)

if [ -z "$encrypt" ]; then
	# No encryption - use original file as-is
	cp "$INPUT" "$DIR/input" || die "copying original input failed"
else
	cp "$INPUT" "$DIR/input.unencrypted" || die "copying original input failed"
fi

## Change directory to temporary working directory.
## From now on, all operations are on temporary files in the 'current' directory.
OLDDIR=$PWD
cd "$DIR" || die "failed to CD to working directory '$DIR'"

if [ ! -z "$encrypt" ]; then
	gpg_encrypt < "input.unencrypted" > "input" || die "gpg encryption failed"
fi

MD5_ORIG=$(cat "input" | md5sum) || die "md5sum failed"
SHA256_ORIG=$(cat "input" | sha256sum) || die "sha256 failed"

encode_base64 < "input" > "input.base64.txt" || die "base64 failed"

split_fifths  < "input.base64.txt" > "input.fifths.txt" || die "5-leeter split failed"

add_lines < "input.fifths.txt" > "input.lines.txt" || die "adding numbered lines failed"

MD5_LINES=$(cat "input.lines.txt" | md5sum) || die "md5sum failed"
SHA256_LINES=$(cat "input.lines.txt" | sha256sum) || die "sha256 failed"

cksum_line < "input.lines.txt" > "input.cksum.txt" || die "check-summing failed"

create_qr_images < "input.lines.txt" || die "Creating QR-Code images failed"
NUM_IMAGES=$(ls qr*.png | wc -l) || die "failed to count number of QR images"

CKSUM_DATA=$(cat "input.cksum.txt") || die "failed to read cksum data"

ORIG_FILE_NAME=$(basename "$INPUT")
[ ! -z "$encrypt" ] && ORIG_FILE_NAME="$ORIG_FILE_NAME.gpg"

create_latex "$NUM_IMAGES" "$CKSUM_DATA" "$MD5_LINES" "$SHA256_LINES" \
	     "$ORIG_FILE_NAME" "$MD5_ORIG" "$SHA256_ORIG" \
	     "$encrypt" > "input.tex" \
		|| die "creating TEX file failed"

## Run 'pdflatex' twice, because we use 'page numbers' which requires
## a second run.
for i in 1 2 ; do
	pdflatex -interaction=batchmode \
		 -halt-on-error \
		"input.tex" || die "pdflatex (run $i) failed on $DIR/input.tex"
done

## Processing done - return to original directory
cd "$OLDDIR"

## Copy final PDF file to current directory
PDF="./$(basename "$INPUT").pdf"
cp "$DIR/input.pdf" "$PDF"  || die "copying final PDF failed"

## Clear temporary files if needed
if [ -z "$save_temp" ]; then
	rm -r "$DIR" || die "failed to clean-up temporary directory $DIR"
else
	echo "Temporary files are saved in $DIR"
fi

