import os
import numpy as np
import random as rd
import scipy.cluster as sc

# Import data from root directory as lists of vectors.
def get_data(root):
    # Return result as lists.
    # X_data contains data, Y_data contains class label
    X_data = []
    Y_data = []
    
    # Each folder represents a class.
    folders = os.listdir(root)
    folders.sort()
    # Class number.
    class_num = 0
    for folder in folders:
        # Each file represents a signal.
        files = os.listdir(root + folder + '/')
        for file in files:
            file = root + folder + '/' + file
            d = []
            with open(file, 'rb') as f:
                for line in f:
                    line = line.decode('utf-8')
                    line = line.rstrip('\r\n')
                    lc = line.split(' ')
                    d.append(lc)
            X_data.append(np.array(d).flatten().astype(np.float))
            Y_data.append(class_num)
        class_num = class_num + 1
        
    return X_data, Y_data, folders

# Vector quantize a list of signals based on a VQ dictionary.
def vec_quantize_signals(signals, vq_dict):
    # Retrieve K and window size from vq_dict.
    K = vq_dict.shape[0]
    window = vq_dict.shape[1]
    
    VQ_signals = []
    
    for signal in signals:
        # Chop the signal into window size chunks and pad the remainder periodically.
        chopped_signal = np.resize(signal, (int(np.ceil(len(signal)/window)), window))

        # Map each chopped signal element to VQ dict.
        mapping, dist = sc.vq.vq(chopped_signal, vq_dict)
    
        # Generate histogram of the mapping.
        histogram, bins = np.histogram(mapping, range(K+1))
    
        # Normalize histogram and append to result.
        histogram = histogram/np.sum(histogram)
        VQ_signals.append(histogram)
        
    return VQ_signals

# Generate a VQ dictionary with window size and K-means.
# Add hierarchical k-means and overlap?
def get_vq_dict(signals, window = 27, K = 25):
    # Chop entire dataset into pieces of window size.
    pieces = np.empty((0,window))
    for signal in signals:
        # Chop the signal into window size chunks and pad the remainder periodically.
        chopped_signal = np.resize(signal, (int(np.ceil(len(signal)/window)), window))
        
        # Add to collection of class pieces.
        pieces = np.vstack((pieces,chopped_signal))
    
    # Do k-means on the pieces and return.
    vq_dict, dist = sc.vq.kmeans(pieces, K)
    return vq_dict

# Generate a VQ dictionary with overlapping window
def get_vq_dict_overlap(signals, window = 27, K = 25, overlap = 0.3):
    # Chop entire dataset into pieces of window size.
    window_ol = int(window*overlap)
    pieces = np.empty((0,window + window_ol))
    for signal in signals:
        # Chop the signal into window size chunks and pad the remainder periodically.
        chopped_signal = np.resize(signal, (int(np.ceil(len(signal)/window)), window))
        overlap_part = chopped_signal[1:chopped_signal.shape[0], 0:window_ol]
        overlap_part = np.vstack((overlap_part, np.zeros(window_ol)))
        chopped_signal = np.hstack((chopped_signal, overlap_part))
        # Add to collection of class pieces.
        pieces = np.vstack((pieces,chopped_signal))
    # Do k-means on the pieces and return.
    vq_dict, dist = sc.vq.kmeans(pieces, K)
    return vq_dict

# Generate a VQ dictionary with hierarchical k-means
def get_vq_dict_hierarchical(signals, window = 27, K_0 = 40, K_1 = 12, sample = 100):
    indices = rd.sample(range(len(signals)), 100)
    # Randomly sample signals for first level k-means.
    sampled_signals = []
    for index in indices:
        sampled_signals.append(signals[index])
    # Generate first level cluster centers
    pieces = np.empty((0,window))
    for signal in sampled_signals:
        chopped_signal = np.resize(signal, (int(np.ceil(len(signal)/window)), window))
        pieces = np.vstack((pieces,chopped_signal))
    vq_dict_0, dist = sc.vq.kmeans(pieces, K_0)
    # The clustered signals from the first k-means from samples. 
    clustered_signals = []
    for center in range(K_0):
        clustered_signals.append([])
    # Map each signal to the first level cluster centers
    for signal in signals:
        chopped_signal = np.resize(signal, (int(np.ceil(len(signal)/window)), window))
        mapping, dist = sc.vq.vq(chopped_signal, vq_dict_0)
        for i in range(len(mapping)):
            center = mapping[i]
            clustered_signals[center].append(chopped_signal[i])
    # Generate second level cluster centers
    vq_dict = np.empty((0, window))
    for center in range(K_0):
        pieces = np.empty((0, window))
        for signal in clustered_signals[center]:
            pieces = np.vstack((pieces,signal))
        vq_dict_1, dist = sc.vq.kmeans(pieces, K_1)
        vq_dict = np.vstack((vq_dict, vq_dict_1))
    return vq_dict