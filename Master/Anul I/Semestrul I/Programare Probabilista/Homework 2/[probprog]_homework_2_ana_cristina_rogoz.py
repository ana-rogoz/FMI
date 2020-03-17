# -*- coding: utf-8 -*-
"""[ProbProg] Homework 2 - Ana Cristina Rogoz

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1iiuHtYCK-IKeSgptKPRR0iJyu3DLd7Kv
"""

# !pip install pymc

# !pip install tensorflow==1.4

# !pip install arviz

"""# Load all the imports!"""

import numpy as np
import matplotlib.pyplot as plt
import pymc3 as pm 
import tensorflow as tf
import theano.tensor as T
import os

from sklearn.metrics import accuracy_score
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error
from sklearn.metrics import confusion_matrix
from sklearn.preprocessing import StandardScaler, MinMaxScaler
from sklearn.model_selection import KFold 
 
import pandas as pd
import csv

"""# Description of the dataset

The dataset used for this project is taken from Kaggle and is called “Mice Protein
Expression”. This dataset contains 82 columns in total and 1080 samples. From those 82
columns, 77 represent protein levels measured in the cerebral cortex from 8 classes of mice.
There are considered other 4 features, which are: Genotype, Treatment, Behaviour, Class
and Mice Id. There are a total of 72 mice (38 control mice and 34 trisomic mice i.e. with
Down Syndrome). For each mouse, there have been made 15 measurements (thus 1080
samples - 570 for the control mice and 510 for the trisomic mice). For this problem, the
target/label we are trying to predict is the class for each mice. There are 8 possible classes
available, based on three characteristics: control mice or trisomic mice, stimulated or not
to learn, injected with memantine or saline (where memantine is a drug meant for helping
trisomic mice to recover their ability to learn and saline is used as a placebo). These classes
are encoded in the following manner in the dataset: x − Y Z − w where:

* x can be either c or t (control or trisomic)
* XY can be either CS or SC (context-shock or not i.e. stimulated to learn or not) 
* w can be either m or s (memantine or saline) 

Other observations about this dataset:
* Categorical features: Mouse ID, Genotype, Treatment, Behaviour, Class
* Numerical features: all of the other 77 protein columns (most of them containing NaN
values)
"""

dataset = pd.read_csv('Data_Cortex_Nuclear.csv', delimiter=",")

"""For this step, I’ve done a couple of things. Firstly, I’ve replaced all the NaN values for
each protein with the corresponding mean value based on all the values for the same class as the sample. Secondly, I’ve dropped three columns (Genotype, Treatment and Behaviour)
that were actually composing the class value, since if those three were left inside that dataset,
the target label (class) could be directly learned by using only those three features and
ignoring all the other protein values, achieving 100% accuracy. Also, I’ve dropped the mice
id column, since it shouldn’t be correlated in any manner with the class.
"""

dataset['Genotype'] = pd.factorize(dataset['Genotype'])[0]
dataset['Treatment'] = pd.factorize(dataset['Treatment'])[0]
dataset['Behavior'] = pd.factorize(dataset['Behavior'])[0]
dataset['class'] = pd.factorize(dataset['class'])[0]

dataset = dataset.drop(['MouseID'], axis=1)
dataset = dataset.drop(['Genotype'], axis=1)
dataset = dataset.drop(['Treatment'], axis=1)
dataset = dataset.drop(['Behavior'], axis=1)
print (dataset)

import math 

dictionary = set()
for index, row in dataset.iterrows():
  for column in dataset.columns:
      if (math.isnan(row[column])):
        dictionary.add(column)

for protein in dictionary:
  dataset[protein] = dataset.groupby(['class'])[protein].transform(lambda x: x.fillna(x.mean()))

"""# Binary Classification

For the binary classification task, I kept only the first two classes (from a total of eight possible ones) and scaled all the protein data features using the StandardScaler. Afterward, I've firstly written the classical version of the neural network (using sklearn), since it was training so much faster than the bayesian version and it was easier for me to find the best network architecture. 
In the end, I went for only one hidden layer with 8 units. Each input sample consists of 77 features, so for the first part (weights from input to layer 1), I've defined a variable with normal distribution (0, 1) of shape [77, 8], followed by another variable with normal distribution of shape [8, 1] for converting the outputs of the 8 units from hidden layer 1 to the output unit. I've used the hyperbolic tangent activation function for the hidden layer and sigmoid for the output unit. The actual label is modeled using a Bernoulli distribution in which the success probability is the output of the Bayesian NN (after sigmoid activation) and the data are the actual labels from the dataset.
"""

class_0 = dataset['class'] == 0
class_1 = dataset['class'] == 1
binary_dataset = dataset[class_0 | class_1]

binary_dataset_standardScaled = binary_dataset.copy()

binary_dataset_standardScaled = binary_dataset_standardScaled.drop(['class'], axis=1)
scaler = StandardScaler().fit(binary_dataset_standardScaled.values)
binary_dataset_standardScaled = scaler.transform(binary_dataset_standardScaled.values)

y_binary_dataset = binary_dataset['class']

X_train, X_test, y_train, y_test = train_test_split(binary_dataset_standardScaled,y_binary_dataset)

"""## Bayesian Neural Network - Pymc"""

def build_neural_network(input_data, output_data):
  init_1 = np.random.randn(X_train.shape[1], 8).astype('float')
  init_out = np.random.randn(8).astype('float')

  with pm.Model() as neural_network:
    input_data = pm.Data('input_data', X_train)
    output_data = pm.Data('output_data', y_train)
    weights_in_1 = pm.Normal('w_in_1', 0, sigma=1,
                              shape=(X_train.shape[1], 8),
                              testval=init_1)
    weights_1_out = pm.Normal('w_1_out', 0, sigma=1,
                              shape=(8,),
                              testval=init_out)
    act_1 = pm.math.tanh(pm.math.dot(input_data,
                                      weights_in_1))
    act_out = pm.math.sigmoid(pm.math.dot(act_1,
                                          weights_1_out))
    out = pm.Bernoulli('out',
                        act_out,
                        observed=output_data,
                        total_size=y_train.shape[0]
                      )
  return neural_network

neural_network = build_neural_network(X_train, y_train)

with neural_network:
    mcmc = pm.sample(draws=5000, tune=1000)

"""After fitting the Bayesian Neural Network on 5000 samples, I've drawn 100 more based on which there were done predictions for the training examples. On the training set, the model scored 0.96 accuracy, while on the test set the same model previously trained scored 0.97.
(see figure 1 attached in the email). 

* The results are taken from running this code locally.

Predict labels for the training set.
"""

predictions = pm.sample_ppc(mcmc, model=neural_network, samples=100) 
y_pred = predictions['out']

print ("[MCMC] Train set accuracy binary classification:", accuracy_score(y_train, y_pred[99]))

"""Predict labels for the testing set."""

pm.set_data(new_data={'input_data': X_test, 'output_data': y_test}, model=neural_network)
predictions = pm.sample_ppc(mcmc, samples=100, model=neural_network)
y_pred = predictions['out']

print ("[MCMC] Test set accuracy binary classification:", accuracy_score(y_test, y_pred[99]))

"""### Sanity Check

The following plots represent the posterior values for the weights between the input layer and the hidden layer, and the hidden layer and the output unit. It can be noticed that those values finely represent the normal distribution that was implied at the beginning.

Each color represents one of the units from the hidden layer, thus 8 colors.
"""

plt.figure() 
plt.hist(mcmc['w_in_1'][999][:][:])
plt.title("Posteriori of w_in_1")
plt.savefig('Binary_w_in_1.png')

plt.figure()
plt.hist(mcmc['w_1_out'][:][:])
plt.title("Posteriori of w_1_out")
plt.savefig('Binary_w_1_out.png')

pm.summary(mcmc)

"""## Multilayer Perceptron - Sklearn

For the classical neural network, I've implemented the same architecture (one hidden layer with 8 units, hyperbolic tangent activation function for the hidden layer outputs, and sigmoid for the output unit). 
I've kept the same dataset for both training and testing and got similar results to the Bayesian neural network (slightly better with sklearn):
*  0.98 accuracy on the train set 
* 0.97 accuracy on the test set
"""

X_train = np.array(X_train)
y_train = np.array(y_train)

X_test = np.array(X_test)
y_test = np.array(y_test)

model = tf.keras.models.Sequential()
model.add(tf.keras.layers.Dense(8, input_dim = X_train.shape[1], activation='tanh'))
model.add(tf.keras.layers.Dense(1, activation='sigmoid'))

model.compile(optimizer='sgd',
              loss='binary_crossentropy',
              metrics=['accuracy'])

# model.summary()

model.fit(X_train, y_train, epochs=20)
print ("[SKLEARN] Test set accuracy binary classification: ", model.evaluate(X_test, y_test))

"""# Multiclass Classification

For the multiclass task, I kept all the examples from the dataset and scaled them in the same manner as I did for the binary classification task. In this case, as well I've firstly written the classical version of the neural network (using sklearn), since it was training so much faster than the bayesian version and found an appropriate network architecture. 
Here as well we have one hidden layer with 8 units. Each input sample consists of 77 features, so for the first part (weights from input to layer 1) I've defined a variable with normal distribution (0, 1) of shape [77, 8], followed by another variable with normal distribution of shape [8, 8] for converting the outputs of the 8 units from hidden layer 1 to the 8 output units on which there is applied the softmax activation function. I've used the hyperbolic tangent activation function for the hidden layer and softmax for the output units since those values are treated as probability values in the Categorical container which returns an actual number (between 0 and 7).
"""

datasetStandardScaled = dataset.copy()

datasetStandardScaled = datasetStandardScaled.drop(['class'], axis=1)
scaler = StandardScaler().fit(datasetStandardScaled.values)
features = scaler.transform(datasetStandardScaled.values)

X_dataset = features
y_dataset = dataset['class']

X_train, X_test, y_train, y_test = train_test_split(X_dataset,y_dataset)

"""## Bayesian Neural Network - Pymc"""

def build_neural_network(input_data, output_data):
  init_1 = np.random.randn(X_train.shape[1], 8).astype('float')
  init_out = np.random.randn(8, 8).astype('float')

  with pm.Model() as neural_network:
    input_data = pm.Data('input_data', X_train)
    output_data = pm.Data('output_data', y_train)

    weights_in_1 = pm.Normal('w_in_1', 0, sigma=1,
                              shape=(X_train.shape[1], 8),
                              testval=init_1)
    weights_1_out = pm.Normal('w_1_out', 0, sigma=1,
                              shape=(8, 8),
                              testval=init_out)
    act_1 = pm.math.tanh(pm.math.dot(input_data,
                                      weights_in_1))
    act_out = T.nnet.softmax(T.dot(act_1, weights_1_out))
    out = pm.Categorical('out',
                        p=act_out,
                        observed=output_data,
                        total_size=y_train.shape[0]
                      )
  return neural_network

neural_network = build_neural_network(X_train, y_train)

with neural_network:
    mcmc = pm.sample(draws=5000, tune=1000)

"""Similar to the binary classification task, after fitting the Bayesian Neural Network on 5000 samples, I've drawn 100 more based on which there were done predictions for the training examples. On the training set, the model scored 0.92 accuracy, while on the test set the same model previously trained scored 0.88.
(see figure 2 attached in the email). 

* The results are taken from running this code locally (since on Colab it took much longer).

Predict labels for the training set.
"""

predictions = pm.sample_ppc(mcmc, model=neural_network, samples=100) 
y_pred = predictions['out']

print ("[MCMC] Train set accuracy multiclass classification:", accuracy_score(y_train, y_pred[99]))

"""Predict labels for the testing set."""

pm.set_data(new_data={'input_data': X_test, 'output_data': y_test}, model=neural_network)
predictions = pm.sample_ppc(mcmc, samples=100, model=neural_network)
y_pred = predictions['out']

print ("[MCMC] Test set accuracy multiclass classification:", accuracy_score(y_test, y_pred[99]))

"""### Sanity Check

Similar to the binary case.
"""

plt.figure() 
plt.hist(mcmc['w_in_1'][999][:][:])
plt.title("Posteriori of w_in_1")
plt.savefig('Multiclass_w_in_1.png')

plt.figure()
plt.hist(mcmc['w_1_out'][999][:][:])
plt.title("Posteriori of w_1_out")
plt.savefig('Multiclass_w_1_out.png')

pm.summary(mcmc)

"""## Multilayer Perceptron - Sklearn

Followed the same architecture (one hidden layer with 8 units and hyperbolic tangent activation function, followed by 8 output units on which there's applied softmax). 

Results show that this network scored 0.93 accuracy on both the training and the test set (see figure 3).
"""

X_train = np.array(X_train)
y_train = np.array(y_train)

X_test = np.array(X_test)
y_test = np.array(y_test)

model = tf.keras.models.Sequential()
model.add(tf.keras.layers.Dense(8, input_dim = X_train.shape[1], activation='tanh'))
model.add(tf.keras.layers.Dense(8, activation='softmax'))

model.compile(optimizer='sgd',
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])

# model.summary()

model.fit(X_train, y_train, epochs=100)
print ("Multiclass accuracy sklearn: ", model.evaluate(X_test, y_test))