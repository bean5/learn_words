use warnings;
use strict;

open IN, "<", "word_pos_def.txt";

my @lines;

while(<IN>) {push(@lines, $_);}

my @words;
my @poss;
my @defs;
for my $line(@lines) {
	my @word_pos_def = &splitLine($line);
	push(@words, $word_pos_def[0]);
	push(@poss, $word_pos_def[1]);
	push(@defs, $word_pos_def[2]);
}

&menu();

sub menu() {
	print "Number of words: ".scalar(@lines);
	print "\n";
	print "What would you like to do?\n";
	print "1. Just view random words.\n";
	print "2. Multiple choice definitions\n";
	print "3. Exit\n";
	$_ = <>;
	chomp;

	if($_ eq "1") {
		&doRandom();
	}
	elsif($_ eq "2") {
		&doMultipleChoice();
	}
	elsif($_ eq "3") {
		return;
	}
	<>;
}

sub doRandom() {
	while(<> ne "x\n") {
		&printRandom();
	}
	&menu();
}

sub doMultipleChoice() {
	while(<> ne "x\n") {
		print "\n\n\n\n\n\n\n\n\n";
		&showMultipleChoice();
		print "\n";
	}
	&menu();
}

sub splitLine() {
	my $line = $_[0];
	
	my @words = split " ", $_[0];
	
	my @chunks;
	push (@chunks, $words[0]);
	push (@chunks, $words[1]);
	my $def;
	for(my $i = 2; $i < scalar(@words); $i++) {
		$def .= $words[$i].' ';
	}
	push (@chunks, $def);
	
	return @chunks;
}

sub printWordAndDef() {
	my $number = $_[0];
	
	print "Word: ".$words[$number];
	print "\n";
	
	print "Pos: ".$poss[$number];
	print "\n";
	
	print "Def: ".$defs[$number];
	print "\n";
}

sub printRandom() {
	my $random = rand(scalar(@defs));
	&printWordAndDef($random);
}

sub showMultipleChoice() {
	my $random1 = int(rand(4))+1;
	my $answer = rand(scalar(@defs));
	my $random2 = rand(scalar(@defs));
	my $random3 = rand(scalar(@defs));
	my $random4 = rand(scalar(@defs));
	
	print "Word: ".$words[$answer]."\n";
	
	if($random1 eq 1) {
		print "1. ".$defs[$answer];
		print "\n";
		print "2. ".$defs[$random2];
		print "\n";
		print "3. ".$defs[$random3];
		print "\n";
		print "4. ".$defs[$random4];
		print "\n";
		
		&tryForAnswer(1);
	}
	elsif($random1 eq 2) {
		print "1. ".$defs[$random2];
		print "\n";
		print "2. ".$defs[$answer];
		print "\n";
		print "3. ".$defs[$random3];
		print "\n";
		print "4. ".$defs[$random4];
		print "\n";
		
		&tryForAnswer(2);
	}
	elsif($random1 eq 3) {
		print "1. ".$defs[$random2];
		print "\n";
		print "2. ".$defs[$random3];
		print "\n";
		print "3. ".$defs[$answer];
		print "\n";
		print "4. ".$defs[$random4];
		print "\n";
		
		&tryForAnswer(3);
	}
	elsif($random1 eq 4) {
		print "1. ".$defs[$random2];
		print "\n";
		print "2. ".$defs[$random3];
		print "\n";
		print "3. ".$defs[$random4];
		print "\n";
		print "4. ".$defs[$answer];
		print "\n";
		
		&tryForAnswer(4);
	}
}

sub tryForAnswer() {
	my $answer = $_[0];
	
	$_ = <>;
	chomp;
	
	if($_ eq $answer) {
		print "Right!\n";
	}
	else {
		print "Wrong!\n";
		print "Answer was: $answer\n";
	}
}