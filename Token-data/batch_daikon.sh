verisol_test=./verisol_test
for file in $(ls ./Token-data/result/*.inv.json)
do
    IN=$(basename $file)
    arrIN=(${IN//-/ })
    address=${arrIN[0]}  
    echo $address
    timeout 1800 python3 -m invconplus.daikon.main --metaData ./tmp/$address.json 
done

