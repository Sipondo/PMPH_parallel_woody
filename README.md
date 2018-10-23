# PMPH_parallel_woody

# Building the report
I build the report using latexmk, that will put all auxillary files in aux/.
Using mklatex could work as well.


# TODO
* Python  
https://futhark.readthedocs.io/en/latest/man/futhark-pyopencl.html  
https://futhark-lang.org/blog/2018-07-05-python-gotta-go-faster.html  
https://futhark-lang.org/blog/2016-04-15-futhark-and-pyopencl.html  
- [x] Find out how to call futhark from python (use pyopencl)
- [x] Call futhark from woody  
- [x] Export a fitted tree to a format we can use as input in futhark
- [ ] Visualise Futhark input data
* GPU-Nodes  
- [x] Get woody running on the nodes
- [x] Compile treesolver/math example into "something python"  
* Futhark  
- [ ] Flattening -> Figure out what to flatten


# How to install Woody

First clone and open the Woody submodule:

    git submodule init
    git submodule update
    cd woody
    git checkout master
    git pull

Create a virtual environment and install Woody's requirements:

    mkdir .venv
    cd .venv
    virtualenv woody
    source woody/bin/activate
    cd ..
    pip install -r requirements.txt

Download Swig from http://www.swig.org/download.html (using wget), install it in your home directory by running in the directory of the extracted tar file:

    wget http://prdownloads.sourceforge.net/swig/swig-3.0.12.tar.gz
    tar -xzf swig-3.0.12.tar.gz
    cd swig-3.0.12
    ./configure --prefix={install location} --without-pcre
    make
    make install
    export PATH=$PATH:{install location}/bin

Install `h2o`:

    pip install h2o

Install `pyopencl`:

    pip install -U pybind11
    pip install -U pyopencl

Return to the Woody directory and run:

    python setup.py clean
    python setup.py develop
    
To check Woody is successfully installed run:

    cd experiments/small_data
    python launch.py

-----------------

To build a futhark-opencl library:

    cd futhark_opencl_example
    futhark-pyopencl --library futmath.fut
    python math_example.py


-----------------

## How is predict being called
models/forest/base.py, line 277: Call predict_all_extern  
predict_all_extern is in models/fores/src/tree/base.c  
Then cpu_query_forest_all_preds is called.  
cpu_query_forest_all_preds is in models/forest/src/tree/cpu/base.c  

## Types in woody
models/forest/src/tree/include/types.h  
We have to make a python function that takes as input a tree and then splits it into 5 arrays. 
We want to represent a tree as 5 arrays, containing the data needed to reconstruct each node. 


A tree node is:
* left_id, unsigned int  
* right_id, unsigned int  
* feature,  unsigned int  
* thres_or_leaf, FLOAT_TYPE  
* leaf_criterion, unsigned int  



- A tree is a TREE_NODE *root, int n_allocated and int node_counter.  
- A forest is an array of trees, and second value is number of trees (n_trees)  

