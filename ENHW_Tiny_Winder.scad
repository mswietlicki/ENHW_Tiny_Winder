$fs = $preview ? 1 : 0.2;
$fa = $preview ? 3 : 0.2;

$labels = [ "40m", "EFHW" ];

// Outer oval dimensions
$winder_wid = 108;
$winder_len = 68;
$winder_hei = 2.0;
$winder_margin = 4;
$winder_hole_r = 8;

// Inner rounded box dimensions
$box_wid = 50;
$box_len = 30;
$box_hei_a = 12;
$box_hei_b = 17;
$box_hei_join = 5 + $winder_hei;

//
wall_thick = 3;
coax_r = 3.3 / 2;
wire_r = 6 / 2;
finger_r = 14 / 2;
pin_r = 1.8 / 2;
pillar_r = 9.6 / 2;
tolerance = 0.1;

// Main body

side_a();

translate([ 0, 0, $box_hei_a + $winder_hei ]) 
middle_disc();

translate([ 0, 0, $box_hei_a + $box_hei_b + $winder_hei * 2 ]) rotate([ 0, 180, 0 ]) 
side_b();

//-------------------------
// Modules

module side_a()
{
    difference()
    {
        union()
        {
            disc($winder_wid, $winder_len, $winder_hei, $winder_hole_r, $winder_margin, $labels);

            translate([ 0, 0, $winder_hei / 2 ]) union()
            {
                difference()
                {
                    // Rounded box
                    union()
                    {
                        translate([ 0, 0, $box_hei_a / 2 ]) rcube2(Size = [ $box_wid, $box_len, $box_hei_a ], b = 10);

                        // Rounded box top
                        translate([ 0, 0, $box_hei_a + $box_hei_join / 2 ])
                            rcube2(Size = [ $box_wid - wall_thick - tolerance, $box_len - wall_thick - tolerance, $box_hei_join ], b = 10);
                    }

                    // Cut out the hole for the toroid
                    translate([ 0, 0, $box_hei_a / 2 + $box_hei_join / 2 + 1 ])
                        rcube2(Size = [ $box_wid - wall_thick * 2, $box_len - wall_thick * 2, $box_hei_a + $box_hei_join + 2 ], b = 10);

                    // Cut out the hole for RG-174 coax
                    translate([ -$box_wid / 8, $box_len / 2, coax_r ]) rotate([ -43, 90, 0 ])
                        cylinder(h = 20, r1 = coax_r, r2 = coax_r, center = true);

                    // Cut out the hole for locking pins
                    translate([ 0, 0, $box_hei_a + $box_hei_join / 2 + $winder_hei / 2 ]) rotate([ 0, 90, 0 ])
                        cylinder(h = $box_wid, r1 = pin_r, r2 = pin_r, center = true);
                    translate([ 0, 0, $box_hei_a + $box_hei_join / 2 + $winder_hei / 2 ]) rotate([ 90, 90, 0 ])
                        cylinder(h = $box_len, r1 = pin_r, r2 = pin_r, center = true);

                    // Opening for anetenna wire
                    translate([ 0, -coax_r * 2, $box_hei_a + $box_hei_join / 2 + $winder_hei / 2 ])
                        cube(size = [ $box_wid, coax_r, $box_hei_join - $winder_hei ], center = true);
                }

                // Pilar for the toroid
                union()
                {
                    translate([ 0, 0, ($box_hei_a + $box_hei_b + $winder_hei) / 2 ]) cylinder(
                        h = $box_hei_a + $box_hei_b + $winder_hei, r1 = pillar_r, r2 = pillar_r, center = true);
                    translate([ 0, 0, coax_r ]) cylinder(h = coax_r * 2, r1 = 16 / 2, r2 = 16 / 2, center = true);
                }
            }
        }
        // Cut out the hole for the hanging wire
        translate([ 0, 0, ($box_hei_a + $box_hei_b + $winder_hei * 2) / 2 ])
            cylinder(h = $box_hei_a + $box_hei_b + $winder_hei * 2 + 2, r1 = wire_r, r2 = wire_r, center = true);

        // Cut out for a finger
        cylinder(h = $winder_hei, r1 = finger_r, r2 = wire_r, center = true);
    }
}

module middle_disc()
{
    difference()
    {
        disc($winder_wid, $winder_len, $winder_hei, $winder_hole_r, $winder_margin);
        rcube2(Size = [ $box_wid - wall_thick, $box_len - wall_thick, $winder_hei ], b = 10);
    }
}

module side_b()
{
    difference()
    {
        union()
        {
            disc($winder_wid, $winder_len, $winder_hei, $winder_hole_r, $winder_margin, $labels);

            translate([ 0, 0, $winder_hei / 2 ]) union()
            {
                difference()
                {
                    // Rounded box
                    translate([ 0, 0, $box_hei_b / 2 ]) rcube2(Size = [ $box_wid, $box_len, $box_hei_b ], b = 10);

                    // Cut out the hole for the toroid
                    translate([ 0, 0, $box_hei_b / 2 + $box_hei_join / 2 + 1 ])
                        rcube2(Size = [ $box_wid - wall_thick, $box_len - wall_thick, $box_hei_b + 2 ], b = 10);

                    // Cut out the hole for locking pins
                    translate([ 0, 0, $box_hei_b - $box_hei_join / 2 + $winder_hei / 2 ]) rotate([ 0, 90, 0 ])
                        cylinder(h = $box_wid, r1 = pin_r, r2 = pin_r, center = true);
                    translate([ 0, 0, $box_hei_b - $box_hei_join / 2 + $winder_hei / 2 ]) rotate([ 90, 90, 0 ])
                        cylinder(h = $box_len, r1 = pin_r, r2 = pin_r, center = true);

                    // Opening for anetenna wire
                    translate([ 0, -coax_r * 2, $box_hei_b - $box_hei_join / 2 + $winder_hei / 2 ])
                        cube(size = [ $box_wid, coax_r, $box_hei_join - $winder_hei ], center = true);
                }
                difference()
                {
                    cylinder(h = $box_hei_join, r1 = pillar_r + 2, r2 = pillar_r + 2);
                    translate([ 0, 0, 1 ])
                    cylinder(h = $box_hei_join, r1 = pillar_r, r2 = pillar_r);
                }
            }
        }
        cylinder(h = $box_hei_b, r1 = wire_r, r2 = wire_r);
        // Cut out for a finger
        cylinder(h = $winder_hei, r1 = finger_r, r2 = wire_r, center = true);
    }
}

module disc(w, l, h, wr, m, labels)
{
    wd = w - l;
    difference()
    {
        // Oval
        hull() for (x = [ -wd / 2, wd / 2 ]) translate([ x, 0, h / 2 ])
            rcylinder(h = h, r1 = l / 2, r2 = l / 2, b = h / 3);

        for (i = [ -1, 1 ])
        {
            for (j = [ -52, 0, 52 ])
                translate([ i * (wd / 2), 0, 0 ]) rotate(j) translate([ i * (l / 2 - wr - m), 0, 0 ])
                    cylinder(h = h, r1 = wr, r2 = wr, center = true);
        }
        for (i = [ 0, 1 ])
        {
            rotate([ 0, 180, i * 180 ])
                translate([ 0, ($box_len / 2 + (l / 2 - $box_len / 2) / 2), 0.0 ]) if (labels[i])
                    linear_extrude(height = h, center = true)
                        text(labels[i], size = 12, font = "Courier:style=Bold", halign = "center", valign = "center");
            else rcube(Size = [ wd, (l - $box_len) / 2 - m * 2, h ], b = 2);
        }
    }
}

// Helper modules

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