first_dir = '../data/audio_ori_wav/';
save_dir = '../data/audio_trans_wav/';
mkdir(save_dir)
% Matlab使用dir函数获得指定文件夹下的所有子文件夹和文件,并存放在在一种为文件结构体数组中.
% dir('.')列出当前目录下所有子文件夹和文件
% dir('G:\Matlab')列出指定目录下所有子文件夹和文件
% dir('*.m')列出当前目录下符合正则表达式的文件夹和文件
subdirs =  dir(first_dir);
for i = 3 : length(subdirs)
    strcat(first_dir,subdirs(i).name)
    audioinfo(strcat(first_dir,subdirs(i).name))
    % y是读出数据。Fs为音频文件的采样率 
    [y, FS]=audioread(strcat(first_dir,subdirs(i).name));
    audiowrite(strcat(save_dir,subdirs(i).name),y,FS);
end
