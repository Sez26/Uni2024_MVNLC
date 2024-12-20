#ifndef TIME_SERIES_DATA_H
#define TIME_SERIES_DATA_H

const int ref_t[] = {0.0, 0.10101010101010101, 0.20202020202020202, 0.30303030303030304, 0.40404040404040403, 0.5050505050505051, 0.6060606060606061, 0.7070707070707071, 0.8080808080808081, 0.9090909090909091, 1.0101010101010102, 1.1111111111111112, 1.2121212121212122, 1.3131313131313131, 1.4141414141414141, 1.5151515151515151, 1.6161616161616161, 1.7171717171717171, 1.8181818181818181, 1.9191919191919191, 2.0202020202020203, 2.121212121212121, 2.2222222222222223, 2.323232323232323, 2.4242424242424243, 2.525252525252525, 2.6262626262626263, 2.727272727272727, 2.8282828282828283, 2.929292929292929, 3.0303030303030303, 3.131313131313131, 3.2323232323232323, 3.3333333333333335, 3.4343434343434343, 3.5353535353535355, 3.6363636363636362, 3.7373737373737375, 3.8383838383838382, 3.9393939393939394, 4.040404040404041, 4.141414141414141, 4.242424242424242, 4.343434343434343, 4.444444444444445, 4.545454545454545, 4.646464646464646, 4.747474747474747, 4.848484848484849, 4.94949494949495, 5.05050505050505, 5.151515151515151, 5.252525252525253, 5.353535353535354, 5.454545454545454, 5.555555555555555, 5.656565656565657, 5.757575757575758, 5.858585858585858, 5.959595959595959, 6.0606060606060606, 6.161616161616162, 6.262626262626262, 6.363636363636363, 6.4646464646464645, 6.565656565656566, 6.666666666666667, 6.767676767676767, 6.8686868686868685, 6.96969696969697, 7.070707070707071, 7.171717171717171, 7.2727272727272725, 7.373737373737374, 7.474747474747475, 7.575757575757575, 7.6767676767676765, 7.777777777777778, 7.878787878787879, 7.979797979797979, 8.080808080808081, 8.181818181818182, 8.282828282828282, 8.383838383838384, 8.484848484848484, 8.585858585858587, 8.686868686868687, 8.787878787878787, 8.88888888888889, 8.98989898989899, 9.09090909090909, 9.191919191919192, 9.292929292929292, 9.393939393939394, 9.494949494949495, 9.595959595959595, 9.696969696969697, 9.797979797979798, 9.8989898989899, 10.0};
const int x_coords[] = {1.691256409645667, 1.6689042812831139, 1.6468928698074283, 1.6252011149855088, 1.6038087399283034, 1.5826962189666074, 1.5618447414326626, 1.5412361723530192, 1.5208530108443534, 1.5006783468220428, 1.4806958164763417, 1.4608895568386, 1.4412441596460739, 1.4217446246148233, 1.4023763121427006, 1.3831248953854236, 1.3639763115754011, 1.344916712382569, 1.325932413046415, 1.307009839935786, 1.2881354761151518, 1.269295804409496, 1.2504772473611885, 1.2316661033567127, 1.2128484780635713, 1.2128484780635713, 1.2035235663180854, 1.1938238541319444, 1.18375273727962, 1.1733138774842735, 1.1625112182247677, 1.1513489984293561, 1.1398317639617925, 1.1279643768071914, 1.11575202186994, 1.1032002113042225, 1.0903147863091636, 1.077101916335031, 1.063568095664177, 1.0497201373500944, 1.0355651645198134, 1.0211105990684501, 1.0063641477995493, 0.9913337860904838, 0.9760277391879689, 0.9604544612642344, 0.9446226123889081, 0.9285410335947093, 0.9122187202360245, 0.8956647938578649, 0.8956647938578649, 0.9089386628175148, 0.9220766484543184, 0.9350850413935944, 0.9479697413828937, 0.9607362917585034, 0.9733899101495463, 0.9859355159108825, 0.9983777547020766, 1.0107210205683146, 1.022969475827947, 1.035127069028458, 1.0471975511965976, 1.0591844905779677, 1.0710912860355324, 1.0829211792546036, 1.0946772658831, 1.1063625057198547, 1.117979732049971, 1.1295316602143637, 1.141020895490369, 1.1524499403514286, 1.1638212011661395, 1.175136994390243, 1.1863995522992574, 1.1863995522992574, 1.2140141492778493, 1.241274200593054, 1.2681382328871684, 1.294566139393747, 1.3205195285653475, 1.3459620403972266, 1.3708596242408038, 1.3951807733217971, 1.4188967127246763, 1.4419815391895312, 1.464412312605917, 1.4861691005072084, 1.5072349781097758, 1.5275959874625566, 1.54724106005119, 1.5661619077309283, 1.5843528871532377, 1.6018108429234927, 1.6185349346112174, 1.6345264524645424, 1.6497886262936134, 1.6643264315192776, 1.6781463958665337, 1.691256409645667};
const int y_coords[] = {5.767934104629055, 5.765130326967042, 5.762924960356094, 5.7612941572511716, 5.760215567792451, 5.759668285777131, 5.75963279423997, 5.760090911671334, 5.761025739695493, 5.762421612864999, 5.764264051093916, 5.766539715148539, 5.769236365535125, 5.772342825066549, 5.775848945351226, 5.779745577425635, 5.784024546745261, 5.788678632756254, 5.793701553291629, 5.799087954071204, 5.804833403634602, 5.810934394102931, 5.8173883482494295, 5.824193633465503, 5.831349583340744, 5.831349583340744, 5.811774772556337, 5.792251041054745, 5.77278220867342, 5.7533725384885965, 5.7340267277581844, 5.714749897705965, 5.6955475820086665, 5.676425713867077, 5.657390611563375, 5.638448962429354, 5.619607805174039, 5.600874510544316, 5.58225676031839, 5.563762524658745, 5.545400037878767, 5.527177772704484, 5.509104413140018, 5.491188826071426, 5.473440031768499, 5.4558671734669995, 5.438479486234564, 5.421286265341371, 5.4042968343714435, 5.387520513321721, 5.387520513321721, 5.374246644362072, 5.361108658725268, 5.348100265785991, 5.335215565796693, 5.322449015421083, 5.309795397030039, 5.297249791268705, 5.28480755247751, 5.272464286611271, 5.26021583135164, 5.2480582381511285, 5.235987755982988, 5.2240008166016185, 5.212094021144054, 5.200264127924983, 5.188508041296486, 5.176822801459731, 5.165205575129615, 5.153653646965222, 5.142164411689217, 5.130735366828158, 5.119364106013447, 5.108048312789344, 5.096785754880329, 5.096785754880329, 5.124712431088579, 5.152908117077966, 5.181329538069301, 5.209933610133631, 5.238677825929277, 5.267520621611614, 5.296421717420243, 5.325342425605673, 5.354245920708638, 5.383097468666896, 5.41186461271307, 5.440517315465662, 5.469028057937694, 5.497371897342354, 5.5255264865279194, 5.553472058607116, 5.5811913808563105, 5.608669682257706, 5.635894559163306, 5.6628558634997175, 5.689545577738692, 5.715957680561365, 5.742088006775132, 5.767934104629055};

const int num_points = 100;

#endif // TIME_SERIES_DATA_H
