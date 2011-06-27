#import "Spelling.h"

@implementation Spelling

- (Spelling*) initWithBuiltinTable {
  self = [super init];
  if ( self ){
    table = [NSDictionary dictionaryWithObjectsAndKeys:
      @"flat", @"apartment",
      @"row", @"argument",
      @"pram", @"baby carriage",
      @"plaster", @"band-aid",
      @"loo", @"bathroom",
      @"tin", @"can",
      @"mince", @"chopped beef",
      @"biscuit", @"cookie",
      @"maize", @"corn",
      @"nappy", @"diaper",
      @"lift", @"elevator",
      @"rubber", @"eraser",
      @"torch", @"flashlight",
      @"chips", @"fries",
      @"petrol", @"gas",
      @"bloke", @"guy",
      @"motorway", @"highway",
      @"bonnet", @"hood",
      @"jelly", @"jello",
      @"jam", @"jelly",
      @"paraffin", @"kerosene",
      @"solicitor", @"lawyer",
      @"number plate", @"license plate",
      @"queue", @"line",
      @"post", @"mail",
      @"caravan", @"motor home",
      @"cinema", @"movie theater",
      @"silencer", @"muffler",
      @"serviette", @"napkin",
      @"nought", @"nothing",
      @"flyover", @"overpass",
      @"dummy", @"pacifier",
      @"trousers", @"pants",
      @"car park", @"parking lot",
      @"full stop", @"period",
      @"chemist", @"pharmacist",
      @"crisps", @"potato chips",
      @"hire", @"rent",
      @"banger", @"sausage",
      @"pavement", @"sidewalk",
      @"football", @"soccer",
      @"jumper", @"sweater",
      @"bin", @"trash can",
      @"lorry", @"truck",
      @"boot", @"trunk",
      @"holiday", @"vacation",
      @"waistcoat", @"vest",
      @"windscreen", @"windshield",
       nil ];
  }
  return self;
}

- (NSString*)britishize:(NSString*)string{
  NSString* conversion = [table objectForKey:string];
  if( conversion ){
    return conversion;
  }else{
    return string;
  };
}

@end