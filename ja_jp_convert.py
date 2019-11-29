from pykakasi import kakasi as ka
from json import loads as l

with open('ja_jp.json', 'r') as f:
	srt=f.read()

j=l(srt)
k=ka()
k.setMode('J','aF')
# conv=k.getConverter()

# for key in j:
# 	j[key] = conv.do(j[key])

k.setMode('K','aF')
conv=k.getConverter()

for key in j:
	j[key] = conv.do(j[key]).replace('aa','ā').replace('ou','ō').replace('ii','ī').replace('uu','ū')

print(j)