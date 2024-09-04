#!/usr/bin/env perl

use warnings;
use strict;
use utf8;

binmode(STDOUT, ':utf8');

my $filename = @ARGV ? $ARGV[0] : die "Usage: $0 <filename>\n";

open(my $in, '<:encoding(UTF-8)', $filename) or die $!;
read $in, my $text, -s $in;

my @chars = split //, $text;
my %patterns = ();

for (my $i = 0; $i < $#chars; $i++) {
    my $curr = "";
    foreach (@chars[$i..$#chars]) {
        $curr .= $_;
        last if length($curr) > 13 or /[^一-龯ぁ-んァ-ン]/;
        next if length($curr) == 1 && /[ぁ-んァ-ン]/;
        $patterns{$curr} = 0 if ! exists $patterns{$curr};
        $patterns{$curr}++;
    }
}

foreach (sort { $patterns{$a} <=> $patterns{$b}} keys %patterns) {
    my $val = $patterns{$_};
    print "$_ = $val\n" if $val > 1 && !(length == 1 && /[ぁ-んァ-ン]/);
}
