using Distances
using Random

"""
Naive implementation of k-means clustering. 

# Inputs
+ `data`: a vector of nodes. Each node is a vector with n-dimension
+ `k`: number of desired clusters 

# Output
+ `centers`: `k` estimated cluster centers
+ `clusters`: each cluster's members 
"""
function kmeans(data::Vector{Vector{Float64}}, k::Int)
    dim   = length(data[1])                # number of dimension for each data
    nodes = length(data)                   # total number of data points
    centers  = [randn(dim) for i in 1:k]   # randomly initialize k cluster centers
    clusters = [Int[] for i in 1:k]        # vector storing each cluster's nodes
    new_center = zeros(dim)                # preallocated vector for efficiency
    # run 100 iterations of k-means
    for iter in 1:1000
        # assign each node to the nearest cluster
        empty!.(clusters) # refresh cluster members
        for i in 1:nodes
            best_dist = Inf
            destin = 0
            for j in 1:k
                dist = euclidean(data[i], centers[j])
                if dist < best_dist
                    destin = j
                    best_dist = dist
                end
            end
            push!(clusters[destin], i)
        end
        # update cluster centers by computing mean of each cluster
        for c in 1:k
            fill!(new_center, 0.0) # refresh new cluster center
            # loop through each node in cluster cluster
            for i in 1:length(clusters[c])
                node = clusters[c][i]     # current node
                new_center .+= data[node] # add dimensions to new center
            end
            new_center ./= length(clusters[c])
            centers[c] .= new_center
        end
    end
    return centers, clusters
end

Random.seed!(203)
n = 100
cluster1 = [[randn() - 3, randn()] for i in 1:n]
cluster2 = [[randn() + 3, randn()] for i in 1:n]

# scatter(cluster1)
# scatter!(cluster2)

data = [cluster1; cluster2]

centers, clusters = kmeans(data, 2)
