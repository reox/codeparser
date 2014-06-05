import argparse
import string
import sys
import re

parser = argparse.ArgumentParser()
parser.add_argument("--file", help="file to parse")
parser.add_argument("--method", help="method name to extract")
args = parser.parse_args()


if args.file == None or args.method == None:
    print "give file and method argument"
    sys.exit(1)

content = open(args.file, 'r').read()

found = False
counter = 0
for line in string.split(content, '\n'):
# we want a string like this: (public|private|protected (\w) <methodname>(.*^)){)
    if re.match("[ \t]+(public|private|protected){0,1}[ ]+(static|)[ ]*[A-Za-z0-9\[\]]+ %s[ ]*\([A-Za-z0-9\[\], ]*\)[ ]*(throws [A-Za-z0-9, ]+|)\{.*" %args.method,line):
        found = True

    if found:
        print line
        counter+=line.count('{')
        counter-=line.count('}')
        if counter == 0:
            found = False
