make all
rm FinOut*
# Reading the path to push_swap and checker
printf "\n\n\n\n\n" 
echo -e "\e[94mPlease enter the relative path to push swap executable\n"
read path_to_ps
echo -e "Path entered is \e[92m$path_to_ps"
echo -e "\e[94m"

# Copying and Giving the executable permissions
cp $path_to_ps/push_swap .
cp $path_to_ps/checker_linux .
chmod +x push_swap
chmod +x checker_linux


# Main loop to process everything 
# 'i' determines the number of args to provide
while [ "$exit_cond" != "exit" ]
do
    echo -e "Please enter the number of cases to run\n"
    read test_num
    echo -e "Number of test cases for each scenario is \e[92m$test_num \e[94m"
    for i in 3 5 100 500 
    do
        echo -e "\e[94m----------------------------------------------" >> FinOut
        for j in $(seq 1 $test_num)
        do
            ARG=`ruby -e "puts (1..$i).to_a.shuffle.join(' ')"`
            ./push_swap $ARG | wc -l >> output$i
            ./push_swap $ARG | ./checker_linux $ARG >> outputsort$i
        done
        echo -e "Number of \e[92m ARGS - [$i]" >> FinOut
        echo -e "\e[38;5;186m" >> FinOut
        ./tester_ps output$i  >> FinOut
        echo -e "\e[92mNumber of OK:" >> FinOut
        cat outputsort$i | grep "OK" | wc -l >> FinOut
        echo "" >> FinOut
        echo -e  "\e[91mNumber of KO:" >> FinOut
        cat outputsort$i | grep "KO" | wc -l >> FinOut
        echo -e "\e[94m" >> FinOut
        echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" >> FinOut
    done
    echo "Please enter 'exit' to quit or any other key to start again"
    read exit_cond
done
echo "Done"
cat FinOut
make cleanall
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      