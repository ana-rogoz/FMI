import random
import cv2
import numpy as np

from imgaug import augmenters as iaa
from tensorflow.keras import datasets

(x_train, y_train), (x_test, y_test) = datasets.mnist.load_data()

def sometimes(aug): return iaa.Sometimes(0.5, aug)

seq = iaa.Sequential([
    iaa.Affine(
        scale={"x": (0.8, 1), "y": (0.8, 1)},
        translate_percent={"x": (-0.1, 0.1), "y": (-0.1, 0.1)},
        rotate=(-15, 15),
        shear=(-5, 5),
        cval=(0, 0),
        mode='constant'
    )
])


def crop_number(number):
    """
        Crops a MNIST digit to its containing bounding box with some random noise.
    """
    vsum = np.sum(number, axis=0)
    vsum[vsum > 0] = 1
    vdif = np.diff(vsum)
    vdif[vdif > 0] = 1
    xs = np.argwhere(vdif > 0).ravel()

    random_cut1 = np.random.randint(-1, 3)
    random_cut2 = np.random.randint(-1, 3)

    try:
        cropped_number = number[0:28, xs[0] - random_cut1:xs[1] + random_cut2]
        if cropped_number.shape[1] < 6:
            raise Exception
    except:
        cropped_number = number

    return cropped_number


def pad_image(number, target_shape=(28, 84)):
    """
        Makes all images the same shape
    """
    _shape = number.shape

    height_pad = (-_shape[0] + target_shape[0]) // 2
    width_pad = (-_shape[1] + target_shape[1]) // 2

    padded = cv2.copyMakeBorder(number,
                                height_pad,
                                height_pad,
                                width_pad + int(_shape[1] % 2 == 1),
                                width_pad,
                                cv2.BORDER_CONSTANT,
                                value=0)
    return padded


def generate_images(data_x, data_y, batch_size, length=255):
    """
        Generates images containing numbers from MNIST with random translations.
    """

    while True:

        x_batch = []
        y_numbers_batch = []
        y_results = []

        for _ in range(batch_size):
            x = [np.zeros((28, 0)), np.zeros((28, 0))]
            y_numbers = []

            for num in range(2):
                random_num = random.randrange(length)
                decimal = str(random_num)

                y_numbers.append(np.array([random_num]))

                for digit in decimal:
                    numbers = np.argwhere(data_y == int(digit))

                    loc = np.random.choice(numbers.ravel(), 1)
                    number = np.squeeze(data_x[loc])
                    augmented_number = seq.augment_images([number])[0]
                    cropped_number = crop_number(augmented_number)

                    x[num] = np.hstack((x[num], cropped_number))
                x[num] = pad_image(x[num])

            x_batch.append(x)
            y_numbers_batch.append(y_numbers)
            y_results.append(y_numbers[-1] + y_numbers[-2])

        yield np.array(x_batch), np.squeeze(np.array(y_numbers_batch)), np.array(y_results)


def training_generator(batch_size=32):
    """
        Use this function to generate training samples. Images are generated using the training set of MNIST.
        Example usage:

        generator = training_generator(batch_size=8) # batch size of 8

        x, numbers, numbers_sum = next(generator)

        # x.shape == (8, 2, 28, 84)     # 8 pairs of images with height 28px and width 84px
        # numbers.shape == (8, 2)       # 8 pairs of numbers corresponding to the images
        # numbers_sum.shape == (8, 1)   # 8 numbers that represent the sum of the numbers from the images

    """
    return generate_images(x_train, y_train, batch_size)


def test_generator(batch_size=32):
    """
        Use this function to generate test samples. Images are generated using the test set of MNIST.
        Example usage:

        generator = test_generator(batch_size=8) # batch size of 8

        x, numbers, numbers_sum = next(generator)

        # x.shape == (8, 2, 28, 84)     # 8 pairs of images with height 28px and width 84px
        # numbers.shape == (8, 2)       # 8 pairs of numbers corresponding to the images
        # numbers_sum.shape == (8, 1)   # 8 numbers that represent the sum of the numbers from the images

    """
    return generate_images(x_test, y_test, batch_size)
