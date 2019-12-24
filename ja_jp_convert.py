from pykakasi import kakasi as ka
from json import loads as l, dumps as d

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
	j[key] = conv.do(j[key]).replace('aa','ā').replace('ou','ō').replace('oo','ō').replace('nippon','nihon').replace('ii','ī').replace('uu','ū')

with open('ja_rj.json', 'w') as f:
	f.write(d(j, indent=4))
