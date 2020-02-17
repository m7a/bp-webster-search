#!/usr/bin/perl
# https://raw.githubusercontent.com/dnmfarrell/WebsterSearch/master/webster-search.pl
use strict;
use warnings;
use Encode 'encode';
my $search_term = uc join(' ',@ARGV) . "\n";
my $entry_pattern = qr/^[A-Z][A-Z0-9' ;-]*$/;
my $search_pattern = qr/^$search_term/;

my %index = (
#<<<INDEX>>>
);

my @script_path = split '/', $0;
pop @script_path;
#my $dictionary_path = join '/',  @script_path, 'webster-1913.txt';
my $dictionary_path = "/usr/share/mdvl-websters-dictionary/29765-8.txt";
open my $dict, '<:encoding(latin1)', $dictionary_path or die $!;
my $start = $index{ substr $search_term, 0, 1 };
seek $dict, $start, 0;

my $found_match = undef;
while (<$dict>) {
  next unless $_ =~ $entry_pattern;

  if ($_ =~ $search_term) {
    my $output = $_;
    while (1) {
     my $next_line = readline $dict;
     if ($next_line =~ /$entry_pattern/) {
       seek $dict, -length($next_line), 1;
       last;
     }
     $output .= $next_line;
    }
    print encode('UTF-8', $output);
    $found_match = 1;
  }
  last if $found_match && ($search_term cmp $_) == -1;
}
