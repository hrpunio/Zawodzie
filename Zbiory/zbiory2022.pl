#!/usr/bin/perl
#
use utf8;
binmode(STDOUT, ":utf8");

$f = "zbiory2022.csv";

%Nazwy = ('c' => 'cukinie+kabaczki',
          'cukinia' => 'cukinie+kabaczki',
	  'f' => 'fasola',
	  'fasola' => 'fasola',
	  'fasola_sz' => 'fasola_sz',
	  'buraki' => 'buraki',
	  'burak' => 'buraki',
	  'marchew' => 'marchew',
	  'dynia' => 'dynia',
	  'dynie' => 'dynia',
	  'og' => 'ogórki',
	  'osz' => 'ogórki_szklarniowe',
	  'ogorek_sz' => 'ogórki_szklarniowe',
	  'p' => 'pomidory',
	  'pomidor' => 'pomidory',
	  'pomidory' => 'pomidory',
	  'pap' => 'papryka',
	  'papryka' => 'papryka',
	  't' => 'truskawki',
	  'truskawka' => 'truskawki',
	  'groszek' => 'groszek',
	  'grosz' => 'groszek',
	 );
open (O, $f) || die "cannot open $f!\n";

while (<O>) {
  if ($_ =~ /waga/ )  { next}
  if ($_ !~ /[0-9]/ ) { next}

  chomp($_);

  $_ =~ s/ //g;

  ($ile, $kiedy, $co) = split /;/, $_;
  $I{$Nazwy{$co}} += $ile;
  $total += $ile;

  $kiedy =~ s/[\)\(]//g;
  ($dzien, $mc) = split /\./, $kiedy;

  $mc = sprintf "%02i", $mc;
  $dzien = sprintf "%02i", $dzien;
  $K{"${mc}/${dzien}"} += $ile;

}

close ($f);

for $c (sort keys %I ) {
   printf "%11.11s = %6.2f\n", $c, $I{$c};
}

print "------------------------\n";
printf "Razem       =  %.2f kg\n", $total;


print "===\n";

for $k (sort keys %K ) {
   $totalDaily += $K{$k};
   print "$k $K{$k} $totalDaily\n"
}

