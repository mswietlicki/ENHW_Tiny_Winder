$fa = 2;
$fs = 2;

// Inner rounded box dimensions
$box_wid = 50;
$box_len = 30;
$box_hei_a = 12;
$box_hei_b = 16;
$box_hei_join = 5;

// Outer oval dimensions
$winder_wid = 108;
$winder_len = 68;
$winder_hei = 2.0;
$winder_margin = 4;
$winder_hole_r = 8;

module rcube(Size, b)
{
    hull() for (x = [ -(Size[0] / 2 - b),
                      (Size[0] / 2 - b) ]) for (y = [ -(Size[1] / 2 - b),
                                                      (Size[1] / 2 -
                                                       b) ]) for (z = [ -(Size[2] / 2 - b), (Size[2] / 2 - b) ])
        translate([ x, y, z ]) sphere(b);
}

module rcube2(Size, b)
{
    hull() for (x = [ -(Size[0] / 2 - b),
                      (Size[0] / 2 - b) ]) for (y = [ -(Size[1] / 2 - b),
                                                      (Size[1] / 2 -
                                                       b) ]) for (z = [ -(Size[2] / 2), (Size[2] / 2 - 1) ])
        translate([ x, y, z ]) linear_extrude(height = 1) circle(b);
}

module rcylinder(r1, r2, h, b)
{
    translate([ 0, 0, -h ]) hull()
    {
        rotate_extrude() translate([ r1 - b, b, 0 ]) circle(r = b);
        rotate_extrude() translate([ r2 - b, h - b, 0 ]) circle(r = b);
    }
}

module disc(w, l, h, wr, m, l1, l2)
{
    wd = w - l;
    difference()
    {
        hull() for (x = [ -wd / 2, wd / 2 ]) translate([ x, 0, h / 2 ])
            rcylinder(h = h, r1 = l / 2, r2 = l / 2, b = h / 3);

        for (i = [ -1, 1 ])
        {
            for (j = [ -52, 0, 52 ])
                translate([ i * (wd / 2), 0, 0 ]) rotate(j) translate([ i * (l / 2 - wr - m), 0, 0 ])
                    cylinder(h = h, r1 = wr, r2 = wr, center = true);

            translate([ 0, i * (l / 2 - wr - m), 0 ]) rcube(Size = [ wd, wr * 2, h ], b = 2);
        }
    }
}

module side_a()
{
    disc($winder_wid, $winder_len, $winder_hei, $winder_hole_r, $winder_margin);

    translate([ 0, 0, $winder_hei / 2 ]) 
    difference()
    {
        union()
        {
            translate([ 0, 0, $box_hei_a / 2 ]) 
                rcube2(Size = [ $box_wid, $box_len, $box_hei_a ], b = 10);

            translate([ 0, 0, $box_hei_a + $box_hei_join / 2 ])
                rcube2(Size = [ $box_wid - 3.3, $box_len - 3.3, $box_hei_join ], b = 10);
        }
        translate([ 0, 0, $box_hei_a / 2 + $box_hei_join / 2 + 1]) 
            rcube2(Size = [ $box_wid - 6, $box_len - 6, $box_hei_a + $box_hei_join + 2 ], b = 10);
    }
}

side_a();