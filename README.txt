Link για την ιστοσελιδά του να κατεβάσεις το artillery

https://www.artillery.io/docs/get-started/get-artillery

Για να τρέξει το load test και να φτιάξει report είναι το εξής (να το τρέξεις από το terminal του artillery φακέλου):

artillery run -o nginx-pseudo-streaming-report.json nginx-artillery-testing.yaml

Για να φτιάξει το html αρχείο, που φαίνεται καλύτερο τα στοιχεία

artillery report nginx-pseudo-streaming-report.json 