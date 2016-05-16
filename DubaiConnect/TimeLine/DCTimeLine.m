//
//  DCTimeLine.m
//  DubaiConnect
//
//  Created by Krishna on 8/28/15.
//  Copyright (c) 2015 Anoop. All rights reserved.
//

#import "DCTimeLine.h"

@implementation DCTimeLine
@synthesize placeName;
@synthesize placeDescription;
@synthesize taxiTime;
@synthesize distanceFromAirport;
@synthesize weatherInfo;
@synthesize imgName;
@synthesize miles;
@synthesize cash;


-(NSMutableArray *)setLimeLineObjects:(int)tag {
    
    //11 AM in the morning
    
    NSMutableArray *arr =[[NSMutableArray alloc] init];
    
    DCTimeLine *obj_TimeLine_Airport1 =[[DCTimeLine alloc] init];
    obj_TimeLine_Airport1.placeName = @"Dubai Airport";
    obj_TimeLine_Airport1.placeDescription = @"description";
    obj_TimeLine_Airport1.taxiTime = @"3 hours";
    obj_TimeLine_Airport1.distanceFromAirport = @"14";
    obj_TimeLine_Airport1.weatherInfo =@"30";
    obj_TimeLine_Airport1.imgName =@"Airport1.png";
    
    
    DCTimeLine *obj_TimeLine1 =[[DCTimeLine alloc] init];
    obj_TimeLine1.placeName = @"Burj Khalifa";
    obj_TimeLine1.placeDescription = @"description";
    obj_TimeLine1.taxiTime = @"3 hours";
    obj_TimeLine1.distanceFromAirport = @"15";
    obj_TimeLine1.weatherInfo =@"30";
    obj_TimeLine1.imgName =@"burj_khalifa.jpg";
    obj_TimeLine1.miles = @"4000";
    obj_TimeLine1.cash = @"300";
    
    
    //3 Pm
    DCTimeLine *obj_TimeLine2 =[[DCTimeLine alloc] init];
    obj_TimeLine2.placeName = @"Burj Al Arab";
    obj_TimeLine2.placeDescription = @"description";
    obj_TimeLine2.taxiTime = @"2 hours";
    obj_TimeLine2.distanceFromAirport = @"4";
    obj_TimeLine2.weatherInfo =@"30";
    obj_TimeLine2.imgName = @"burj-al-arab-dubai-960x640.jpg";
    obj_TimeLine2.miles = @"3000";
    obj_TimeLine2.cash = @"200";

    
    
    DCTimeLine *obj_TimeLine5 =[[DCTimeLine alloc] init];
    obj_TimeLine5.placeName = @"Ski Dubai";
    obj_TimeLine5.placeDescription = @"description";
    obj_TimeLine5.taxiTime = @"3 hours";
    obj_TimeLine5.distanceFromAirport = @"6";
    obj_TimeLine5.weatherInfo =@"30";
    obj_TimeLine5.imgName = @"Ski-Dubai.jpg";
    obj_TimeLine5.miles = @"6000";
    obj_TimeLine5.cash = @"500";

    
    
    DCTimeLine *obj_TimeLine6 =[[DCTimeLine alloc] init];
    obj_TimeLine6.placeName = @"Dubai Dolphinarium";
    obj_TimeLine6.placeDescription = @"description";
    obj_TimeLine6.taxiTime = @"3 hours";
    obj_TimeLine6.distanceFromAirport = @"12";
    obj_TimeLine6.weatherInfo =@"30";
    obj_TimeLine6.imgName = @"DSF.jpeg";
    obj_TimeLine6.miles = @"8000";
    obj_TimeLine6.cash = @"700";

    
    
    DCTimeLine *obj_TimeLine7 =[[DCTimeLine alloc] init];
    obj_TimeLine7.placeName = @"Wild Wadi";
    obj_TimeLine7.placeDescription = @"description";
    obj_TimeLine7.taxiTime = @"3 hours";
    obj_TimeLine7.distanceFromAirport = @"10";
    obj_TimeLine7.weatherInfo =@"30";
    obj_TimeLine7.imgName = @"dubai_icon.png";
    obj_TimeLine7.miles = @"2000";
    obj_TimeLine7.cash = @"150";

    
    
    DCTimeLine *obj_TimeLine8 =[[DCTimeLine alloc] init];
    obj_TimeLine8.placeName = @"Dubai Marina";
    obj_TimeLine8.placeDescription = @"description";
    obj_TimeLine8.taxiTime = @"3 hours";
    obj_TimeLine8.distanceFromAirport = @"8";
    obj_TimeLine8.weatherInfo =@"30";
    obj_TimeLine8.imgName = @"Balloon over Desert 1.jpg";
    obj_TimeLine8.miles = @"3000";
    obj_TimeLine8.cash = @"100";

    
    
    DCTimeLine *obj_TimeLine9 =[[DCTimeLine alloc] init];
    obj_TimeLine9.placeName = @"Dubai Zoo";
    obj_TimeLine9.placeDescription = @"description";
    obj_TimeLine9.taxiTime = @"2 hours";
    obj_TimeLine9.distanceFromAirport = @"5";
    obj_TimeLine9.weatherInfo =@"30";
    obj_TimeLine9.imgName = @"dubai_icon.png";
    obj_TimeLine9.miles = @"3000";
    obj_TimeLine9.cash = @"100";

    
    
    DCTimeLine *obj_TimeLine10 =[[DCTimeLine alloc] init];
    obj_TimeLine10.placeName = @"Jumeirah Beach";
    obj_TimeLine10.placeDescription = @"description";
    obj_TimeLine10.taxiTime = @"2 hours";
    obj_TimeLine10.distanceFromAirport = @"6";
    obj_TimeLine10.weatherInfo =@"30";
    obj_TimeLine10.imgName = @"Ski-Dubai.jpg";
    obj_TimeLine10.miles = @"3000";
    obj_TimeLine10.cash = @"150";

    
    
    DCTimeLine *obj_TimeLine3 =[[DCTimeLine alloc] init];
    obj_TimeLine3.placeName = @"Dubai Museum";
    obj_TimeLine3.placeDescription = @"description";
    obj_TimeLine3.taxiTime = @"2 hours";
    obj_TimeLine3.distanceFromAirport = @"11";
    obj_TimeLine3.weatherInfo =@"30";
    obj_TimeLine3.imgName = @"silhouette-desert-safari.jpg";
    obj_TimeLine3.miles = @"2000";
    obj_TimeLine3.cash = @"100";

    
    DCTimeLine *obj_TimeLine_Airport2 =[[DCTimeLine alloc] init];
    obj_TimeLine_Airport2.placeName = @"Dubai Airport";
    obj_TimeLine_Airport2.placeDescription = @"description";
    obj_TimeLine_Airport2.taxiTime = @"4 hrs";
    obj_TimeLine_Airport2.distanceFromAirport = @"5";
    obj_TimeLine_Airport2.weatherInfo =@"30";
    obj_TimeLine_Airport2.imgName =@"Airport2.png";
    
    switch (tag) {
        case 2: {
            [arr addObject:obj_TimeLine_Airport1];
            [arr addObject:obj_TimeLine1];
            [arr addObject:obj_TimeLine2];
            [arr addObject:obj_TimeLine_Airport2];
        }
            break;
            
        case 3: {
            [arr addObject:obj_TimeLine_Airport1];
            [arr addObject:obj_TimeLine1];
            [arr addObject:obj_TimeLine2];
            [arr addObject:obj_TimeLine3];
            [arr addObject:obj_TimeLine_Airport2];
        }
            break;
        case 4: {
            [arr addObject:obj_TimeLine_Airport1];
            [arr addObject:obj_TimeLine1];
            [arr addObject:obj_TimeLine2];
            [arr addObject:obj_TimeLine3];
            [arr addObject:obj_TimeLine5];

            [arr addObject:obj_TimeLine_Airport2];
        }
            break;

        case 5: {
            [arr addObject:obj_TimeLine_Airport1];
            [arr addObject:obj_TimeLine1];
            [arr addObject:obj_TimeLine2];
            [arr addObject:obj_TimeLine3];
            [arr addObject:obj_TimeLine5];
            [arr addObject:obj_TimeLine6];
            
            [arr addObject:obj_TimeLine_Airport2];
        }
            break;
            
        case 6: {
            [arr addObject:obj_TimeLine_Airport1];
            [arr addObject:obj_TimeLine1];
            [arr addObject:obj_TimeLine2];
            [arr addObject:obj_TimeLine3];
            [arr addObject:obj_TimeLine5];
            [arr addObject:obj_TimeLine6];
            [arr addObject:obj_TimeLine7];

            [arr addObject:obj_TimeLine_Airport2];
        }
            break;
            
        case 7: {
            [arr addObject:obj_TimeLine_Airport1];
            [arr addObject:obj_TimeLine1];
            [arr addObject:obj_TimeLine2];
            [arr addObject:obj_TimeLine3];
            [arr addObject:obj_TimeLine5];
            [arr addObject:obj_TimeLine6];
            [arr addObject:obj_TimeLine8];
            
            [arr addObject:obj_TimeLine_Airport2];
        }
            break;
            
        default: {
            [arr addObject:obj_TimeLine_Airport1];
            [arr addObject:obj_TimeLine1];
            [arr addObject:obj_TimeLine2];
            [arr addObject:obj_TimeLine3];
            [arr addObject:obj_TimeLine5];
            [arr addObject:obj_TimeLine6];
            [arr addObject:obj_TimeLine8];
            [arr addObject:obj_TimeLine9];
            [arr addObject:obj_TimeLine10];
            
            [arr addObject:obj_TimeLine_Airport2];
        }
            
            break;
    }
    
    return arr;
}

@end
