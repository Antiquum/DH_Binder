# Sample tk program for Perl2Exe

use Tk;
use Tk::Label;
use Tk::DummyEncode;
#perl2exe_include utf8;
#perl2exe_include "unicore/lib/gc_sc/Word.pl";
#perl2exe_include "unicore/lib/gc_sc/Digit.pl";
#perl2exe_include "unicore/lib/gc_sc/SpacePer.pl";
#perl2exe_include "unicore/lib/gc_sc/Uppercas.pl";
#perl2exe_include "unicore/To/Lower.pl";

my $main = new MainWindow;
$main->Label(-text => 'Tk sample')->pack();

my $name_w = $main->Entry(-width => 20)->pack(-padx => 30);

$main->Button(-text => 'Ok', -command => sub{do_ok($name_w)} )
->pack(-side => 'left', -padx => 30);

$main->Button(-text => 'Close', -command => sub{do_close()} )
->pack(-side => 'right', -padx => 30);


MainLoop;

sub do_ok {
    my ($name_w) = @_;
    my $name_val = $name_w->get;
    print "You entered $name_val\n";
}

sub do_close {
    exit;
}
