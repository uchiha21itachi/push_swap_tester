make all
rm FinOut*

#Declaring colors for interface
blue=\\033[94m
green=\\033[92m
red=\\033[91m
beige=\\033[9m
checker=checker_Mac
# Reading the path to push_swap and checker
printf "\n\n\n\n\n" 
echo -e "$blue Please enter the relative path to push swap executable\n"
read path_to_ps
echo -e "Path entered is $green s$path_to_ps"
echo -e "$blue"

# Copying and Giving the executable permissions
cp $path_to_ps/push_swap .
cp $path_to_ps/$checker .
chmod +x push_swap
chmod +x $checker


# Main loop to process everything 
# 'i' determines the number of args to provide
while [ "$exit_cond" != "exit" ]
do
    echo -e "Please enter the number of cases to run\n"
    read test_num
    echo -e "Number of test cases for each scenario is $green $test_num $blue"
    for i in 3 5 100 500 
    do
        echo -e "$blue----------------------------------------------" >> FinOut
        for j in $(seq 1 $test_num)
        do
            ARG=`ruby -e "puts (1..$i).to_a.shuffle.join(' ')"`
            ./push_swap $ARG | wc -l >> output$i
            ./push_swap $ARG | ./$checker $ARG >> outputsort$i
        done
        echo -e "Number of $green ARGS - [$i]" >> FinOut
        echo -e "$blue" >> FinOut
        ./tester_ps output$i  >> FinOut
        echo -e "$green Number of OK:" >> FinOut
        cat outputsort$i | grep "OK" | wc -l >> FinOut
        echo "" >> FinOut
        echo -e  "$red Number of KO:" >> FinOut
        cat outputsort$i | grep "KO" | wc -l >> FinOut
        echo -e "$blue" >> FinOut
        echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" >> FinOut
    done
    echo "Please enter 'exit' to quit or any other key to start again"
    read exit_cond
done
echo "Done"
cat FinOut
make cleanall
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
