from flask import Flask, jsonify
app = Flask(__name__)

@app.route('/api/healthcheck')
def hello():
	return jsonify({"status": 200, "message": "OK"})

if __name__ == '__main__':
	app.run(host='0.0.0.0', port=80)
