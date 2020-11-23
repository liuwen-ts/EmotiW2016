# -*- coding: utf-8 -*-
"""
Created on Thu Aug 18 22:11:59 2016

@author: fanyin
"""

# -*- coding: utf-8 -*-
"""
Created on Tue Aug 16 19:41:37 2016

@author: fanyin
"""

# -*- coding: utf-8 -*-
"""
Created on Mon Jul 11 20:04:39 2016

@author: fanyin
"""

# -*- coding: utf-8 -*-
"""
Created on Thu May 19 15:49:18 2016

@author: fanyin
"""

import os
import numpy as np
from sklearn import svm
import re
from pylab import * 
from sklearn.externals import joblib
# 使用emobase配置文件可以提取1582个特征
feat_length = 1582
    
    

def get_feat(filename):
    # readlines() 方法用于读取所有行(直到结束符 EOF)并返回列表，该列表可以由 Python 的 for... in ... 结构进行处理。如果碰到结束符 EOF 则返回空字符串。
    lines = open(filename).readlines()
    #print len(lines)
    # 最后一行是特征值
    feat_str = lines[len(lines)-1]
    datas = re.split(',',feat_str[:-1])
    feat = np.zeros((1, feat_length))
    #print datas[1]
    for i in range(1,feat_length+1):
        feat[0, i-1] = datas[i]
    return feat
    
def get_all_feats(file_dir):    
    file_count = 0
    for fname in sorted(os.listdir(file_dir)):
        file_count += 1            
    
    feats = np.zeros((file_count, feat_length))
    count = -1
    # sorted() 函数对所有可迭代的对象进行排序操作。
    # os.listdir()返回path指定的文件夹包含的文件或文件夹的名字的列表。 
    for fname in sorted(os.listdir(file_dir)):
        count += 1
        feat = get_feat(os.path.join(file_dir, fname))
        feats[count] = feat
    return feats

test_total_dir = '../data/audio_feat'    
test_total_feats = get_all_feats(test_total_dir)
classifier = joblib.load('../models/audio_model/audio_svm.m')
audio_res = classifier.predict_proba(test_total_feats)
np.save("../audio_res.npy", audio_res)

  
