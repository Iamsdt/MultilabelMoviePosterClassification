# Multi label Movie Poster Classification

## AI model

Datasets: [Movie_Poster_Dataset](https://www.cs.ccu.edu.tw/~wtchu/projects/MoviePoster/Movie_Poster_Dataset.zip)

Framework: Tensorflow 2.1

### Classifier Architecture

**Input Shape**: (350, 350, 3)

**Label**: (24)

**Output Shape**: (24)

**Model Summary**

```
Model: "sequential"
_________________________________________________________________
Layer (type)                 Output Shape              Param #   
=================================================================
conv2d (Conv2D)              (None, 348, 348, 16)      448       
_________________________________________________________________
batch_normalization (BatchNo (None, 348, 348, 16)      64        
_________________________________________________________________
dropout (Dropout)            (None, 348, 348, 16)      0         
_________________________________________________________________
conv2d_1 (Conv2D)            (None, 346, 346, 32)      4640      
_________________________________________________________________
batch_normalization_1 (Batch (None, 346, 346, 32)      128       
_________________________________________________________________
max_pooling2d (MaxPooling2D) (None, 173, 173, 32)      0         
_________________________________________________________________
dropout_1 (Dropout)          (None, 173, 173, 32)      0         
_________________________________________________________________
conv2d_2 (Conv2D)            (None, 171, 171, 64)      18496     
_________________________________________________________________
batch_normalization_2 (Batch (None, 171, 171, 64)      256       
_________________________________________________________________
max_pooling2d_1 (MaxPooling2 (None, 85, 85, 64)        0         
_________________________________________________________________
dropout_2 (Dropout)          (None, 85, 85, 64)        0         
_________________________________________________________________
conv2d_3 (Conv2D)            (None, 83, 83, 128)       73856     
_________________________________________________________________
batch_normalization_3 (Batch (None, 83, 83, 128)       512       
_________________________________________________________________
max_pooling2d_2 (MaxPooling2 (None, 41, 41, 128)       0         
_________________________________________________________________
dropout_3 (Dropout)          (None, 41, 41, 128)       0         
_________________________________________________________________
flatten (Flatten)            (None, 215168)            0         
_________________________________________________________________
dense (Dense)                (None, 128)               27541632  
_________________________________________________________________
batch_normalization_4 (Batch (None, 128)               512       
_________________________________________________________________
dropout_4 (Dropout)          (None, 128)               0         
_________________________________________________________________
dense_1 (Dense)              (None, 128)               16512     
_________________________________________________________________
batch_normalization_5 (Batch (None, 128)               512       
_________________________________________________________________
dropout_5 (Dropout)          (None, 128)               0         
_________________________________________________________________
dense_2 (Dense)              (None, 24)                3096      
=================================================================
Total params: 27,660,664
Trainable params: 27,659,672
Non-trainable params: 992
```



### Hyperparameters

| Parameters    |                     |
| ------------- | ------------------- |
| Optimizer     | Adam                |
| Learning rate | 0.001               |
| Loss function | Binary Crossentropy |
| Batch size    | 32                  |
| Epoch         | 5                   |

### Training Logs

```
Train on 6854 samples, validate on 1210 samples
Epoch 1/5
6854/6854 [==============================] - 39s 6ms/sample - loss: 0.6711 - accuracy: 0.6647 - val_loss: 0.3302 - val_accuracy: 0.9021
Epoch 2/5
6854/6854 [==============================] - 34s 5ms/sample - loss: 0.3010 - accuracy: 0.8932 - val_loss: 0.2634 - val_accuracy: 0.9020
Epoch 3/5
6854/6854 [==============================] - 34s 5ms/sample - loss: 0.2676 - accuracy: 0.9039 - val_loss: 0.2620 - val_accuracy: 0.9027
Epoch 4/5
6854/6854 [==============================] - 34s 5ms/sample - loss: 0.2602 - accuracy: 0.9062 - val_loss: 0.2636 - val_accuracy: 0.9030
Epoch 5/5
6854/6854 [==============================] - 34s 5ms/sample - loss: 0.2555 - accuracy: 0.9072 - val_loss: 0.2640 - val_accuracy: 0.9030
```



### Web App:







Link: [Movie Poster Classifier](https://flutter-web-3a021.firebaseapp.com/#/)





### Web App Screenshort

![image-20200308200215040](/home/shudipto/.config/Typora/typora-user-images/image-20200308200215040.png)