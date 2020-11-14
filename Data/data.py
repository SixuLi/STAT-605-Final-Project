import gzip
import simplejson
import pandas as pd
import csv

def parse(filename):
    f = gzip.open(filename, 'r')
    entry = {}
    for l in f:
        l = l.decode().strip()
        colonPos = l.find(':')
        if colonPos == -1:
            yield  entry
            entry = { }
            continue
        eName = l[:colonPos]
        rest = l[colonPos+2:]
        entry[eName] = rest
    yield entry

def getDF(path):
    i = 0
    df = {}
    for d in parse(path):
        if i >= 10000:
            break
        df[i] = d
        i += 1

    return pd.DataFrame.from_dict(df, orient='index')

df = getDF('../all.txt.gz')
df.to_csv('raw_data.csv', index=False)
print(df)







