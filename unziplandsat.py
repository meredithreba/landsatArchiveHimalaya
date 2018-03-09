# -*- coding: utf-8 -*-
"""
Created on Sat Oct 07 16:50:09 2017

@author: Bhartendu Pandey; bhartendu.pandey@yale.edu
"""

import os, tarfile,sys

def unziplandsat(inpfile,outdir):
    tar = tarfile.open(inpfile)
    tar.extractall(path=outdir)
    tar.close()