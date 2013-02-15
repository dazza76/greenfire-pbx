#!/usr/bin/perl
use strict;

my $result= `/usr/sbin/asterisk -rx "sip show peers"`;

my @lines = split /\n/,$result;
my $handsets =();
foreach my $line (@lines)
{
my ($peer) = split /\//,$line;
my $hd = `/usr/sbin/asterisk -rx "sip show peer $peer" `;
#warn $hd;
my @sip = split /\n/,$hd;
#warn @sip;
($hd) = grep(/Useragent/,@sip);
$hd =~ s/  Useragent    : (.*)/$1/;
#warn $hd;
$handsets->{$hd}++;
}

while (my ($key,$value) = each (%$handsets)) {
print "$key => $value\n";
};

