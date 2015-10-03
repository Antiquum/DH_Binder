#!/usr/local/bin/perl

#perl2exe_exclude "Compress/Bzip2.pm";

use LWP::UserAgent;

my $URL = $ARGV[0] || 'http://www.cnn.com';
print "Fetching $URL ...\n";

$ua = new LWP::UserAgent;
$req = new HTTP::Request 'GET' => "$URL";
$res = $ua->request($req);

if ($res->is_success) {
  #print ($res->content);
  printf "fetched %d bytes\n", length($res->content);
} else {
  print "Error: " . $res->code . " " . $res->message;
}


