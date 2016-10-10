[singularity]: http://singularity.lbl.gov/
[chm]: https://www.sci.utah.edu/software/chm.html

# chm_singularity

Generates [Singularity][singularity] image for [Cascaded Hierarchical Model (CHM) version 2.1.367][chm].


# Run requirements

* [Singularity 2.0,2.1][singularity]
* Linux

# Build requirements 

* [Singularity 2.0,2.1][singularity]
* Make
* Linux
* Bash
* sudo superuser access

# To build

Run the following command to create the singularity image which will
be put under the **build/** directory

```Bash
make singularity
```

# To test

The image is built with a self test mode. To run the self test issue the following command after building:

```Bash
cd build/
./chm-0.1.0.im verify `pwd`
```

### Expected output from above command

```Bash
Extracting features ... stage 1 level 0
Start learning LDNN ... stage 1 level 0
Run clustering...Done. It took 0.280864
Number of training samples = 19000
Epoch No. 1 ... error = 0.133863
Epoch No. 2 ... error = 0.109276
Epoch No. 3 ... error = 0.100021
Epoch No. 4 ... error = 0.094533
Epoch No. 5 ... error = 0.090461
Epoch No. 6 ... error = 0.086922
Epoch No. 7 ... error = 0.083974
Epoch No. 8 ... error = 0.081532
Epoch No. 9 ... error = 0.079116
Epoch No. 10 ... error = 0.076921
Epoch No. 11 ... error = 0.075118
Epoch No. 12 ... error = 0.073202
Epoch No. 13 ... error = 0.071481
Epoch No. 14 ... error = 0.070160
Epoch No. 15 ... error = 0.068497
Generating outputs ... stage 1 level 0
Extracting features ... stage 1 level 1
Start learning LDNN ... stage 1 level 1
Run clustering...Done. It took 0.029079
Number of training samples = 4800
Epoch No. 1 ... error = 0.147385
Epoch No. 2 ... error = 0.132599
Epoch No. 3 ... error = 0.129089
Epoch No. 4 ... error = 0.128801
Epoch No. 5 ... error = 0.123766
Epoch No. 6 ... error = 0.124758
Epoch No. 7 ... error = 0.123334
Epoch No. 8 ... error = 0.118936
Epoch No. 9 ... error = 0.122070
Epoch No. 10 ... error = 0.120665
Epoch No. 11 ... error = 0.116100
Epoch No. 12 ... error = 0.119207
Epoch No. 13 ... error = 0.114560
Epoch No. 14 ... error = 0.116833
Epoch No. 15 ... error = 0.117144
Generating outputs ... stage 1 level 1
Extracting features ... stage 2 level 0
Start learning LDNN ... stage 2 level 0
Run clustering...Done. It took 0.411123
Number of training samples = 19000
Epoch No. 1 ... error = 0.109903
Epoch No. 2 ... error = 0.107199
Epoch No. 3 ... error = 0.106083
Epoch No. 4 ... error = 0.105375
Epoch No. 5 ... error = 0.104883
Epoch No. 6 ... error = 0.104358
Generating outputs ... stage 2 level 0
Verifying probability map exists with size greater then 0
```

# To use

### To train [CHM][chm]

The example below uses test data to run chm train putting the results in the **model** directory of the current working directory.

```Bash
cd build/
chm-0.1.0.img train ../testdata/images ../testdata/labels -S 2 -L 1 -m ./model
```

### To run [CHM][chm] aka test

The example below uses the trained model from the previous step to run [CHM][chm] on an image in **testdata** directory. The resulting probability map is stored in **results** directory under current working directory.

```Bash
cd build/
chm-0.1.0.img train ../testdata ./result -b 100x95 -t 1,1 -o 0x0 -h -m ./model
```

