# Usage "--string test"

# Create a base64 string
# Useful for create base64 strings since K8s requires them as secrets
# You can then add these as GitHub repo secrets and include them in your CI pipeline!

import base64
import argparse

# Instantiate the parser
parser = argparse.ArgumentParser(description='Create a base64 encoded string')
parser.add_argument("--string", help="the name of the string to encode", type=str, required=True)
args = parser.parse_args()

message = args.string
message_bytes = message.encode('ascii')
base64_bytes = base64.b64encode(message_bytes)
base64_message = base64_bytes.decode('ascii')

print(base64_message)
