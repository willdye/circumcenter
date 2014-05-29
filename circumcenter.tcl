#!/usr/bin/env tclsh

# circumcenter.tcl -- This demonstrates a fast algorithm for finding
# the circumcenter of three points (the circle which passes through
# all three points).  The algorithm was derived from "A Programmer's
# Geometry" by Bowyer & Woodwark.  --willdye, 2004-11-23

# For demonstration purposes, the input points are hardcoded here.
set Kx  80.0 ; set Ky  50.0 ;# First  point
set Lx 200.0 ; set Ly  20.0 ;# Second point
set Mx 230.0 ; set My 100.0 ;# Third  point

set LKx [expr { $Lx - $Kx }] ; set LKy [expr { $Ly - $Ky }]
set MKx [expr { $Mx - $Kx }] ; set MKy [expr { $My - $Ky }]

set faccuracy 0.00001 ;# Value depends on the application.
set determinant [expr { $LKx * $MKy - $MKx * $LKy }]
if {[expr { abs( $determinant ) < $faccuracy }]} {
    puts "Error: two or more points are coincident." ; exit}
set d2 [expr { 0.5 / $determinant }]

set LKr [expr {  $LKx * $LKx + $LKy * $LKy }]
set MKr [expr {  $MKx * $MKx + $MKy * $MKy }]
set Cx  [expr {( $LKr * $MKy - $MKr * $LKy ) * $d2 + $Kx }]
set Cy  [expr {( $LKx * $MKr - $MKx * $LKr ) * $d2 + $Ky }]

# We'll probably want the radius, also.  The straightforward
# method should be good enough in this case, but in general
# this is not very efficient, and has some accuracy issues.
set rad [expr { sqrt( pow( ( $Cx - $Kx ), 2 ) +
                      pow( ( $Cy - $Ky ), 2 ) ) }]

# Display the result.  If Tk is present, draw a picture.
puts "Circumcenter, as X/Y/Radius: $Cx $Cy $rad"
if { ! [package present Tk]} {exit}
destroy .c ; canvas .c -background gray ; pack .c
.c create polygon $Lx $Ly $Mx $My $Kx $Ky -fill white
.c create oval $Cx $Cy $Cx $Cy -fill black
.c create oval [expr { $Cx - $rad }] [expr { $Cy - $rad }] \
    [expr { $Cx + $rad }] [expr { $Cy + $rad }] -outline red
