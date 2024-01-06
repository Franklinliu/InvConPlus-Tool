for file in $(ls ./out-25-Oct-ERC20)
do 
NAME=${file#out-25-Oct-ERC20}  # retain the part after the prefix
#echo $file
#echo $NAME
mv ./out-25-Oct-ERC20/$file ./out-25-Oct-ERC20/$NAME
done 
