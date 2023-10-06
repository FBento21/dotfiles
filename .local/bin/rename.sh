#/bin/bash

count=1
for i in *.jpg ; do
    count_string=$count
    count_string+='_wall.jpg'
    mv $i $count_string
    ((count++))
done
