#
# invoke like:
#
# 	(bash rc-rcinit.sh -c cl_thisfile)
#
##############################################################################

source ../include
include rc
require get_invocation_name

RCPREFIX=foo_

#
rcset a testa		:		"name of the alpha test"
rcset b testb		:testbdef	"what beta test to use"
rcset c testc		:defaultc	"use which charlie"
rcset d testd		1		"use the delta test"

rcset t this_is_test	:foobar "

	this is a test of the emergency broadcast system.
	this is only a test.  in the event of a real
	emergency you would surely be dead already.
"
rcset y another_test	:deaddead "

	this is another test of the emergency broadcast
	system.  this is only a test.  in the event of a
	real emergency you would surely be dead already.
"

rcsetusage \
	$(get_invocation_name) \
	"this is the usage summary line" "

	This is the usage description.  It's only on tuesday
	that we want to fend off dragons and even then,
	only if they let us.  This tool if used correctly
	will prevent premature brain damage.



	Walking and flying away, the birds will sing another
	day.
"

#rcset z

tmpfile=$(mktemp)
cat <<- HERE > $tmpfile
	
	testa	foo
	testb	rcfile_override
	testc	rc_override

	this_is_test yessir
	
	#testa
	#testd	rc_override_d ## #
	testd	0
	     
	
HERE

#
RCFILE=$tmpfile
rcinit "$@"

#
for var in $(compgen -A variable $RCPREFIX); do
	echo "$var: ${!var}"
done

#
echo "remaining: ${RCARGS[@]}"

echo "============ USAGE =============="

rcusage

