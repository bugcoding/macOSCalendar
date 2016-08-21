//
//  PlanetData.swift
//  MacCalendar
//
//  Created by bugcode on 16/8/19.
//  // 本文件内容移植自<算法的乐趣>书中附带示例代码，源文件代码为c++，如有不妥请告知
//

import Foundation

// 行星数据
class PlanetData{
    // VSOP_87
    struct VSOP87_COEFFICIENT{
        var A:Double
        var B:Double
        var C:Double
        init(_ a:Double,_ b:Double,_ c:Double){
            A = a
            B = b
            C = c
        }
    }
    
    static let Earth_L0:[VSOP87_COEFFICIENT] = [
        VSOP87_COEFFICIENT( 175347046.0 ,   0.0000000 ,   000000.0000000 ) ,
        VSOP87_COEFFICIENT(   3341656.0 ,   4.6692568 ,     6283.0758500 ) ,
        VSOP87_COEFFICIENT(     34894.0 ,   4.6261000 ,    12566.1517000 ) ,
        VSOP87_COEFFICIENT(      3497.0 ,   2.7441000 ,     5753.3849000 ) ,
        VSOP87_COEFFICIENT(      3418.0 ,   2.8289000 ,        3.5231000 ) ,
        VSOP87_COEFFICIENT(      3136.0 ,   3.6277000 ,    77713.7715000 ) ,
        VSOP87_COEFFICIENT(      2676.0 ,   4.4181000 ,     7860.4194000 ) ,
        VSOP87_COEFFICIENT(      2343.0 ,   6.1352000 ,     3930.2097000 ) ,
        VSOP87_COEFFICIENT(      1324.0 ,   0.7425000 ,    11506.7698000 ) ,
        VSOP87_COEFFICIENT(      1273.0 ,   2.0371000 ,      529.6910000 ) ,
        VSOP87_COEFFICIENT(      1799.0 ,   1.1096000 ,     1577.3435000 ) ,
        VSOP87_COEFFICIENT(       990.0 ,   5.2330000 ,     5884.9270000 ) ,
        VSOP87_COEFFICIENT(       902.0 ,   2.0450000 ,       26.2980000 ) ,
        VSOP87_COEFFICIENT(       857.0 ,   3.5080000 ,      398.1490000 ) ,
        VSOP87_COEFFICIENT(       780.0 ,   1.1790000 ,     5223.6940000 ) ,
        VSOP87_COEFFICIENT(       753.0 ,   2.5330000 ,     5507.5530000 ) ,
        VSOP87_COEFFICIENT(       505.0 ,   4.5830000 ,    18849.2280000 ) ,
        VSOP87_COEFFICIENT(       492.0 ,   4.2050000 ,      775.5230000 ) ,
        VSOP87_COEFFICIENT(       357.0 ,   2.9200000 ,   000000.0670000 ) ,
        VSOP87_COEFFICIENT(       317.0 ,   5.8490000 ,    11790.6290000 ) ,
        VSOP87_COEFFICIENT(       284.0 ,   1.8990000 ,      796.2980000 ) ,
        VSOP87_COEFFICIENT(       271.0 ,   0.3150000 ,    10977.0790000 ) ,
        VSOP87_COEFFICIENT(       243.0 ,   0.3450000 ,     5486.7780000 ) ,
        VSOP87_COEFFICIENT(       206.0 ,   4.8060000 ,     2544.3140000 ) ,
        VSOP87_COEFFICIENT(       205.0 ,   1.8690000 ,     5573.1430000 ) ,
        VSOP87_COEFFICIENT(       202.0 ,   2.4580000 ,     6069.7770000 ) ,
        VSOP87_COEFFICIENT(       156.0 ,   0.8330000 ,      213.2990000 ) ,
        VSOP87_COEFFICIENT(       132.0 ,   3.4110000 ,     2942.4630000 ) ,
        VSOP87_COEFFICIENT(       126.0 ,   1.0830000 ,       20.7750000 ) ,
        VSOP87_COEFFICIENT(       119.0 ,   0.6450000 ,   000000.9800000 ) ,
        VSOP87_COEFFICIENT(       107.0 ,   0.6360000 ,     4694.0030000 ) ,
        VSOP87_COEFFICIENT(       102.0 ,   0.9760000 ,    15720.8390000 ) ,
        VSOP87_COEFFICIENT(       102.0 ,   4.2670000 ,        7.1140000 ) ,
        VSOP87_COEFFICIENT(        99.0 ,   6.2100000 ,     2146.1700000 ) ,
        VSOP87_COEFFICIENT(        98.0 ,   0.6800000 ,      155.4200000 ) ,
        VSOP87_COEFFICIENT(        86.0 ,   5.9800000 ,   161000.6900000 ) ,
        VSOP87_COEFFICIENT(        85.0 ,   1.3000000 ,     6275.9600000 ) ,
        VSOP87_COEFFICIENT(        85.0 ,   3.6700000 ,    71430.7000000 ) ,
        VSOP87_COEFFICIENT(        80.0 ,   1.8100000 ,    17260.1500000 ) ,
        VSOP87_COEFFICIENT(        79.0 ,   3.0400000 ,    12036.4600000 ) ,
        VSOP87_COEFFICIENT(        75.0 ,   1.7600000 ,     5088.6300000 ) ,
        VSOP87_COEFFICIENT(        74.0 ,   3.5000000 ,     3154.6900000 ) ,
        VSOP87_COEFFICIENT(        74.0 ,   4.6800000 ,      801.8200000 ) ,
        VSOP87_COEFFICIENT(        70.0 ,   0.8300000 ,     9437.7600000 ) ,
        VSOP87_COEFFICIENT(        62.0 ,   3.9800000 ,     8827.3900000 ) ,
        VSOP87_COEFFICIENT(        61.0 ,   1.8200000 ,     7084.9000000 ) ,
        VSOP87_COEFFICIENT(        57.0 ,   2.7800000 ,     6286.6000000 ) ,
        VSOP87_COEFFICIENT(        56.0 ,   4.3900000 ,    14143.5000000 ) ,
        VSOP87_COEFFICIENT(        56.0 ,   3.4700000 ,     6279.5500000 ) ,
        VSOP87_COEFFICIENT(        52.0 ,   0.1900000 ,    12139.5500000 ) ,
        VSOP87_COEFFICIENT(        52.0 ,   1.3300000 ,     1748.0200000 ) ,
        VSOP87_COEFFICIENT(        51.0 ,   0.2800000 ,     5856.4800000 ) ,
        VSOP87_COEFFICIENT(        49.0 ,   0.4900000 ,     1194.4500000 ) ,
        VSOP87_COEFFICIENT(        41.0 ,   5.3700000 ,     8429.2400000 ) ,
        VSOP87_COEFFICIENT(        41.0 ,   2.4000000 ,    19651.0500000 ) ,
        VSOP87_COEFFICIENT(        39.0 ,   6.1700000 ,    10447.3900000 ) ,
        VSOP87_COEFFICIENT(        37.0 ,   6.0400000 ,    10213.2900000 ) ,
        VSOP87_COEFFICIENT(        37.0 ,   2.5700000 ,     1059.3800000 ) ,
        VSOP87_COEFFICIENT(        36.0 ,   1.7100000 ,     2352.8700000 ) ,
        VSOP87_COEFFICIENT(        36.0 ,   1.7800000 ,     6812.7700000 ) ,
        VSOP87_COEFFICIENT(        33.0 ,   0.5900000 ,    17789.8500000 ) ,
        VSOP87_COEFFICIENT(        30.0 ,   0.4400000 ,    83996.8500000 ) ,
        VSOP87_COEFFICIENT(        30.0 ,   2.7400000 ,     1349.8700000 ) ,
        VSOP87_COEFFICIENT(        25.0 ,   3.1600000 ,     4690.4800000 )
    ]
    
    static let Earth_L1:[VSOP87_COEFFICIENT] = [
        VSOP87_COEFFICIENT( 628331966747.0 , 0.000000 ,   00000.0000000 ) ,
        VSOP87_COEFFICIENT(       206059.0 , 2.678235 ,    6283.0758500 ) ,
        VSOP87_COEFFICIENT(         4303.0 , 2.635100 ,   12566.1517000 ) ,
        VSOP87_COEFFICIENT(          425.0 , 1.590000 ,       3.5230000 ) ,
        VSOP87_COEFFICIENT(          119.0 , 5.796000 ,      26.2980000 ) ,
        VSOP87_COEFFICIENT(          109.0 , 2.966000 ,    1577.3440000 ) ,
        VSOP87_COEFFICIENT(           93.0 , 2.590000 ,   18849.2300000 ) ,
        VSOP87_COEFFICIENT(           72.0 , 1.140000 ,     529.6900000 ) ,
        VSOP87_COEFFICIENT(           68.0 , 1.870000 ,     398.1500000 ) ,
        VSOP87_COEFFICIENT(           67.0 , 4.410000 ,    5507.5500000 ) ,
        VSOP87_COEFFICIENT(           59.0 , 2.890000 ,    5223.6900000 ) ,
        VSOP87_COEFFICIENT(           56.0 , 2.170000 ,     155.4200000 ) ,
        VSOP87_COEFFICIENT(           45.0 , 0.400000 ,     796.3000000 ) ,
        VSOP87_COEFFICIENT(           36.0 , 0.470000 ,     775.5200000 ) ,
        VSOP87_COEFFICIENT(           29.0 , 2.650000 ,       7.1100000 ) ,
        VSOP87_COEFFICIENT(           21.0 , 5.340000 ,   00000.9800000 ) ,
        VSOP87_COEFFICIENT(           19.0 , 1.850000 ,    5486.7800000 ) ,
        VSOP87_COEFFICIENT(           19.0 , 4.970000 ,     213.3000000 ) ,
        VSOP87_COEFFICIENT(           17.0 , 2.990000 ,    6275.9600000 ) ,
        VSOP87_COEFFICIENT(           16.0 , 0.030000 ,    2544.3100000 ) ,
        VSOP87_COEFFICIENT(           16.0 , 1.430000 ,    2146.1700000 ) ,
        VSOP87_COEFFICIENT(           15.0 , 1.210000 ,   10977.0800000 ) ,
        VSOP87_COEFFICIENT(           12.0 , 2.830000 ,    1748.0200000 ) ,
        VSOP87_COEFFICIENT(           12.0 , 3.260000 ,    5088.6300000 ) ,
        VSOP87_COEFFICIENT(           12.0 , 5.270000 ,    1194.4500000 ) ,
        VSOP87_COEFFICIENT(           12.0 , 2.080000 ,    4694.0000000 ) ,
        VSOP87_COEFFICIENT(           11.0 , 0.770000 ,     553.5700000 ) ,
        VSOP87_COEFFICIENT(           10.0 , 1.300000 ,    6286.6000000 ) ,
        VSOP87_COEFFICIENT(           10.0 , 4.240000 ,    1349.8700000 ) ,
        VSOP87_COEFFICIENT(            9.0 , 2.700000 ,     242.7300000 ) ,
        VSOP87_COEFFICIENT(            9.0 , 5.640000 ,     951.7200000 ) ,
        VSOP87_COEFFICIENT(            8.0 , 5.300000 ,    2352.8700000 ) ,
        VSOP87_COEFFICIENT(            6.0 , 2.650000 ,    9437.7600000 ) ,
        VSOP87_COEFFICIENT(            6.0 , 4.670000 ,    4690.4800000 )
    ]
    
    static let Earth_L2:[VSOP87_COEFFICIENT] = [
        VSOP87_COEFFICIENT( 52919.0 ,   0.0000 ,   00000.0000 ) ,
        VSOP87_COEFFICIENT( 8720.0  ,   1.0721 ,   6283.0758  ) ,
        VSOP87_COEFFICIENT(   309.0 ,   0.8670 ,   12566.1520 ) ,
        VSOP87_COEFFICIENT(    27.0 ,   0.0500 ,       3.5200 ) ,
        VSOP87_COEFFICIENT(    16.0 ,   5.1900 ,      26.3000 ) ,
        VSOP87_COEFFICIENT(    16.0 ,   3.6800 ,     155.4200 ) ,
        VSOP87_COEFFICIENT(    10.0 ,   0.7600 ,   18849.2300 ) ,
        VSOP87_COEFFICIENT(     9.0 ,   2.0600 ,   77713.7700 ) ,
        VSOP87_COEFFICIENT(     7.0 ,   0.8300 ,     775.5200 ) ,
        VSOP87_COEFFICIENT(     5.0 ,   4.6600 ,    1577.3400 ) ,
        VSOP87_COEFFICIENT(     4.0 ,   1.0300 ,       7.1100 ) ,
        VSOP87_COEFFICIENT(     4.0 ,   3.4400 ,    5573.1400 ) ,
        VSOP87_COEFFICIENT(     3.0 ,   5.1400 ,     796.3000 ) ,
        VSOP87_COEFFICIENT(     3.0 ,   6.0500 ,    5507.5500 ) ,
        VSOP87_COEFFICIENT(     3.0 ,   1.1900 ,     242.7300 ) ,
        VSOP87_COEFFICIENT(     3.0 ,   6.1200 ,     529.6900 ) ,
        VSOP87_COEFFICIENT(     3.0 ,   0.3100 ,     398.1500 ) ,
        VSOP87_COEFFICIENT(     3.0 ,   2.2800 ,     553.5700 ) ,
        VSOP87_COEFFICIENT(     2.0 ,   4.3800 ,    5223.6900 ) ,
        VSOP87_COEFFICIENT(     2.0 ,   3.7500 ,   00000.9800 )
    ]


    static let Earth_L3:[VSOP87_COEFFICIENT] = [
        VSOP87_COEFFICIENT( 289.0 ,   5.844 , 6283.076  ) ,
        VSOP87_COEFFICIENT( 35.0  ,   0.000 , 00000.000 ) ,
        VSOP87_COEFFICIENT( 17.0  ,   5.490 , 12566.150 ) ,
        VSOP87_COEFFICIENT(   3.0 ,   5.200 ,   155.420 ) ,
        VSOP87_COEFFICIENT(   1.0 ,   4.720 ,     3.520 ) ,
        VSOP87_COEFFICIENT(   1.0 ,   5.300 , 18849.230 ) ,
        VSOP87_COEFFICIENT(   1.0 ,   5.970 ,   242.730 )
    ]
    
    static let Earth_L4:[VSOP87_COEFFICIENT] = [
        VSOP87_COEFFICIENT( 114.0 , 3.142 , 00000.00 ) ,
        VSOP87_COEFFICIENT(   8.0 , 4.130 ,  6283.08 ) ,
        VSOP87_COEFFICIENT(   1.0 , 3.840 , 12566.15 )
    ]
    static let Earth_L5:[VSOP87_COEFFICIENT] = [
        VSOP87_COEFFICIENT( 1.0 , 3.14 , 0.0 )
    ]
    
    
    static let Earth_B0:[VSOP87_COEFFICIENT] = [
        VSOP87_COEFFICIENT( 280.0 , 3.199 , 84334.662) ,
        VSOP87_COEFFICIENT( 102.0 , 5.422 , 5507.553 ) ,
        VSOP87_COEFFICIENT( 80.0  , 3.880 , 5223.690 ) ,
        VSOP87_COEFFICIENT( 44.0  , 3.700 , 2352.870 ) ,
        VSOP87_COEFFICIENT( 32.0  , 4.000 , 1577.340 )
    ]
    
    static let Earth_B1:[VSOP87_COEFFICIENT] = [
        VSOP87_COEFFICIENT( 9.0 , 3.90 , 5507.55 ) ,
        VSOP87_COEFFICIENT( 6.0 , 1.73 , 5223.69 )
    ]
    
    static let Earth_B2:[VSOP87_COEFFICIENT] = [
        
        VSOP87_COEFFICIENT( 22378.0 , 3.38509 , 10213.28555 ) ,
        VSOP87_COEFFICIENT(   282.0 , 0.00000 , 00000.00000 ) ,
        VSOP87_COEFFICIENT(   173.0 , 5.25600 , 20426.57100 ) ,
        VSOP87_COEFFICIENT(    27.0 , 3.87000 , 30639.86000 )
    ]
    static let Earth_B3:[VSOP87_COEFFICIENT] = [
        
        VSOP87_COEFFICIENT( 647.0 , 4.992 , 10213.286 ) ,
        VSOP87_COEFFICIENT( 20.0  , 3.140 , 00000.000 ) ,
        VSOP87_COEFFICIENT(   6.0 , 0.770 , 20426.570 ) ,
        VSOP87_COEFFICIENT(   3.0 , 5.440 , 30639.860 )
    ]
    
    static let  Earth_B4:[VSOP87_COEFFICIENT] = [
        VSOP87_COEFFICIENT( 14.0 , 0.32 , 10213.29 )
    ]
    
    
    static let Earth_R0:[VSOP87_COEFFICIENT] = [
        VSOP87_COEFFICIENT( 100013989   , 0         ,    0           ),
        VSOP87_COEFFICIENT( 1670700     , 3.0984635 ,    6283.0758500),
        VSOP87_COEFFICIENT( 13956       , 3.05525   ,   12566.15170  ),
        VSOP87_COEFFICIENT( 3084        , 5.1985    ,   77713.7715   ),
        VSOP87_COEFFICIENT( 1628        , 1.1739    ,   5753.3849    ),
        VSOP87_COEFFICIENT( 1576        , 2.8469    ,   7860.4194    ),
        VSOP87_COEFFICIENT( 925         , 5.453     ,   11506.770    ),
        VSOP87_COEFFICIENT( 542         , 4.564     ,   3930.210     ),
        VSOP87_COEFFICIENT( 472         , 3.661     ,   5884.927     ),
        VSOP87_COEFFICIENT( 346         , 0.964     ,   5507.553     ),
        VSOP87_COEFFICIENT( 329         , 5.900     ,   5223.694     ),
        VSOP87_COEFFICIENT( 307         , 0.299     ,   5573.143     ),
        VSOP87_COEFFICIENT( 243         , 4.273     ,   11790.629    ),
        VSOP87_COEFFICIENT( 212         , 5.847     ,   1577.344     ),
        VSOP87_COEFFICIENT( 186         , 5.022     ,   10977.079    ),
        VSOP87_COEFFICIENT( 175         , 3.012     ,   18849.228    ),
        VSOP87_COEFFICIENT( 110         , 5.055     ,   5486.778     ),
        VSOP87_COEFFICIENT( 98          , 0.89      ,   6069.78      ),
        VSOP87_COEFFICIENT( 86          , 5.69      ,   15720.84     ),
        VSOP87_COEFFICIENT( 86          , 1.27      ,   161000.69    ),
        VSOP87_COEFFICIENT( 65          , 0.27      ,   17260.15     ),
        VSOP87_COEFFICIENT( 63          , 0.92      ,   529.69       ),
        VSOP87_COEFFICIENT( 57          , 2.01      ,   83996.85     ),
        VSOP87_COEFFICIENT( 56          , 5.24      ,   71430.70     ),
        VSOP87_COEFFICIENT( 49          , 3.25      ,   2544.31      ),
        VSOP87_COEFFICIENT( 47          , 2.58      ,   775.52       ),
        VSOP87_COEFFICIENT( 45          , 5.54      ,   9437.76      ),
        VSOP87_COEFFICIENT( 43          , 6.01      ,   6275.96      ),
        VSOP87_COEFFICIENT( 39          , 5.36      ,   4694.00      ),
        VSOP87_COEFFICIENT( 38          , 2.39      ,   8827.39      ),
        VSOP87_COEFFICIENT( 37          , 0.83      ,   19651.05     ),
        VSOP87_COEFFICIENT( 37          , 4.90      ,   12139.55     ),
        VSOP87_COEFFICIENT( 36          , 1.67      ,   12036.46     ),
        VSOP87_COEFFICIENT( 35          , 1.84      ,   2942.46      ),
        VSOP87_COEFFICIENT( 33          , 0.24      ,   7084.90      ),
        VSOP87_COEFFICIENT( 32          , 0.18      ,   5088.63      ),
        VSOP87_COEFFICIENT( 32          , 1.78      ,   398.15       ),
        VSOP87_COEFFICIENT( 28          , 1.21      ,   6286.60      ),
        VSOP87_COEFFICIENT( 28          , 1.90      ,   6279.55      ),
        VSOP87_COEFFICIENT( 26          , 4.59      ,   10447.39     )
    ]
    static let Earth_R1:[VSOP87_COEFFICIENT] = [
        VSOP87_COEFFICIENT( 103019 , 1.107490 , 6283.075850 ),
        VSOP87_COEFFICIENT( 1721   , 1.0644   , 12566.1517  ),
        VSOP87_COEFFICIENT( 702    , 3.142    , 0           ),
        VSOP87_COEFFICIENT( 32     , 1.02     , 18849.23    ),
        VSOP87_COEFFICIENT( 31     , 2.84     , 5507.55     ),
        VSOP87_COEFFICIENT( 25     , 1.32     , 5223.69     ),
        VSOP87_COEFFICIENT( 18     , 1.42     , 1577.34     ),
        VSOP87_COEFFICIENT( 10     , 5.91     , 10977.08    ),
        VSOP87_COEFFICIENT( 9      , 1.42     , 6275.96     ),
        VSOP87_COEFFICIENT( 9      , 0.27     , 5486.78     )
    ]
    static let Earth_R2:[VSOP87_COEFFICIENT] = [
        VSOP87_COEFFICIENT( 4359 , 5.7846 , 6283.0758 ),
        VSOP87_COEFFICIENT( 124  , 5.579  , 12566.152 ),
        VSOP87_COEFFICIENT( 12   , 3.14   , 0         ),
        VSOP87_COEFFICIENT( 9    , 3.63   , 77713.77  ),
        VSOP87_COEFFICIENT( 6    , 1.87   , 5573.14   ),
        VSOP87_COEFFICIENT( 3    , 5.47   , 18849.23  )
    ]
    static let Earth_R3:[VSOP87_COEFFICIENT] = [
        VSOP87_COEFFICIENT( 145 , 4.273 , 6283.076 ),
        VSOP87_COEFFICIENT(   7 , 3.92 ,  12566.15 )
    ]
    static let Earth_R4:[VSOP87_COEFFICIENT] = [
        VSOP87_COEFFICIENT( 4 , 2.56 , 6283.08 )
    ]
    
    // elp2000
    struct MOON_ECLIPTIC_LONGITUDE_COEFF{
        var D:Double
        var M:Double
        var Mp:Double
        var F:Double
        var eiA:Double
        var erA:Double
        init(_ d:Double, _ m:Double, _ mp:Double, _ f:Double, _ eia:Double, _ era:Double){
            D = d
            M = m
            Mp = mp
            F = f
            eiA = eia
            erA = era
        }
    }
    
    static let  Moon_longitude:[MOON_ECLIPTIC_LONGITUDE_COEFF] = [
        MOON_ECLIPTIC_LONGITUDE_COEFF( 0,  0,  1,  0, 6288744, -20905355 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2,  0, -1,  0, 1274027,  -3699111 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2,  0,  0,  0,  658314,  -2955968 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 0,  0,  2,  0,  213618,   -569925 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 0,  1,  0,  0, -185116,     48888 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 0,  0,  0,  2, -114332,     -3149 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2,  0, -2,  0,   58793,    246158 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2, -1, -1,  0,   57066,   -152138 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2,  0,  1,  0,   53322,   -170733 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2, -1,  0,  0,   45758,   -204586 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 0,  1, -1,  0,  -40923,   -129620 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 1,  0,  0,  0,  -34720,    108743 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 0,  1,  1,  0,  -30383,    104755 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2,  0,  0, -2,   15327,     10321 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 0,  0,  1,  2,  -12528,         0 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 0,  0,  1, -2,   10980,     79661 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 4,  0, -1,  0,   10675,    -34782 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 0,  0,  3,  0,   10034,    -23210 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 4,  0, -2,  0,    8548,    -21636 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2,  1, -1,  0,   -7888,     24208 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2,  1,  0,  0,   -6766,     30824 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 1,  0, -1,  0,   -5163,     -8379 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 1,  1,  0,  0,    4987,    -16675 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2, -1,  1,  0,    4036,    -12831 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2,  0,  2,  0,    3994,    -10445 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 4,  0,  0,  0,    3861,    -11650 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2,  0, -3,  0,    3665,     14403 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 0,  1, -2,  0,   -2689,     -7003 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2,  0, -1,  2,   -2602,         0 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2, -1, -2,  0,    2390,     10056 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 1,  0,  1,  0,   -2348,      6322 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2, -2,  0,  0,    2236,     -9884 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 0,  1,  2,  0,   -2120,      5751 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 0,  2,  0,  0,   -2069,         0 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2, -2, -1,  0,    2048,     -4950 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2,  0,  1, -2,   -1773,      4130 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2,  0,  0,  2,   -1595,         0 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 4, -1, -1,  0,    1215,     -3958 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 0,  0,  2,  2,   -1110,         0 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 3,  0, -1,  0,    -892,      3258 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2,  1,  1,  0,    -810,      2616 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 4, -1, -2,  0,     759,     -1897 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 0,  2, -1,  0,    -713,     -2117 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2,  2, -1,  0,    -700,      2354 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2,  1, -2,  0,     691,         0 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2, -1,  0, -2,     596,         0 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 4,  0,  1,  0,     549,     -1423 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 0,  0,  4,  0,     537,     -1117 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 4, -1,  0,  0,     520,     -1571 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 1,  0, -2,  0,    -487,     -1739 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2,  1,  0, -2,    -399,         0 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 0,  0,  2, -2,    -381,     -4421 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 1,  1,  1,  0,     351,         0 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 3,  0, -2,  0,    -340,         0 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 4,  0, -3,  0,     330,         0 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2, -1,  2,  0,     327,         0 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 0,  2,  1,  0,    -323,      1165 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 1,  1, -1,  0,     299,         0 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2,  0,  3,  0,     294,         0 ),
        MOON_ECLIPTIC_LONGITUDE_COEFF( 2,  0, -1, -2,       0,      8752 )
    ]


    struct MOON_ECLIPTIC_LATITUDE_COEFF{
        var D:Double
        var M:Double
        var Mp:Double
        var F:Double
        var eiA:Double
        init(_ d:Double, _ m:Double, _ mp:Double, _ f:Double, _ eia:Double){
            D = d
            M = m
            Mp = mp
            F = f
            eiA = eia
        }
        
    }

    
    static let moon_Latitude:[MOON_ECLIPTIC_LATITUDE_COEFF] = [
        MOON_ECLIPTIC_LATITUDE_COEFF( 0,  0,  0,  1, 5128122 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 0,  0,  1,  1,  280602 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 0,  0,  1, -1,  277693 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2,  0,  0, -1,  173237 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2,  0, -1,  1,   55413 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2,  0, -1, -1,   46271 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2,  0,  0,  1,   32573 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 0,  0,  2,  1,   17198 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2,  0,  1, -1,    9266 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 0,  0,  2, -1,    8822 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2, -1,  0, -1,    8216 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2,  0, -2, -1,    4324 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2,  0,  1,  1,    4200 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2,  1,  0, -1,   -3359 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2, -1, -1,  1,    2463 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2, -1,  0,  1,    2211 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2, -1, -1, -1,    2065 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 0,  1, -1, -1,   -1870 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 4,  0, -1, -1,    1828 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 0,  1,  0,  1,   -1794 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 0,  0,  0,  3,   -1749 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 0,  1, -1,  1,   -1565 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 1,  0,  0,  1,   -1491 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 0,  1,  1,  1,   -1475 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 0,  1,  1, -1,   -1410 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 0,  1,  0, -1,   -1344 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 1,  0,  0, -1,   -1335 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 0,  0,  3,  1,    1107 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 4,  0,  0, -1,    1021 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 4,  0, -1,  1,     833 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 0,  0,  1, -3,     777 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 4,  0, -2,  1,     671 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2,  0,  0, -3,     607 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2,  0,  2, -1,     596 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2, -1,  1, -1,     491 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2,  0, -2,  1,    -451 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 0,  0,  3, -1,     439 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2,  0,  2,  1,     422 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2,  0, -3, -1,     421 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2,  1, -1,  1,    -366 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2,  1,  0,  1,    -351 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 4,  0,  0,  1,     331 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2, -1,  1,  1,     315 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2, -2,  0, -1,     302 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 0,  0,  1,  3,    -283 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2,  1,  1, -1,    -229 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 1,  1,  0, -1,     223 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 1,  1,  0,  1,     223 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 0,  1, -2, -1,    -220 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2,  1, -1, -1,    -220 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 1,  0,  1,  1,    -185 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2, -1, -2, -1,     181 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 0,  1,  2,  1,    -177 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 4,  0, -2, -1,     176 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 4, -1, -1, -1,     166 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 1,  0,  1, -1,    -164 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 4,  0,  1, -1,     132 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 1,  0, -1, -1,    -119 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 4, -1,  0, -1,     115 ),
        MOON_ECLIPTIC_LATITUDE_COEFF( 2, -2,  0,  1,     107 )
    ]
    
}
