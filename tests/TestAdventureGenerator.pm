#!/usr/bin/perl -wT
###############################################################################
#
package TestAdventureGenerator;

use strict;
use warnings;
use Test::More;
use AdventureGenerator;
use GenericGenerator qw( set_seed );

use Data::Dumper;
use XML::Simple;
use vars qw(@ISA @EXPORT_OK $VERSION $XS_VERSION $TESTING_PERL_ONLY);
require Exporter;

@ISA       = qw(Exporter);
@EXPORT_OK = qw( );

subtest 'test generate_adventure ' => sub {
    my $adventure;

    $adventure=AdventureGenerator::create_adventure();

    $adventure=AdventureGenerator::create_adventure({'seed'=>2});
    is($adventure->{'seed'}, 2);

    done_testing();
};


subtest 'test generate_adventure name' => sub {
    my $adventure;
    GenericGenerator::set_seed(1);
    $adventure=AdventureGenerator::generate_name();
    is($adventure->{'namepattern'},"SUBJECT");
    is($adventure->{'name'},"The Foggy Symbol");

    $adventure=AdventureGenerator::generate_name({'seed'=>2});
    is($adventure->{'namepattern'},"VERB.gerund SUBJECT");
    is($adventure->{'name'},"Joyfully Planning an Overlooked Dagger");

    $adventure=AdventureGenerator::generate_name({'seed'=>2, 'namepattern'=>'ADVERB ADVERB VERB SUBJECT'});
    is($adventure->{'namepattern'},"ADVERB ADVERB VERB SUBJECT");
    is($adventure->{'name'},"Greedily Swiftly Partially Swing the Tyrant");

    $adventure=AdventureGenerator::generate_name({'seed'=>2, 'name'=>"Bill and Ted's Excellent Adventure"});
    is($adventure->{'namepattern'},"VERB.gerund SUBJECT");
    is($adventure->{'name'},"Bill and Ted's Excellent Adventure");


    $adventure=AdventureGenerator::generate_name({'seed'=>2, 'namepattern'=>'NOUN SUBJECT NOUN SUBJECT ADJECTIVE ADJECTIVE'});
    is($adventure->{'namepattern'},"NOUN SUBJECT NOUN SUBJECT ADJECTIVE ADJECTIVE");

    $adventure=AdventureGenerator::generate_name({'seed'=>2, 'namepattern'=>'VERB.thirdperson VERB.participle ARTICLE'});
    is($adventure->{'namepattern'},"VERB.thirdperson VERB.participle ARTICLE");

    $adventure=AdventureGenerator::generate_name({'seed'=>3, 'namepattern'=>'SUBJECT SUBJECT SUBJECT SUBJECT SUBJECT SUBJECT'});
    is($adventure->{'namepattern'},"SUBJECT SUBJECT SUBJECT SUBJECT SUBJECT SUBJECT");

    $adventure=AdventureGenerator::generate_name({'seed'=>3, 'namepattern'=>'VERB VERB VERB VERB VERB VERB'});
    is($adventure->{'namepattern'},"VERB VERB VERB VERB VERB VERB");

    done_testing();
};

1;
