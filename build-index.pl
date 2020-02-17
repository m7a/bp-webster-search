#!/usr/bin/perl
# https://www.perl.com/article/using-the-right-dictionary-with-perl-and-vim/
open my $dict, '<:encoding(latin1)', '29765-8.txt' or die $!;

my @alphabet = 'A'..'Z';

while (<$dict>) {
  next unless /^$alphabet[0]$/;
  printf "%s => %d\n", shift @alphabet, tell $dict;
  last unless @alphabet;
}
