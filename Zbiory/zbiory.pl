#!/usr/bin/perl
#
use Getopt::Long;

use utf8;
binmode(STDOUT, ":utf8");

##my $e = "zbiory2023.csv"; ## poprzedni
my $USAGE = "** zbiory.pl -y YEAR\n";
my $Year = "2024";

GetOptions( "y=s"  => \$Year,
            "help|?" => \$showhelp,
);
if ( $showhelp ) { die $USAGE  ;  }
if ( $showhelp ) { die $USAGE  ;  }

$f = "zbiory${Year}.csv";

print STDERR "** Input file $f\n";

%Nazwy = ('c' => 'cukinie+kabaczki',
          'cukinia' => 'cukinie+kabaczki',
           ## fasola szparagowa
	  'f' => 'fasola_szpr',
	  'fasola' => 'fasola_szpr',
           ## fasola_suche_ziarno
	  'fasola_sz' => 'fasola_sz',
           ##
	  'buraki' => 'buraki',
	  'burak' => 'buraki',
	  'marchew' => 'marchew',
	  'dynia' => 'dynia',
	  'dynie' => 'dynia',
	  'og' => 'ogórki',
	  'ogórek' => 'ogórki',
	  'ogorek' => 'ogórki',
	  'osz' => 'ogórki_szklarniowe',
	  'ogorek_sz' => 'ogórki_szklarniowe',
	  'p' => 'pomidory',
	  'pomidor' => 'pomidory',
	  'pomidory' => 'pomidory',
	  'pomidor_d' => 'pomidory', ## pomidory przed blokiem
	  'pomidor_k' => 'pomidory_k', ## pomidory przed blokiem (koktajlowy)
	  'pap' => 'papryka',
	  'papryka' => 'papryka',
	  't' => 'truskawki',
	  'truskawka' => 'truskawki',
	  'groszek' => 'groszek',
	  'grosz' => 'groszek',
	  'czosnek' => 'czosnek',
	  'cebula' => 'cebula',
	  'skorzonera' => 'skorzonera',
	 );
#open (O, $e) || die "cannot open $e!\n";
#
#$today_mc = `date "+%m"`;
#$today_day = `date "+%d"`;
#$today = sprintf ("%02i/%02i", $today_mc, $today_day);
#print "------------------------\n";
#print "TODAY IS: $today\n";
#print "------------------------\n";
#
#while (<O>) {
#  if ($_ =~ /waga/ )  { next}
#  if ($_ !~ /[0-9]/ ) { next}
#  chomp($_);
#  $_ =~ s/ //g;
#  ($ile, $kiedy, $co) = split /;/, $_;
#  $kiedy =~ s/[\)\(]//g;
#  ($dzien, $mc) = split /\./, $kiedy;
#
#  $mc = sprintf "%02i", $mc;
#  $dzien = sprintf "%02i", $dzien;
#  $total_x += $ile ;
#  $K{"${mc}/${dzien}"} = $total_x;
#}
#
#close(O);
#
##################

open (O, $f) || die "cannot open $f!\n";

while (<O>) {
  if ($_ =~ /waga/ || $_ =~ /^#/)  { next}
  if ($_ !~ /[0-9]/ ) { next}

  chomp($_);

  $_ =~ s/ //g;

  ($ile, $kiedy, $co) = split /;/, $_;
  $I{$Nazwy{$co}} += $ile;
  $total += $ile;

}

close ($f);

for $c (sort keys %I ) {
   printf "%11.11s = %6.2f\n", $c, $I{$c};
}

print "------------------------\n";
printf "Razem       =  %.2f kg\n", $total;

## compare

#$flag = 0;
#($d0, $m0) = split /\//, $today;
#
#for $md (sort keys %K) {
#   ($d1, $m1) = split /\//, $md;
#    ###print "$d1 $m1 $today\n";
#    if ($d1 >= $d0 && $m1 >= $m0) {$flag = 1;  }
#    if ($flag > 0 ) {
#      if (exists $K{$md} ) {
#         print "$e: \@ $md = $K{$md} kg\n";
#         printf "różnica = %.1f kg\n", $total - $K{$md};
#         print "------------------------\n";
#	 exit;
#      }
#
#    }
#}
#
