#!/usr/bin/perl

$num=295001;
$txCount=0;
$blockCount=0;

while ($num <= 420000) {
    my $hash=`bitcoin-cli getblockhash $num`;
    chomp $hash;
    @output=`bitcoin-cli getblock $hash`;

    my $inTx=0;
    foreach my $line (@output) {
        if ($inTx == 1) {
            if ($line=~/\],$/) {
                $inTx = 0;
                last;
            }
            if ($line ne "") {
                $txCount++;
            }
        }
        elsif ($line=~/\"tx\": \[/) {
            $inTx = 1;
            $blockCount++;
            if (($blockCount % 5000) == 0) {
                print "      blocks $blockCount, total TX; $txCount\n";
            }
        }
    }

    ++$num;
}

print "Total blocks $blockCount, total TX; $txCount\n";
