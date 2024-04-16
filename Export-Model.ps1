if(-not (Get-Command openscad -ErrorAction SilentlyContinue)) {
    Set-Alias openscad "C:\Program Files\OpenSCAD\openscad.exe"
}

openscad -o ENHW_Tiny_Winder.png ENHW_Tiny_Winder.scad

openscad -D render_part=side_a -o ENHW_Tiny_Winder-side-a.stl ENHW_Tiny_Winder.scad
openscad -D render_part=side_b -o ENHW_Tiny_Winder-side-b.stl ENHW_Tiny_Winder.scad
openscad -D render_part=middle_disc -o ENHW_Tiny_Winder-middle-disc.stl ENHW_Tiny_Winder.scad