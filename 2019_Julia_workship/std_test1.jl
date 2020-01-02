using Profile
using Statistics 

function std_test1!(z::Matrix)
    for i in 1:size(z, 2)
        col_mean = mean(z[:, i])
        col_std  = std(z[:, i])
        z[:, i] .= (z[:, i] .- col_mean) ./ col_std
    end
    return z
end

# wrap everything in functions to avoid global scope 
function run()
	z = rand(10000, 10000)
	std_test1!(z) 	    # force compilation
	Profile.clear_malloc_data() # clear allocation counters
	std_test1!(z) 	    # force compilation
end

run()