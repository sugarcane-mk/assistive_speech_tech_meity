import sys

SPK=sys.argv[1]
s1={}  

with open("text_"+SPK,"r") as f:
     lt=f.readlines()
     
for line in lt:
    l_all=line.split()
    utt=l_all[0]
    sent=" ".join(l_all[1::])
    
    s1[utt]=sent
    
with open("test_one/text","w") as f:
     with open("output_MONO.txt") as g:
          pred=g.readlines()
          for l in pred:
               utt=l.split()[0]
               sent_id=utt.split('_')[0]
               f.write(utt+" "+'SIL'+" "+s1[sent_id]+" "+"SIL"+'\n')
               
               
