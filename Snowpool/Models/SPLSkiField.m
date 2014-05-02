//
//  SPLSkiField.m
//  Snowpool
//
//  Created by Patrick Davey on 9/03/14.
//  Copyright (c) 2014 Snowpool Limited. All rights reserved.
//

#import "SPLSkiField.h"
#import "SPLUserDefaults.h"

@implementation SPLSkiField

+ (NSDictionary *)allForCountryWithID:(NSNumber *)countryID
{
    return [[self class] all][countryID];
    
}

+ (NSString *)titleForFieldWithID:(NSNumber *)fieldID
{
    NSNumber *usersCountry = [SPLUserDefaults standardUserDefaults].selectedCountryKey;
    NSDictionary *fields = [SPLSkiField allForCountryWithID:usersCountry];
    return fields[fieldID];
}

+ (NSDictionary *)all
{
    return   @{
               @1 : @{
                       @1 : @"Porters",
                       @2 : @"Temple Basin",
                       @3 : @"Mt. Cheeseman",
                       @4 : @"Broken River",
                       @5 : @"Mt. Olympus",
                       @6 : @"Remarkables",
                       @7 : @"Treble Cone",
                       @8 : @"Mt. Hutt",
                       @9 : @"Hanmer Springs",
                       @10 : @"Craigieburn",
                       @11 : @"Fox Peak",
                       @12 : @"Ohau",
                       @13 : @"Mt. Dobson",
                       @14 : @"Coronet Peak",
                       @15 : @"Cardrona",
                       @16 : @"Mt. Lyford",
                       @17 : @"Roundhill",
                       @18 : @"Snowfarm",
                       @20 : @"Rainbow",
                       @21 : @"Whakapapa",
                       @22 : @"Turoa",
                       @23 : @"Castle Hill",
                       @24 : @"Manganui",
                       @25 : @"Awakino",
                       @26 : @"Mt. Cook Village",
                       @27 : @"HeliPark",
                       @109 : @"Tukino"
                       },
               @2 : @{
                       @28 : @"Charlotte Pass",
                       @29 : @"Perisher",
                       @30 : @"Selwyn Snowfields",
                       @31 : @"Thredbo",
                       @32 : @"Guthega",
                       @33 : @"Smiggin Holes",
                       @34 : @"Hotham",
                       @35 : @"Mount Beauty",
                       @36 : @"Falls Creek",
                       @37 : @"Mount Buller",
                       @38 : @"Mount Buffalo",
                       @39 : @"Mount Stirling",
                       @40 : @"Mount Baw Baw",
                       @41 : @"Ben Lomond",
                       @42 : @"Mount Mawson",
                       @43 : @"Jindabyne",
                       @44 : @"Skitube - Bullocks Flat",
                       @110 : @"Dinner Plain",
                       @111 : @"Lake Mountain"
                       },
               @3 : @{
                       @45 : @"Snoqualmie",
                       @54 : @"Alpental",
                       @55 : @"Mount Baker",
                       @56 : @"Stevens Pass",
                       @57 : @"White Pass",
                       @58 : @"Crystal Mountain",
                       @59 : @"Mount Spokane",
                       @60 : @"49 Degrees North",
                       @61 : @"Bluewood",
                       @81 : @"Mammoth",
                       @82 : @"Arapahoe Basin",
                       @83 : @"Loveland",
                       @84 : @"Keystone",
                       @85 : @"Breckenridge",
                       @86 : @"Copper Mountain",
                       @87 : @"Vail",
                       @88 : @"Beaver Creek",
                       @89 : @"Steamboat",
                       @90 : @"Aspen",
                       @91 : @"Aspen Highlands",
                       @99 : @"Windham",
                       @100 : @"Hunter Mountain",
                       @101 : @"Belleayre",
                       @102 : @"Mountain Creek",
                       @103 : @"Blue Mountain",
                       @104 : @"Camelback ",
                       @105 : @"Jack Frost",
                       @106 : @"Mount Snow",
                       @107 : @"Stratton",
                       @108 : @"Okemo"
                       },
               @4 : @{
                       @46 : @"Big White",
                       @47 : @"Silver Star",
                       @48 : @"Apex",
                       @49 : @"Sun Peaks",
                       @50 : @"Red Mountain",
                       @51 : @"Whitewater",
                       @52 : @"Revelstoke",
                       @53 : @"Kicking Horse",
                       @62 : @"Castle Mountain",
                       @63 : @"Lake Louise",
                       @64 : @"Fortress Mountain",
                       @65 : @"Nakiska",
                       @66 : @"Mount Norquay",
                       @67 : @"Sunshine Village",
                       @68 : @"Fernie Alpine Resort",
                       @69 : @"Silver Summit",
                       @70 : @"Marmot Basin",
                       @71 : @"Cypress Mountain",
                       @72 : @"Grouse",
                       @73 : @"Mt Seymour",
                       @74 : @"Hemlock Valley",
                       @75 : @"Whistler",
                       @76 : @"Mt Washington",
                       @77 : @"Mount Tremblant",
                       @78 : @"Panorama Village",
                       @79 : @"Mont Saint-Sauveur",
                       @80 : @"Morin Heights",
                       @92 : @"Kelowna Nordic",
                       @93 : @"Sovereign Lake Nordic",
                       @94 : @"Telemark Cross Country",
                       @95 : @"Mt Baldy",
                       @96 : @"Cypress Nordic",
                       @97 : @"Manning Park",
                       @98 : @"Callaghan Valley",
                       }
               };
}

@end
