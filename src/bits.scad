//
// Bit operation utils (not specific to QR)
//
pow2=[1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768];
char_nums = [["?",0],["?",1],["?",2],["?",3],["?",4],["?",5],["?",6],["?",7],["?",8],["?",9],["?",10],["?",11],["?",12],["?",13],["?",14],["?",15],["?",16],["?",17],["?",18],["?",19],["?",20],["?",21],["?",22],["?",23],["?",24],["?",25],["?",26],["?",27],["?",28],["?",29],["?",30],["?",31],[" ",32],["!",33],["\"",34],["#",35],["$",36],["%",37],["&",38],["'",39],["(",40],[")",41],["*",42],["+",43],[",",44],["-",45],[".",46],["/",47],["0",48],["1",49],["2",50],["3",51],["4",52],["5",53],["6",54],["7",55],["8",56],["9",57],[":",58],[";",59],["<",60],["=",61],[">",62],["?",63],["@",64],["A",65],["B",66],["C",67],["D",68],["E",69],["F",70],["G",71],["H",72],["I",73],["J",74],["K",75],["L",76],["M",77],["N",78],["O",79],["P",80],["Q",81],["R",82],["S",83],["T",84],["U",85],["V",86],["W",87],["X",88],["Y",89],["Z",90],["[",91],["\\ ",92],["]",93],["^",94],["_",95],["`",96],["a",97],["b",98],["c",99],["d",100],["e",101],["f",102],["g",103],["h",104],["i",105],["j",106],["k",107],["l",108],["m",109],["n",110],["o",111],["p",112],["q",113],["r",114],["s",115],["t",116],["u",117],["v",118],["w",119],["x",120],["y",121],["z",122],["{",123],["|",124],["}",125],["~",126]];

function xor(a, b) = (a || b) && !(a && b);

function xor_byte(a, b) =
    let(ba=bytes2bits([a]), bb=bytes2bits([b]))
    bits2byte([ for (i=[0:8-1]) xor(ba[i], bb[i]) ? 1 : 0 ]);

function is_bit_set(val, idx) =
    floor(val / pow2[7-idx%8]) % 2 == 1;

function bits2byte(bits) =
    bits[0]*pow2[7] +
    bits[1]*pow2[6] +
    bits[2]*pow2[5] +
    bits[3]*pow2[4] +
    bits[4]*pow2[3] +
    bits[5]*pow2[2] +
    bits[6]*pow2[1] +
    bits[7]*pow2[0];

// not using ord because it doesn't work on Thingiverse's customizer
function str2bytes(s) =
    [ for(i=search(s, char_nums, num_returns_per_match=0))
        i[0] ];

function bytes2bits(bytes) = [ for(i=[0:len(bytes)*8-1]) is_bit_set(bytes[floor(i/8)], i) ? 1 : 0 ];

// Pads not fully filled bytes with 0s
function bits2bytes(bits) = [ for(i=[0:ceil(len(bits)/8)-1]) bits2byte([
    for(j=[0:8-1])
        let(bitidx=8*i + j)
        bitidx < len(bits) ? bits[bitidx] : 0
    ]) ];
