# HW5

Obtain the activities of daily life dataset from the UC Irvine machine learning website 
(https://archive.ics.uci.edu/ml/datasets/Dataset+for+ADL+Recognition+with+Wrist-worn+Accelerometer
data provided by Barbara Bruno, Fulvio Mastrogiovanni and Antonio Sgorbissa).

## Part A:


Build a classifier that classifies sequences into one of the 14 activities provided.
To make features, you should vector quantize, then use a histogram
of cluster centers (as described in the subsection; this gives a pretty explicit
set of steps to follow). You will find it helpful to use hierarchical
k-means to vector quantize. You may use whatever multi-class classifier
you wish, though I’d start with R’s decision forest, because it’s easy to
use and effective. You should report (a) the total error rate and (b) the
class confusion matrix of your classifier.

## Part B:

Now see if you can improve your classifier by (a) modifying the number
of cluster centers in your hierarchical k-means and (b) modifying the size
of the fixed length samples that you use.



# Public Dataset of Accelerometer Data for Human Motion Primitives Detection

## 1. What is it?

The Public Dataset of Accelerometer Data for Human Motion Primitives Detection is a public collection of labelled accelerometer data recordings to be used for the creation and validation of acceleration models of human motion primitives.

We believe that, in a similar fashion to computer vision public datasets, the adoption of common testbenches for human motion primitives detection algorithms will allow for a better comparison between different approaches and ultimately lead to the development of more accurate and reliable solutions.

Detailed documentation about the dataset is provided in the file MANUAL.TXT.

A description of the Human Motion Primitives detection system that we have designed to work with the provided dataset can be found at:
- [BRUNO13]
  Bruno, B., Mastrogiovanni, F., Sgorbissa, A., Vernazza, T., Zaccaria, R.:
  Analysis of human behavior recognition algorithms based on acceleration data.
  In: IEEE Int Conf on Robotics and Automation (ICRA),
  pp. 1602--1607 (2013)

- [BRUNO12]
  Bruno, B., Mastrogiovanni, F., Sgorbissa, A., Vernazza, T., Zaccaria, R.:
  Human motion modelling and recognition: A computational approach.
  In: IEEE Int Conf on Automation Science and Engineering (CASE),
  pp. 156--161 (2012)

## 2. Version

Version: 1
Released on: 11/02/2014

## 3. Documentation

Up-to-date documentation for this release is provided in the file MANUAL.TXT

## 4. Installation & usage

This dataset does not require any installation.

The provided MATLAB scripts "displayTrial.m" and "displayModel.m" allow for visualization of the recorded accelerometer data. A description and example usage of the scripts can be accessed within MATLAB environment with the commands:
    help displayTrial
    help displayModel

The provided MATLAB scripts have been developed and tested with MATLAB R2008a.

## 5. Licensing

This dataset is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY, including the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
The authors allow the users of the Public Dataset of Accelerometer Data for Human Motion Primitives Detection to use and modify it for their own research. Any commercial application, redistribution, etc... has to be arranged between users and authors individually.

For further license information, please contact the authors.

## 6. Authors contacts

If you want to be informed about db updates and new code releases, obtain further information about the provided db, or contribute to its development please write to:
- Barbara Bruno
  Laboratorium, dept. DIBRIS
  Università degli Studi di Genova (Italy)
  barbara.bruno@unige.it

- Fulvio Mastrogiovanni
  Laboratorium, dept. DIBRIS
  Università degli Studi di Genova (Italy)
  fulvio.mastrogiovanni@unige.it

- Antonio Sgorbissa
  Laboratorium, dept. DIBRIS
  Università degli Studi di Genova (Italy)
  antonio.sgorbissa@unige.it



# Manual

## 1. Files tree

ROOT
- brush_teeth (12 elements)
- climb_stairs (102 elements)
- climb_stairs_MODEL (20 elements)
- comb_hair (31 elements)
- descend_stairs (42 elements)
- drink_glass (100 elements)
- drink_glass_MODEL (20 elements)
- eat_meat (5 elements)
- eat_soup (3 elements)
- getup_bed (101 elements)
- getup_bed_MODEL (20 elements)
- liedown_bed (28 elements)
- pour_water (100 elements)
- pour_water_MODEL (20 elements)
- sitdown_chair (100 elements)
- sitdown_chair_MODEL (20 elements)
- standup_chair (102 elements)
- standup_chair_MODEL (20 elements)
- use_telephone (13 elements)
- walk (100 elements)
- walk_MODEL (20 elements)
- displayModel.m
- displayTrial.m
- MANUAL.TXT
- README.TXT

## 2. Human Motion Primitives

The dataset provides labelled recorded executions of a number of simple human
activities, which are defined as Human Motion Primitives (HMP):
    1. brush_teeth:    to brush one's teeth with a tootbrush
               (complete gesture)
    2. climb_stairs:   to climb a number of steps of a staircase
    3. comb_hair:      to comb one's hair with a brush
               (complete gesture)
    4. descend_stairs: to descend a number of steps of a staircase
    5. drink_glass:    to pick a glass from a table, drink and put it
               back on the table
    6. eat_meat:       to eat something using fork and knife
               (complete gesture)
    7. eat_soup:       to eat something using a spoon
               (complete gesture)
    8. getup_bed:      to get up from a lying position on a bed
    9. liedown_bed:    to lie down from a standing position on a bed
    10.pour_water:     to pick a bottle from a table, pour its content
               in a glass on the table and put it back on the table
    11.sitdown_chair:  to sit down on a chair
    12.standup_chair:  to stand up from a chair
    13.use_telephone:  to place a telephone call using a fixed telephone
               (complete gesture)
    14.walk:       to take a number of steps

## 3. Accelerometer specifications

Type:          tri-axial accelerometer
Measurement range: [- 1.5g; + 1.5g]
Sensitivity:       6 bits per axis
Output data rate:  32 Hz
Location:      attached to the right wrist of the user with:
           - x axis: pointing toward the hand
           - y axis: pointing toward the left
           - z axis: perpendicular to the plane of the hand

## 4. Data format

### 4.1. File naming convention

Each file in the dataset follows the following naming convention:
Accelerometer-[START_TIME]-[HMP]-[VOLUNTEER]
where:
- [START_TIME]: timestamp of the starting moment of the recording
        in the format [YYYY-MM-DD-HH-MM-SS]
- [HMP]:    name of the HMP performed in the recorded trial, following
        the naming convention specified in Section 2 of this manual
- [VOLUNTEER]:  identification code of the volunteer performing the recorded
        motion in the format [gN] where:
        - "g" indicates the gender of the volunteer
          (m -> male, f -> female)
        - "N" indicates the progressive number associated to the
          volunteer

For example the file:
    Accelerometer-2011-03-24-10-24-39-climb_stairs-f1.txt
refers to an accelerometer recording that was taken on March 24, 2011, starting from 10:24.39 a.m.. The recording refers to the HMP "climb_stairs" executed by the volunteer with ID "f1".

### 4.2 Acceleration data coding

Acceleration data recorded in the dataset are coded according to the following mapping:
    [0; +63] = [-1.5g; +1.5g]
The conversion rule to extract the real acceleration value from the coded value is the following:
    real_val = -1.5g + (coded_val/63)*3g

## 5. Dataset acquisition details

### 5.1 Volunteers

The dataset is composed of the recordings of selected Human Motion Primitives perfomed by a total of 16 volunteers.

Basic information about the volunteers are reported in the table below:

| Gender|       Age        |      Weight      |

| M | F | Min | Max | Avg  | Min | Max | Avg  |

|-------|------------------|------------------|

| 11| 5 | 19  | 81  | 57.4 | 56  | 85  | 72.7 |

### 5.2 Hardware setup

The tri-axial accelerometer is embedded in an ad-hoc sensing device (40mm x 22 mm x 12 mm) that is attached at the right wrist of the user. Data transmission to the PC is wired, via a USB cable.
