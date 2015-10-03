#!/usr/bin/perl

print "This is test.pl\n";
print "ARGV = ", join(" ", @ARGV), "\n";

print "Script path \$0 = $0\n";
print "Exe path \$^X = $^X\n";

print "\@INC=\n", join("\n", @INC), "\n";
sleep (1);
