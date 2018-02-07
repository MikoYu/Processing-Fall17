# Programming Project 1 - Snowflakes
#CCA/Semester/17fall #CCA/IxDFDN/Programming

## Proposal
### Description
This project will present an interactive, 3D projected animation (or Augmented Reality animation) of falling snow, created by both the designer and audience, in a small exhibition room in Snow Crystals Museum (雪の美術館) in Asahikawa, Hokkaido. In this chilling, dreamy room, the audience can see different sorts of snow falling down. Furthermore, they can also draw their own snowflakes in the space on a touch screen (or even, by waving one finger in the air). The movement will be automatically translated to icy strokes with hexagonal symmetry, i.e., the snowflakes, which will instantly appear in the room. They may also influence the trajectory of the snow by making sounds. The exhibition space will transform into a beautiful exhibition hall full of fun and surprise.

### Technical Features
- hexagonally symmetric pattern generation
- Particle animation of snowflakes falling down
- 3D projection

### External Links
* [雪の美術館](http://yukibi.marryblossom.com/)


## Final Deliverables
A 2D demo, with 2 processing files.

![](Snowflakes_documentation/Snowflakes_documentation/falling-snow.png)
Main program - snowflakes falling down


![](Snowflakes_documentation/Snowflakes_documentation/drawing.png)
Draw to generate snowflakes


### Instructions
1. Run snow/snow.pde to see snowflakes (in snow/data) falling down.
2. Run snow/snowflake/snowflake.pde, Draw snowflakes on the canvas by dragging the mouse. Press “S” to save; press “Space” to refresh.
3. Saved snowflakes have a probability to appear on the falling scene.

### Further iteration
- for more seemingly natural movement: noise, sin/cos, etc.
- 3D / resize and spin and other transformation to imitate 3D effect
