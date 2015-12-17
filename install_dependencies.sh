#!/bin/bash

set -e

if [ `uname` == "Darwin" ]; then
  os=osx
else
  if yum --version > /dev/null 2>&1; then
    os=redhat
  else
    os=ubuntu
  fi
fi

pip install numpy
pip install matplotlib
pip install scipy
pip install sklearn
pip install simplejson
pip install eyed3
pip install scikits.talkbox

if [ $os == "osx" ]; then
  brew install gsl
elif [ $os == "redhat" ]; then
  sudo apt-get install libgsl0-dev
elif [ $os == "ubuntu" ]; then
  sudo yum install gsl-devel
fi

if ! python -c "import mlpy;" > /dev/null 2>&1; then
  wget http://sourceforge.net/projects/mlpy/files/mlpy%203.5.0/mlpy-3.5.0.tar.gz
  tar xvf mlpy-3.5.0.tar.gz
  (cd mlpy-3.5.0; python setup.py install)
  rm -rf mlpy-3.5.0 mlpy-3.5.0.tar.gz
fi

git clone https://github.com/hmmlearn/hmmlearn.git
(cd hmmlearn; python setup.py install)
rm -rf hmmlearn

