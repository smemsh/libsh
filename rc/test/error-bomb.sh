#

source ../include
require bomb

eatmyshorts	() { bomb "you are messed up"; }
foobar		() { eatmyshorts; }
testfunc	() { foobar; }
main		() { testfunc; }

main
