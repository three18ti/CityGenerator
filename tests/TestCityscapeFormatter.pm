#!/usr/bin/perl -wT
###############################################################################
#
package TestCityscapeFormatter;

use strict;
use warnings;
use CityGenerator;
use CityscapeFormatter;
use Data::Dumper;
use Exporter;
use GenericGenerator;
use Test::More;
use XML::Simple;

use vars qw(@ISA @EXPORT_OK $VERSION $XS_VERSION $TESTING_PERL_ONLY);
use base qw(Exporter);
@EXPORT_OK = qw( );

subtest 'Test Cityscape walls' => sub {
    my $city = CityGenerator::create_city( { seed => 1, 'wall_chance_roll' => 100 } );
    CityGenerator::flesh_out_city($city);
    my $cityscape = CityscapeFormatter::printWalls($city);
    is( $cityscape,
        'No walls currently surround the city.'
    );

    $city = CityGenerator::create_city( { seed => 1, 'wall_chance_roll' => 1, 'walls'=>{'height'=>'90', 'condition'=>'borked', 'material'=>'jello', 'style'=>'shingle'} } );
    CityGenerator::flesh_out_city($city);
    $cityscape = CityscapeFormatter::printWalls($city);
    is( $cityscape,
        'Visitors are greeted with a borked jello shingle that is 90 meters tall. The city wall protects the core 85% of the city, with 5 towers spread along the 1.98 kilometer wall.',    
        "ensure walls are printing"
    );

    $city = CityGenerator::create_city( { seed => 1,  } );
    CityGenerator::flesh_out_city($city);
    $cityscape = CityscapeFormatter::printWalls($city);
    is( $cityscape, "No walls currently surround the city." );

    done_testing();
};

subtest 'Test Cityscape streets' => sub {
    my $city = CityGenerator::create_city( { seed => 1 } );
    CityGenerator::flesh_out_city($city);
    my $cityscape = CityscapeFormatter::printStreets($city);
    is( $cityscape,
        'There is 1 road leading to Kanhall; none are major.  The city is lined with crude cobblestone streets in an irregular pattern.',
        "ensure streets are printing"
    );

    done_testing();
};

subtest 'Test Cityscape districts' => sub {
    my $city = CityGenerator::create_city( { seed => 1 } );
    CityGenerator::flesh_out_city($city);
    my $cityscape = CityscapeFormatter::printDistrictList($city);
    is( $cityscape, 
        "The city is broken into the following Districts: market, mercy, wealthy, middleclass and civic.",
        "ensure district is printed"
     );

    done_testing();
};

subtest 'Test Cityscape housing' => sub {
    my $city = CityGenerator::create_city( { 'seed' => 1, 'housing'=>{'wealthy'=>9,'average'=>8,'poor'=>4} } );
    CityGenerator::flesh_out_city($city);
    my $cityscape = CityscapeFormatter::printHousingList($city);
    is( $cityscape, "Among housing, there are 9 wealthy residences, 8 average homes and 4 dilapidated homes." );

    done_testing();
};


1;
