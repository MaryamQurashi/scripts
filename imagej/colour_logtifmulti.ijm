// Copyright (C) 2015 Carnë Draug <carandraug+dev@gmail.com>
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, see <http://www.gnu.org/licenses/>.

// Very simple macro, to color, reshape, and set pixel size for the log
// tifs generated by our Octave scripts.

dir1 = getDirectory("Choose Source Directory ");
dir2 = getDirectory("Choose Destination Directory ");
list = getFileList(dir1);     //gets list of files in dir1
setBatchMode(true);
for (i=0; i<list.length; i++) {
    showProgress(i+1, list.length);

    open(filename);

                    nChannels = 6;
                    nZ = nSlices() / nChannels;
                    run("Stack to Hyperstack...",
                        "order=xyczt(default)"
                        + " channels=" + nChannels
                        + " slices=" + nZ
                        + " frames=1"
                        + " display=Color");
                    run("Properties...",
                        "channels=" + nChannels
                        + " slices=" + nZ
                        + " frames=1"
                        + " unit=micron"
                        + " pixel_width=0.0395000"
                        + " pixel_height=0.0395000"
                        + " voxel_depth=0.125");

                    Stack.setPosition(1, 1, 1);
                    run("Green");
                    Stack.setPosition(2, 1, 1);
                    run("Cyan");

                    Stack.setPosition(3, 1, 1);
                    run("Red");
                    Stack.setPosition(4, 1, 1);
                    run("Magenta");

                    Stack.setPosition(5, 1, 1);
                    run("Grays");
                    Stack.setPosition(6, 1, 1);
                    run("Blue");

    saveAs("TIFF", dir2+list[i]);     //saves as a new tiff in dir2
  close();
}

