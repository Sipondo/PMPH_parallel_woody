# PMPH_parallel_woody

# Building the report
I build the report using latexmk, that will put all auxillary files in aux/.
Using mklatex could work as well.


# TODO
* Python  
https://futhark.readthedocs.io/en/latest/man/futhark-pyopencl.html  
https://futhark-lang.org/blog/2018-07-05-python-gotta-go-faster.html  
https://futhark-lang.org/blog/2016-04-15-futhark-and-pyopencl.html  
- [ ] Find out how to call futhark from python
- [ ] Call futhark from woody  
* Nodes  
- [ ] Get woody running on the nodes
- [ ] Compile treesolver into "something python"  
* Futhark  
- [ ] Flattening -> Figure out what to flatten


# How to install Woody

First clone and open the Woody submodule::

    git submodule init
    git submodule update
    cd woody

Create a virtual environment and install Woody's requirements::

    mkdir .venv
    cd .venv
    virtualenv woody
    source woody/bin/activate
    cd ..
    pip install -r requirements

Download Swig from http://www.swig.org/download.html, install it in your home directory by running in the directory of the extracted tar file::

    ./configure --prefix={install location} --without-pcre
    make
    make install
    export PATH=$PATH:{install location}/bin

Return to the Woody directory and run::

    python setup.py clean
    python setup.py develop

Install `h2o`:

   pip install h2o

To check Woody is successfully installed run::

    cd experiments/small_data
    python launch.py

-----------------

Install `pyopencl`::

    pip install -U pybind11
    pip install -U pyopencl

To build a futhark-opencl library:

    cd futhark_opencl_example
    futhark-pyopencl --library futmath.fut
    python math_example.py
