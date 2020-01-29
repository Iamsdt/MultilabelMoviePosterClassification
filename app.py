from flask import Flask, request, jsonify
from . import model

app = Flask(__name__)


@app.route('/')
def hello_world():
    return 'Hello World!'


@app.route('/analysis/', methods=['POST', 'GET'])
def analysis():
    if request.method == 'POST':
        img = request.get_json()
        print(str(img['img']))
        response = model.predict(img)
        data = {
            "response": 1,
            "result": response
        }
        print(data)
        return jsonify(
            data)
    else:
        data = {
            "response": 0,
            "result": "Send post request"
        }
        return jsonify(
            data)


if __name__ == '__main__':
    app.run()
