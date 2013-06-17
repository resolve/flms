# Returns a copy of the given array with duplicates removed.
modularity.array_unique = (array) ->
  output = {}
  output[array[i]] = array[i] for i in [0...array.length]
  value for key, value of output

