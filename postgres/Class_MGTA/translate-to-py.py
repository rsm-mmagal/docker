def my_function(x):
    if x < -2:
        return 4
    elif x>2:
        return 4
    else:
        return abs(x)+2

my_result = 0
for i in range(-1,2):
    my_result = my_result +my_function(i)

print(my_result)
