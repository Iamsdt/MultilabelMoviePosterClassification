from flask import Flask, request, jsonify
import tensorflow as tf
import numpy as np
import base64
import io
from PIL import Image

classes = ['Family', 'Sport', 'Short', 'Drama', 'News', 'Thriller', 'History',
           'Sci-Fi', 'Adventure', 'Fantasy', 'Comedy', 'Music', 'Reality-TV',
           'War', 'Action', 'Biography', 'Western', 'Animation', 'Crime',
           'Mystery', 'Horror', 'Musical', 'Romance', 'Documentary']


def load():
    path = "./model/model.tflite"
    model = tf.lite.Interpreter(path)
    model.allocate_tensors()
    return model


def preprocess(raw_img):
    raw = raw_img.decode()
    raw = base64.b64decode(str(raw))
    image_data = Image.open(io.BytesIO(raw))
    resized = image_data.resize((350, 350))
    arr = np.asarray(resized)
    img = arr / 255.0
    # img = img.reshape( 350, 350, 3)
    img = np.expand_dims(img, axis=0).astype(np.float32)
    return img


def get_labels(y):
    li = len(np.where(y > 0.15)[1])
    pred = np.argsort(y)[0][:-li:-1]
    labels = []
    for i in pred:
        labels.append(classes[i])

    ## if labels more than 4
    ## drop last
    if len(labels) > 4:
        return labels[:4]
    else:
        return labels


def predict(raw):
    model = load()
    img = preprocess(raw)
    inp = model.get_input_details()[0]["index"]
    out = model.get_output_details()[0]["index"]

    model.set_tensor(inp, img)
    model.invoke()
    pred = model.get_tensor(out)

    return get_labels(pred)


app = Flask(__name__)


@app.route('/')
def hello_world():
    return 'Hello World!'


@app.route('/analysis/', methods=['POST', 'GET'])
def analysis():
    if request.method == 'POST':
        img = request.data
        print(type(img))
        print(img)
        response = predict(img)
        data = {
            "result": response
        }
        return jsonify(
            data)
    else:
        data = {
            "result": "Send post request"
        }
        return jsonify(
            data)


if __name__ == '__main__':
    app.run()
