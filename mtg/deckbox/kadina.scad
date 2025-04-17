

/* [Rendering:] */
// Choose what to render
render = "d"; // [d:Deck box, t:Deck box (text view), l:Lid, m:Magnet blocker]

/* [Internal cavity:] */
// Internal cavity width (I've used 55 for 100 sleeved cards)
cardsCavityX = 60;
// Internal cavity depth
cardsCavityY = 67;
// Internal cavity hight
cardsCavityZ = 92;



/* [Magnets:] */
// How many vertical holes for the magnets are in the box and the lid 
holesNumber = 1;
// How many magnets are placed in the same hole
magnetNumber = 1;
// Magnet diamiter
magnetX = 10;
// Magnet hight
magnetY = 3;
// How much space between each magnet hole
magnetSpacing = 1;
// Extra spacing in the magnet holes to fit the magnets
magnetOffsetXY = 0.2;




/* [Text:] */

fontName = "Planewalker Dings"; // [Aladin, Amita, Berkshire Swash, Condiment, Charm, Dr Sugiyama, Eagle Lake, Fondamento, Merienda, Merienda One, Niconne, Norican, Quintessential, Redressed, Romanesco, Tapestry, Tillana]
fontSize = 16;

fontNames = ["Aladin", "Planewalker Dings"];
fontSizes = [14,16];
// First line
textString = "Kadina";
// Second line (leave this one blanck to render only one line in the center)
textString2 = "ceb";








module customizer_limit() {}
// =============================================================================
// =============================================================================


$fs = 0.15;

fit = 0.25;

lidHorizontalZ = 2;

magnetZ = magnetX;

magnetHoleX = magnetX + magnetOffsetXY;
magnetHoleY = magnetY + magnetOffsetXY;
magnetHoleZ = 5 + (magnetZ * magnetNumber);
magnetWall = 1;

lidVerticalZ = 5 + magnetHoleZ;

lidVerticalY = magnetHoleY+magnetWall*2;

deckBorder = 3;
deckBorderFront = lidVerticalY*2;
deckBase = 2;

deckX = deckBorder * 2 + cardsCavityX;
deckY = deckBorder + deckBorderFront + cardsCavityY;
deckZ = deckBase + lidHorizontalZ + cardsCavityZ;

lidVerticalX = deckX;

lidHorizontalX = deckX - 2*(deckBorder/2);
lidHorizontalY = deckY - (deckBorder/2); // ok deckBorder perche' tanto e' il back e non il front
lidSlope = deckBorder/2;    // di quanto faccio rientrare i punti superiori
                            // non deve superare deckBorder/2 altrimenti l'apertura e' piu' piccola della cards_cavity

frame = 4;
frameNegativeX = deckX - 2*frame;
frameNegativeZ = deckZ - 2*frame;

extraCavityX = cardsCavityX;
extraCavityY = deckBorderFront - deckBorder;
extraCavityZ = deckZ - lidVerticalZ - lidHorizontalZ - deckBorder -(deckBorderFront - deckBorder);



/*
============================================================================================================
==============================MODULI========================================================================
============================================================================================================
*/

module prism(l, w, h)
{
      polyhedron(//pt 0        1        2        3        4        5
              points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
              faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
              );      
}




module rounded_cube(size = [1, 1, 1], center = true, radius = 1, apply_to = "all") {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							sphere(r = radius);
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							rotate(a = rotate)
							cylinder(h = diameter, r = radius, center = true);
						}
					}
				}
			}
		}
	}
}
/*
source
https://danielupshaw.com/openscad-rounded-corners/
*/









/*
============================================================================================================
==============================PRINT=========================================================================
============================================================================================================
*/


// TEST UPPER DECK
//difference()
//{
//    deck();
//    translate([0,0,-magnetHoleZ -10])
//    cube([100,100,100], true);
//}




//difference()
//{
//    deck();
//    translate([-50,0,0])
//    cube([100,100,100], true);
//}



//difference()
//{
//    deck();
//    cube([12,100,100], true);
//}


//difference()
//{
//    deck();
//    translate([-40,0,0])
//    cube([100,100,100], true);
//}



//
//deck_magnet_holes();
//lid_magnet_holes();

//difference()
//{
//    deck();
//    translate([0,0,-22])
//    cube([100,100,100], true);
//    translate([0,25,0])
//    cube([100,100,100], true);
//}


//difference()
//{
//    lid();
//    translate([0,25,0])
//    cube([100,100,100], true);
//}





//// TEST TEXT
//difference()
//{
//    deck();    
//    translate([0,-16, 0])
//    cube([100,100,100], true);
//}





// TEST cards cavity
//difference()
//{
//    deck();
//    translate([0,0,-magnetHoleZ + 5])
//    cube([100,100,100], true);
//}





if(render == "d")
    deck();
if(render == "t")
    rotate([0,0,180])
    deck();
if(render == "l")
    lid();
if(render == "m")
    magnet_stopper();










/*
============================================================================================================
==============================DECK==========================================================================
============================================================================================================
*/



module cards_cavity()
{
    translate([0, -deckBorder/2 + deckBorderFront/2, deckBase/2 - lidHorizontalZ/2])
        cube([cardsCavityX, cardsCavityY, cardsCavityZ], true);
}




module deck_volume()
{

    rounded_cube([deckX, deckY, deckZ], true);
}




module lid_cavity_horizontal()
{
    // points to be used
    p = [   [lidHorizontalX/2,lidHorizontalY/2,-lidHorizontalZ/2],                      // q 1 p 0
            [-lidHorizontalX/2,lidHorizontalY/2,-lidHorizontalZ/2],                     // q 2 p 1
            [-lidHorizontalX/2,-lidHorizontalY/2,-lidHorizontalZ/2],                    // q 3 p 2
            [lidHorizontalX/2, -lidHorizontalY/2,-lidHorizontalZ/2],                    // q 4 p 3
            [lidHorizontalX/2-lidSlope,lidHorizontalY/2-lidSlope,lidHorizontalZ/2],     // q 1 p 4
            [-lidHorizontalX/2+lidSlope,lidHorizontalY/2-lidSlope,lidHorizontalZ/2],    // q 2 p 5
            [-lidHorizontalX/2+lidSlope,-lidHorizontalY/2,lidHorizontalZ/2],            // q 3 p 6
            [lidHorizontalX/2-lidSlope, -lidHorizontalY/2,lidHorizontalZ/2]  ];         // q 4 p 7
     
    // faces drawn
    f = [
        [0,1,2]
        ,[2,3,0]
        ,[7,4,3]
        ,[4,0,3]
        ,[4,5,0]
        ,[5,1,0]
        ,[5,6,1]
        ,[6,2,1]
        ,[6,7,2]
        ,[7,3,2]
        ,[4,7,6]
        ,[6,5,4]
    ];

    translate([ 0
                ,-deckBorder/2/2  //divido per 2 tutte le variabili gia' presenti
                ,deckZ/2 - lidHorizontalZ/2
                ])   // non divido lidHorizontalZ per 2 perche' e' appoggiata sul piano xy
     polyhedron(points = p, faces = f);
}
/*
source
https://gusmith.wordpress.com/2015/09/18/simple-tool-for-creating-polyhedrons-in-openscad/
*/



module lid_cavity_vertical()
{
    translate([0
                , lidVerticalY/2 - deckY/2
                , - lidVerticalZ/2 + deckZ/2
    ])
    cube([lidVerticalX, lidVerticalY, lidVerticalZ], true);
}






module deck_magnet_holes_even()
{

    translate ([  magnetHoleX/2 - (holesNumber*magnetHoleX)/2 - (holesNumber-1)*magnetSpacing/2
                , - deckY/2 + magnetHoleY/2 + magnetWall + deckBorderFront/2
                , deckZ/2 - magnetHoleZ/2 //- lidHorizontalZ
                ])

        for ( i = [0:1:holesNumber-1] )
        {
                translate ([i * (magnetHoleX + magnetSpacing), 0, 0])
                    cube([magnetHoleX,magnetHoleY,magnetHoleZ], true);

        }
}





module deck_magnet_holes_odd()
{

    translate ([  0
                , - deckY/2 + magnetHoleY/2 + magnetWall + deckBorderFront/2
                , deckZ/2 - magnetHoleZ/2 //- lidHorizontalZ
                ])

        for ( i = [0:1:holesNumber-1] )
        {

            if(i%2 == 0)
                translate ([(i/2)*(magnetHoleX + magnetSpacing), 0, 0])
                    cube([magnetHoleX,magnetHoleY,magnetHoleZ], true);
        
            if(i%2 == 1)
                translate ([-(i/2)*(magnetHoleX + magnetSpacing)-(magnetHoleX + magnetSpacing)/2, 0, 0])
                    cube([magnetHoleX,magnetHoleY,magnetHoleZ], true);             
          
        }
}




module deck_text()
{
    rotate([0,90,90])
    translate([0, 0, deckY/2-2-0.1])
    linear_extrude(0.1+0.4)
    text(text = textString, font = fontName, size = fontSize, halign = "center", valign = "center", spacing=1.1, $fn=0.1);  
}



module multi_line(lines){
    rotate([0,90,90])
    translate([0, (fontSizes[0]+2)/2, deckY/2-2-0.1])
    linear_extrude(0.1+0.4)
    union()
    {
        for (i = [0 : len(lines)-1])
            translate([0 , -i * (fontSizes[i] + 2), 0 ])
            text(text = lines[i], font = fontNames[i], size = fontSizes[i], halign = "center", valign = "center", spacing=1.1, $fn=0.1);  
    }
}



module prism_cavity()
{
    
    translate([-cardsCavityX/2, -cardsCavityY/2 - (deckBorderFront+deckBorder)/2 +deckBorder, deckZ/2-(deckBorderFront - deckBorder) - lidVerticalZ - deckBorder])
        prism(cardsCavityX, deckBorderFront - deckBorder +10, deckBorderFront - deckBorder +10);


}



module extra_cavity()
{
    translate([-cardsCavityX/2, -cardsCavityY/2 - (deckBorderFront+deckBorder)/2 +deckBorder, -deckZ/2 + deckBase])
    cube([extraCavityX, extraCavityY, extraCavityZ]);

}



module internal_cavity()
{
    union()
    {
        cards_cavity();
        prism_cavity();
        extra_cavity();
    }
}



module stack_male()
{

translate([deckX/2+1.001-fit/2,0,0])


    difference()
    {
        
        resize([2-fit, deckY-(frame*2)-fit*4, deckZ-(frame*2)-fit*4])
//        resize([2-fit, deckY-(frame*2)-fit*2, deckZ-(frame*2)-fit*2])
        internal_cavity();

        translate([6,0, -(deckZ-(frame*2))/2])
        rotate([0,-45, 0])
        cube([10,400,10], true);

        translate([6,0, +(deckZ-(frame*2))/2])
        rotate([0,-45, 0])
        cube([10,400,10], true);

   
    }
}




module stack_female()
{
    translate([-deckX/2+0.999,0,0])

    difference()
    {

        resize([2, deckY-(frame*2), deckZ-(frame*2)])
        internal_cavity();

        translate([6,0, -(deckZ-(frame*2))/2])
        rotate([0,-45, 0])
        cube([10,400,10], true);

        translate([6,0, +(deckZ-(frame*2))/2])
        rotate([0,-45, 0])
        cube([10,400,10], true);
   
    }
}




module frame_negative()
{

    translate([0,deckY/2-1,0])
    difference()
    {
        
        cube([deckX-frame*2, 2, deckZ-frame*2], true);
        
        translate([0,-6, -(deckZ-(frame*2))/2])
        rotate([-45, 0, 0])
        cube([400,10,10], true);

        translate([0,-6, +(deckZ-(frame*2))/2])
        rotate([-45, 0, 0])
        cube([400,10,10], true);

    }
}





module deck()
{
    union()
    {

        difference()
        {
            deck_volume();
            lid_cavity_horizontal();
            lid_cavity_vertical();
 
            if(holesNumber%2 == 0)
                deck_magnet_holes_even();
            if(holesNumber%2 != 0)
                deck_magnet_holes_odd();
            
            internal_cavity();

            frame_negative();
            stack_female();
        }
        
        stack_male();
        
        
        if (textString2 == "")
            deck_text();
        else
            multi_line([textString, textString2]);
                
    } 
}
























/*
============================================================================================================
==============================LID===========================================================================
============================================================================================================
*/




module lid_horizontal()
{
    // points to be used
    p = [   [lidHorizontalX/2 -fit,lidHorizontalY/2 -fit,-lidHorizontalZ/2],                      // q 1 p 0
            [-lidHorizontalX/2 +fit,lidHorizontalY/2 -fit,-lidHorizontalZ/2],                     // q 2 p 1
            [-lidHorizontalX/2 +fit,-lidHorizontalY/2,-lidHorizontalZ/2],                    // q 3 p 2
            [lidHorizontalX/2 -fit, -lidHorizontalY/2,-lidHorizontalZ/2],                    // q 4 p 3
            [lidHorizontalX/2-lidSlope -fit,lidHorizontalY/2-lidSlope +fit,lidHorizontalZ/2],     // q 1 p 4
            [-lidHorizontalX/2+lidSlope +fit,lidHorizontalY/2-lidSlope -fit,lidHorizontalZ/2],    // q 2 p 5
            [-lidHorizontalX/2+lidSlope +fit,-lidHorizontalY/2,lidHorizontalZ/2],            // q 3 p 6
            [lidHorizontalX/2-lidSlope -fit, -lidHorizontalY/2,lidHorizontalZ/2]  ];         // q 4 p 7
     
    // faces drawn
    f = [
        [0,1,2]
        ,[2,3,0]
        ,[7,4,3]
        ,[4,0,3]
        ,[4,5,0]
        ,[5,1,0]
        ,[5,6,1]
        ,[6,2,1]
        ,[6,7,2]
        ,[7,3,2]
        ,[4,7,6]
        ,[6,5,4]
    ];

    translate([ 0
                ,-deckBorder/2/2  //divido per 2 tutte le variabili gia' presenti
                ,deckZ/2 - lidHorizontalZ/2
                ])
     polyhedron(points = p, faces = f);
}




module lid_vertical()
{
    translate([0
                , lidVerticalY/2 - deckY/2 -fit/2
                , - lidVerticalZ/2 + deckZ/2 +fit/2
    ])

    union()
    {
        rounded_cube([lidVerticalX - fit, lidVerticalY -fit, lidVerticalZ -fit], true, 1, "zmax");
        rounded_cube([lidVerticalX - fit, lidVerticalY -fit, lidVerticalZ -fit], true, 1, "ymin");
        translate([0, (lidVerticalY-fit)/4, -(lidVerticalZ-fit)/4])
        cube([(lidVerticalX-fit), (lidVerticalY-fit)/2, (lidVerticalZ-fit)/2], true);
    }
}



module cut_lid_horizontal() // serve perche' sporge dal lid vertical quando e' arrotondato
{
    translate([0
                , lidVerticalY/2 - deckY/2 -fit/2
                , - lidVerticalZ/2 + deckZ/2 +fit/2
    ])
    translate([0, -(lidVerticalY-fit)/4, (lidVerticalZ-fit)/4])
    cube([(lidVerticalX-fit), (lidVerticalY-fit)/2, (lidVerticalZ-fit)/2], true);    
}










module lid_magnet_holes_even()
{

    translate ([  magnetHoleX/2 - (holesNumber*magnetHoleX)/2 - (holesNumber-1)*magnetSpacing/2
                , - deckY/2 + magnetHoleY/2 + magnetWall -fit/2
                , deckZ/2 - lidVerticalZ + magnetHoleZ/2
                ])

        for ( i = [0:1:holesNumber-1] )
        {
                translate ([i * (magnetHoleX + magnetSpacing), 0, 0])
                    cube([magnetHoleX,magnetHoleY,magnetHoleZ], true);              
        }
    
}







module lid_magnet_holes_odd()
{

    translate ([  0
                , - deckY/2 + magnetHoleY/2 + magnetWall -fit/2
                , deckZ/2 - lidVerticalZ + magnetHoleZ/2
                ])

        for ( i = [0:1:holesNumber-1] )
        {

            if(i%2 == 0)
                translate ([(i/2)*(magnetHoleX + magnetSpacing), 0, 0])
                    cube([magnetHoleX,magnetHoleY,magnetHoleZ], true);
        
            if(i%2 == 1)
                translate ([-(i/2)*(magnetHoleX + magnetSpacing)-(magnetHoleX + magnetSpacing)/2, 0, 0])
                    cube([magnetHoleX,magnetHoleY,magnetHoleZ], true);             
          
        }
    
}



module lid()
{
    difference()
    {
        union()
        {
            difference()
            {
                lid_horizontal();
                cut_lid_horizontal();
            }
         lid_vertical();   
        }
        if(holesNumber%2 == 0)
            lid_magnet_holes_even();
        if(holesNumber%2 != 0)
            lid_magnet_holes_odd();

    }
}











/*
============================================================================================================
==============================MAGNET STOPPER================================================================
============================================================================================================
*/


module magnet_stopper()
{
 
 cube([magnetX-0.1, magnetY-0.1, 3], true); 
    
}













































