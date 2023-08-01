# Side channel attack proof Speck cipher
A VHDL implementation.
State of development is that
* a fully asynchronous architectire is working,
* which is easy to pipeline with DFFs if needed
* yet it consumes a full FPGA of some larger size
* and the SCA safe adders are utterly slow for larger bit widths

So to be developed are
* creating pipelienable parallel prefix adders, that are SCA safe too, for hopefully improving on speeds
* creating a feedback based description with an accompanying state machine to possibly fit in a small device
* and create a parameterizable version, that would consist of multiple pipeline layers of the already pipelined adders, for perfect scalability - this will also need some tricky state machine that runs according to the parameters of the two pipeline layers

