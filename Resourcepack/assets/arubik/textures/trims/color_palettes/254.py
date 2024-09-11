import os

from PIL import Image

self = os.path.abspath(__file__)

#get all images and changue alpha to 254
for root, dirs, files in os.walk(os.path.dirname(self)):
    for file in files:
        if file.endswith('.png'):
            img = Image.open(os.path.join(root, file))
            path = os.path.join(root, file)
            img.putalpha(254)
            img.save(path)
            